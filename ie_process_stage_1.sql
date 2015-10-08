-- Always have one or more blank lines between statements (after ;)
-- No blank lines within statements.
-- Can have multi-line statementents.
-- Only this kind of comments: -- 
-- No blank line after comments.
-- Okay to have lines of a statement commented out.
--
--
truncate table table_filing_ids_ie;

insert table_filing_ids_ie (OriginTable, filing_id, amend_id)
select 'expn', filing_id, max(amend_id)
from ca_process.ftp_expn
where filing_id <> ''
group by filing_id
;

insert table_filing_ids_ie (OriginTable, filing_id, amend_id)
select 's497', filing_id, max(amend_id)
from ca_process.ftp_s497
group by filing_id
;

insert table_filing_ids_ie (OriginTable, filing_id, amend_id)
select 'smry', filing_id, max(amend_id)
from ca_process.ftp_smry
group by filing_id
;

insert table_filing_ids_ie (OriginTable, filing_id, amend_id)
select 'cvr', filing_id, max(amend_id)
from ca_process.ftp_cvr_campaign_disclosure
group by filing_id
;

truncate table filing_ids_ie;

insert filing_ids_ie (
    filing_id
  , amend_id_to_use
  , expn_amend_id
  , s497_amend_id
  , smry_amend_id
  , cvr_amend_id
  )
select
    filing_id
  , max(amend_id)
  , max(if(OriginTable='expn',amend_id,null))
  , max(if(OriginTable='s497',amend_id,null))
  , max(if(OriginTable='smry',amend_id,null))
  , max(if(OriginTable='cvr',amend_id,null))
from table_filing_ids_ie
group by filing_id
;

set @CurrentYear = year(current_date);

update
  filing_ids_ie a
  join (
    select 
        filing_id
      , count(distinct session_id) 'cycle_count'
      , min(if(session_id between 1999 and (@CurrentYear + 10), session_id, null)) 'FirstElectionCycle'
    from ca_process.ftp_filer_filings
    where form_id in ('F465','F496')
    group by filing_id
    having cycle_count > 1
    ) b using (filing_id)
set a.FirstElectionCycle = b.FirstElectionCycle
;

drop table if exists independent_expenditure_filings_temp;

create table independent_expenditure_filings_temp like independent_expenditure_filings_new;

-- *** supporting table insert: expn ***
insert into independent_expenditure_filings_temp (
    Form
  , Schedule
  , ElectionCycle
  , ElectionCvrOriginal
  , ElectionCvr
  , Election
  , FilingID
  , AmendID
  , LineItem
  , RecType
  , TranID
  , ExpenditureCode
  , MemoRefNo
  , MemoCode
  , ExpenditureDscr
  , FilingDateStartOriginal
  , FilingDateEndOriginal
  , ExpenditureDateOriginal
  , FilingDateStart
  , FilingDateEnd
  , ExpenditureDate
  , AmountOriginal
  , Amount
  , FiledDate
  , ExpenderIDLegacy
  , ExpenderID
  , ExpenderName
  , ExpenderCity
  , ExpenderState
  , ExpenderZipCode
  , ExpenderEntity
  , ExpenditureEntity
  , ExpenderCommitteeType
  , ExpenderPositionExpenditure
  , ExpenderPositionCvr
  , TargetCandidateNameCvr
  , TargetCandidateNameExpenditure
  , TargetCandidateOfficeCode
  , TargetCandidateOfficeCustom
  , TargetCandidateOfficeSoughtOrHeldOriginal
  , TargetCandidateOfficeSoughtOrHeld
  , TargetCandidateDistrict
  , TargetCandidateJurisdictionCode
  , TargetCandidateJurisdictionCustom
  , TargetPropositionNameOriginal
  , TargetPropositionNumber
  , TargetPropositionJurisdictionOriginal
  , PayeeName
  , PayeeCity
  , PayeeState
  , PayeeZipCode
  , PayeeCommitteeIDOriginal
  , PayeeCommitteeID
  , AgentName
  , OriginTable
  )
select
    ftp_cvr_campaign_disclosure.form_type as Form
  , expenditures.form_type as Schedule
  , ifnull(filing_ids.FirstElectionCycle,ftp_filer_filings.session_id) as ElectionCycle
  , ftp_cvr_campaign_disclosure.elect_date as ElectionCvrOriginal
  , str_to_date(left(ftp_cvr_campaign_disclosure.elect_date,locate(' ',ftp_cvr_campaign_disclosure.elect_date)-1), '%m/%d/%Y') as ElectionCvr
  , str_to_date(left(ftp_cvr_campaign_disclosure.elect_date,locate(' ',ftp_cvr_campaign_disclosure.elect_date)-1), '%m/%d/%Y') as Election
  , expenditures.filing_id as FilingID
  , expenditures.amend_id as AmendID
  , expenditures.line_item as LineItem
  , expenditures.rec_type as RecType
  , expenditures.tran_id as TranID
  , ifnull(expenditures.expn_code,'') as ExpenditureCode
  , ifnull(expenditures.memo_refno,'') as MemoRefNo
  , ifnull(expenditures.memo_code,'') as MemoCode
  , ifnull(expenditures.expn_dscr,'') as ExpenditureDscr
  , ftp_cvr_campaign_disclosure.from_date as FilingDateStartOriginal
  , ftp_cvr_campaign_disclosure.thru_date as FilingDateEndOriginal
  , ifnull(expenditures.expn_date,'') as ExpenditureDateOriginal
  , str_to_date(left(ftp_cvr_campaign_disclosure.from_date,locate(' ',ftp_cvr_campaign_disclosure.from_date)-1),'%m/%d/%Y') as FilingDateStart
  , str_to_date(left(ftp_cvr_campaign_disclosure.thru_date,locate(' ',ftp_cvr_campaign_disclosure.thru_date)-1),'%m/%d/%Y') as FilingDateEnd
  , str_to_date(left(expenditures.expn_date,locate(' ',expenditures.expn_date)-1),'%m/%d/%Y') as ExpenditureDate
  , ifnull(expenditures.amount,'') as AmountOriginal
  , ifnull(expenditures.amount,0) as Amount
  , str_to_date(ftp_filer_filings.filing_date,'%m/%d/%Y %h:%i:%s %p') as FiledDate
  , ftp_cvr_campaign_disclosure.filer_id as ExpenderIDLegacy
  , ftp_filer_filings.filer_id as ExpenderID
  , concat(
        ftp_cvr_campaign_disclosure.filer_naml
      , if(ftp_cvr_campaign_disclosure.filer_namf > '', concat(', ',ftp_cvr_campaign_disclosure.filer_namf), '')
      ) as ExpenderName
  , ftp_cvr_campaign_disclosure.filer_city as ExpenderCity
  , ftp_cvr_campaign_disclosure.filer_st as ExpenderState
  , ftp_cvr_campaign_disclosure.filer_zip4 as ExpenderZipCode
  , ftp_cvr_campaign_disclosure.entity_cd as ExpenderEntity
  , expenditures.entity_cd as ExpenditureEntity
  , ftp_cvr_campaign_disclosure.cmtte_type as ExpenderCommitteeType
  , ifnull(expenditures.sup_opp_cd,'') as ExpenderPositionExpenditure
  , ftp_cvr_campaign_disclosure.sup_opp_cd as ExpenderPositionCvr
  , concat(
        ftp_cvr_campaign_disclosure.cand_naml
      , if(ftp_cvr_campaign_disclosure.cand_namf > '', concat(', ',ftp_cvr_campaign_disclosure.cand_namf), '')
      ) as TargetCandidateNameCvr
  , concat(
        ifnull(expenditures.cand_naml,'')
      , if(ifnull(expenditures.cand_namf,'') <> '', concat(', ',expenditures.cand_namf), '')
      ) as TargetCandidateNameExpenditure
  , if(length(ftp_cvr_campaign_disclosure.office_cd)=3,ftp_cvr_campaign_disclosure.office_cd,'') as TargetCandidateOfficeCode
  , ftp_cvr_campaign_disclosure.offic_dscr as TargetCandidateOfficeCustom
  , ftp_cvr_campaign_disclosure.off_s_h_cd as TargetCandidateOfficeSoughtOrHeldOriginal
  , ftp_cvr_campaign_disclosure.off_s_h_cd as TargetCandidateOfficeSoughtOrHeld
  , ftp_cvr_campaign_disclosure.dist_no as TargetCandidateDistrict
  , ftp_cvr_campaign_disclosure.juris_cd as TargetCandidateJurisdictionCode
  , ftp_cvr_campaign_disclosure.juris_dscr as TargetCandidateJurisdictionCustom
  , ftp_cvr_campaign_disclosure.bal_name as TargetPropositionNameOriginal
  , ftp_cvr_campaign_disclosure.bal_num as TargetPropositionNumber
  , ftp_cvr_campaign_disclosure.bal_juris as TargetPropositionJurisdictionOriginal
  , concat(
        expenditures.payee_naml
      , if(expenditures.payee_namf > '', concat(', ',expenditures.payee_namf), '')
      ) as PayeeName
  , ifnull(expenditures.payee_city,'') as PayeeCity
  , ifnull(expenditures.payee_st,'') as PayeeState
  , ifnull(expenditures.payee_zip4,'') as PayeeZipCode
  , ifnull(expenditures.cmte_id,'') as PayeeCommitteeIDOriginal
  , ifnull(expenditures.cmte_id,'') as PayeeCommitteeID
  , concat(
        expenditures.agent_naml
      , if(expenditures.agent_namf > '', concat(', ',expenditures.agent_namf), '')
      ) as AgentName
  , 'expn' as OriginTable
from
  ca_process.ftp_expn as expenditures
  inner join filing_ids_ie as filing_ids
    on expenditures.filing_id = filing_ids.filing_id
    and expenditures.amend_id = filing_ids.amend_id_to_use
  inner join ca_process.ftp_cvr_campaign_disclosure
    on expenditures.filing_id = ftp_cvr_campaign_disclosure.filing_id
    and expenditures.amend_id = ftp_cvr_campaign_disclosure.amend_id
  inner join ca_process.disclosure_filer_ids on ftp_cvr_campaign_disclosure.filer_id = disclosure_filer_ids.disclosure_filer_id
  inner join ca_process.ftp_filer_filings
    on disclosure_filer_ids.filer_id = ftp_filer_filings.filer_id
    and expenditures.filing_id = ftp_filer_filings.filing_id
    and ftp_cvr_campaign_disclosure.form_type = ftp_filer_filings.form_id
    and expenditures.amend_id = ftp_filer_filings.filing_sequence
;

-- *** supporting table insert: s496 ***
insert into independent_expenditure_filings_temp (
    Form
  , Schedule
  , ElectionCycle
  , ElectionCvrOriginal
  , ElectionCvr
  , Election
  , FilingID
  , AmendID
  , LineItem
  , RecType
  , TranID
  , MemoRefNo
  , MemoCode
  , ExpenditureDscr
  , FilingDateStartOriginal
  , FilingDateEndOriginal
  , ExpenditureDateOriginal
  , FilingDateStart
  , FilingDateEnd
  , ExpenditureDate
  , AmountOriginal
  , Amount
  , FiledDate
  , ExpenderIDLegacy
  , ExpenderID
  , ExpenderName
  , ExpenderCity
  , ExpenderState
  , ExpenderZipCode
  , ExpenderEntity
  , ExpenderCommitteeType
  , ExpenderPositionCvr
  , TargetCandidateNameCvr
  , TargetCandidateOfficeCode
  , TargetCandidateOfficeCustom
  , TargetCandidateOfficeSoughtOrHeldOriginal
  , TargetCandidateOfficeSoughtOrHeld
  , TargetCandidateDistrict
  , TargetCandidateJurisdictionCode
  , TargetCandidateJurisdictionCustom
  , TargetPropositionNameOriginal
  , TargetPropositionNumber
  , TargetPropositionJurisdictionOriginal
  , OriginTable
  )
select
    ftp_cvr_campaign_disclosure.form_type as Form
  , expenditures.form_type as Schedule
  , ifnull(filing_ids.FirstElectionCycle,ftp_filer_filings.session_id) as ElectionCycle
  , ftp_cvr_campaign_disclosure.elect_date as ElectionCvrOriginal
  , str_to_date(left(ftp_cvr_campaign_disclosure.elect_date,locate(' ',ftp_cvr_campaign_disclosure.elect_date)-1), '%m/%d/%Y') as ElectionCvr
  , str_to_date(left(ftp_cvr_campaign_disclosure.elect_date,locate(' ',ftp_cvr_campaign_disclosure.elect_date)-1), '%m/%d/%Y') as Election
  , expenditures.filing_id as FilingID
  , expenditures.amend_id as AmendID
  , expenditures.line_item as LineItem
  , expenditures.rec_type as RecType
  , expenditures.tran_id as TranID
  , ifnull(expenditures.memo_refno,'') as MemoRefNo
  , ifnull(expenditures.memo_code,'') as MemoCode
  , ifnull(expenditures.expn_dscr,'') as ExpenditureDscr
  , ftp_cvr_campaign_disclosure.from_date as FilingDateStartOriginal
  , ftp_cvr_campaign_disclosure.thru_date as FilingDateEndOriginal
  , ifnull(expenditures.exp_date,'') as ExpenditureDateOriginal
  , str_to_date(left(ftp_cvr_campaign_disclosure.from_date,locate(' ',ftp_cvr_campaign_disclosure.from_date)-1),'%m/%d/%Y') as FilingDateStart
  , str_to_date(left(ftp_cvr_campaign_disclosure.thru_date,locate(' ',ftp_cvr_campaign_disclosure.thru_date)-1),'%m/%d/%Y') as FilingDateEnd
  , str_to_date(left(expenditures.exp_date,locate(' ',expenditures.exp_date)-1),'%m/%d/%Y') as ExpenditureDate
  , ifnull(expenditures.amount,'') as AmountOriginal
  , ifnull(expenditures.amount,0) as Amount
  , str_to_date(ftp_filer_filings.filing_date,'%m/%d/%Y %h:%i:%s %p') as FiledDate
  , ftp_cvr_campaign_disclosure.filer_id as ExpenderIDLegacy
  , ftp_filer_filings.filer_id as ExpenderID
  , concat(
        ftp_cvr_campaign_disclosure.filer_naml
      , if(ftp_cvr_campaign_disclosure.filer_namf > '', concat(', ',ftp_cvr_campaign_disclosure.filer_namf), '')
      ) as ExpenderName
  , ftp_cvr_campaign_disclosure.filer_city as ExpenderCity
  , ftp_cvr_campaign_disclosure.filer_st as ExpenderState
  , ftp_cvr_campaign_disclosure.filer_zip4 as ExpenderZipCode
  , ftp_cvr_campaign_disclosure.entity_cd as ExpenderEntity
  , ftp_cvr_campaign_disclosure.cmtte_type as ExpenderCommitteeType
  , ftp_cvr_campaign_disclosure.sup_opp_cd as ExpenderPositionCvr
  , concat(
        ftp_cvr_campaign_disclosure.cand_naml
      , if(ftp_cvr_campaign_disclosure.cand_namf > '', concat(', ',ftp_cvr_campaign_disclosure.cand_namf), '')
      ) as TargetCandidateNameCvr
  , if(length(ftp_cvr_campaign_disclosure.office_cd)=3,ftp_cvr_campaign_disclosure.office_cd,'') as TargetCandidateOfficeCode
  , ftp_cvr_campaign_disclosure.offic_dscr as TargetCandidateOfficeCustom
  , ftp_cvr_campaign_disclosure.off_s_h_cd as TargetCandidateOfficeSoughtOrHeldOriginal
  , ftp_cvr_campaign_disclosure.off_s_h_cd as TargetCandidateOfficeSoughtOrHeld
  , ftp_cvr_campaign_disclosure.dist_no as TargetCandidateDistrict
  , ftp_cvr_campaign_disclosure.juris_cd as TargetCandidateJurisdictionCode
  , ftp_cvr_campaign_disclosure.juris_dscr as TargetCandidateJurisdictionCustom
  , ftp_cvr_campaign_disclosure.bal_name as TargetPropositionNameOriginal
  , ftp_cvr_campaign_disclosure.bal_num as TargetPropositionNumber
  , ftp_cvr_campaign_disclosure.bal_juris as TargetPropositionJurisdictionOriginal
  , 's496' as OriginTable
from
  ca_process.ftp_s496 as expenditures
  inner join filing_ids_ie as filing_ids
    on expenditures.filing_id = filing_ids.filing_id
    and expenditures.amend_id = filing_ids.amend_id_to_use
  inner join ca_process.ftp_cvr_campaign_disclosure
    on expenditures.filing_id = ftp_cvr_campaign_disclosure.filing_id
    and expenditures.amend_id = ftp_cvr_campaign_disclosure.amend_id
  inner join ca_process.disclosure_filer_ids on ftp_cvr_campaign_disclosure.filer_id = disclosure_filer_ids.disclosure_filer_id
  inner join ca_process.ftp_filer_filings
    on disclosure_filer_ids.filer_id = ftp_filer_filings.filer_id
    and expenditures.filing_id = ftp_filer_filings.filing_id
    and ftp_cvr_campaign_disclosure.form_type = ftp_filer_filings.form_id
    and expenditures.amend_id = ftp_filer_filings.filing_sequence
  left join ca_process.filer_ids on ftp_filer_filings.filer_id = filer_ids.filer_id
;

-- *** supporting table insert: smry ***
insert into independent_expenditure_filings_temp (
    Form
  , Schedule
  , ElectionCycle
  , ElectionCvrOriginal
  , ElectionCvr
  , Election
  , ElectionSmryOriginal
  , ElectionSmry
  , FilingID
  , AmendID
  , LineItem
  , RecType
  , FilingDateStartOriginal
  , FilingDateEndOriginal
  , FilingDateStart
  , FilingDateEnd
  , AmountOriginal
  , AmountOriginal2
  , AmountOriginal3
  , Amount
  , FiledDate
  , ExpenderIDLegacy
  , ExpenderID
  , ExpenderName
  , ExpenderCity
  , ExpenderState
  , ExpenderZipCode
  , ExpenderEntity
  , ExpenderCommitteeType
  , ExpenderPositionCvr
  , TargetCandidateNameCvr
  , TargetCandidateOfficeCode
  , TargetCandidateOfficeCustom
  , TargetCandidateOfficeSoughtOrHeldOriginal
  , TargetCandidateOfficeSoughtOrHeld
  , TargetCandidateDistrict
  , TargetCandidateJurisdictionCode
  , TargetCandidateJurisdictionCustom
  , TargetPropositionNameOriginal
  , TargetPropositionNumber
  , TargetPropositionJurisdictionOriginal
  , Unitemized
  , OriginTable
  )
select
    ftp_cvr_campaign_disclosure.form_type as Form
  , expenditures.form_type as Schedule
  , ifnull(filing_ids.FirstElectionCycle,ftp_filer_filings.session_id) as ElectionCycle
  , ftp_cvr_campaign_disclosure.elect_date as ElectionCvrOriginal
  , str_to_date(left(ftp_cvr_campaign_disclosure.elect_date,locate(' ',ftp_cvr_campaign_disclosure.elect_date)-1), '%m/%d/%Y') as ElectionCvr
  , str_to_date(left(ftp_cvr_campaign_disclosure.elect_date,locate(' ',ftp_cvr_campaign_disclosure.elect_date)-1), '%m/%d/%Y') as Election
  , expenditures.elec_dt as ElectionSmryOriginal
  , str_to_date(left(expenditures.elec_dt,locate(' ',expenditures.elec_dt)-1), '%m/%d/%Y') as ElectionSmry
  , expenditures.filing_id as FilingID
  , expenditures.amend_id as AmendID
  , expenditures.line_item as LineItem
  , expenditures.rec_type as RecType
  , ftp_cvr_campaign_disclosure.from_date as FilingDateStartOriginal
  , ftp_cvr_campaign_disclosure.thru_date as FilingDateEndOriginal
  , str_to_date(left(ftp_cvr_campaign_disclosure.from_date,locate(' ',ftp_cvr_campaign_disclosure.from_date)-1),'%m/%d/%Y') as FilingDateStart
  , str_to_date(left(ftp_cvr_campaign_disclosure.thru_date,locate(' ',ftp_cvr_campaign_disclosure.thru_date)-1),'%m/%d/%Y') as FilingDateEnd
  , ifnull(expenditures.amount_a,'') as AmountOriginal
  , ifnull(expenditures.amount_b,'') as AmountOriginal2
  , ifnull(expenditures.amount_c,'') as AmountOriginal3
  , ifnull(expenditures.amount_a,0) as Amount
  , str_to_date(ftp_filer_filings.filing_date,'%m/%d/%Y %h:%i:%s %p') as FiledDate
  , ftp_cvr_campaign_disclosure.filer_id as ExpenderIDLegacy
  , ftp_filer_filings.filer_id as ExpenderID
  , concat(
        ftp_cvr_campaign_disclosure.filer_naml
      , if(ftp_cvr_campaign_disclosure.filer_namf > '', concat(', ',ftp_cvr_campaign_disclosure.filer_namf), '')
      ) as ExpenderName
  , ftp_cvr_campaign_disclosure.filer_city as ExpenderCity
  , ftp_cvr_campaign_disclosure.filer_st as ExpenderState
  , ftp_cvr_campaign_disclosure.filer_zip4 as ExpenderZipCode
  , ftp_cvr_campaign_disclosure.entity_cd as ExpenderEntity
  , ftp_cvr_campaign_disclosure.cmtte_type as ExpenderCommitteeType
  , ftp_cvr_campaign_disclosure.sup_opp_cd as ExpenderPositionCvr
  , concat(
        ftp_cvr_campaign_disclosure.cand_naml
      , if(ftp_cvr_campaign_disclosure.cand_namf > '', concat(', ',ftp_cvr_campaign_disclosure.cand_namf), '')
      ) as TargetCandidateNameCvr
  , if(length(ftp_cvr_campaign_disclosure.office_cd)=3,ftp_cvr_campaign_disclosure.office_cd,'') as TargetCandidateOfficeCode
  , ftp_cvr_campaign_disclosure.offic_dscr as TargetCandidateOfficeCustom
  , ftp_cvr_campaign_disclosure.off_s_h_cd as TargetCandidateOfficeSoughtOrHeldOriginal
  , ftp_cvr_campaign_disclosure.off_s_h_cd as TargetCandidateOfficeSoughtOrHeld
  , ftp_cvr_campaign_disclosure.dist_no as TargetCandidateDistrict
  , ftp_cvr_campaign_disclosure.juris_cd as TargetCandidateJurisdictionCode
  , ftp_cvr_campaign_disclosure.juris_dscr as TargetCandidateJurisdictionCustom
  , ftp_cvr_campaign_disclosure.bal_name as TargetPropositionNameOriginal
  , ftp_cvr_campaign_disclosure.bal_num as TargetPropositionNumber
  , ftp_cvr_campaign_disclosure.bal_juris as TargetPropositionJurisdictionOriginal
  , 'Y' as Unitemized
  , 'smry' as OriginTable
from
  ca_process.ftp_smry as expenditures
  inner join filing_ids_ie as filing_ids
    on expenditures.filing_id = filing_ids.filing_id
    and expenditures.amend_id = filing_ids.amend_id_to_use
  inner join ca_process.ftp_cvr_campaign_disclosure
    on expenditures.filing_id = ftp_cvr_campaign_disclosure.filing_id
    and expenditures.amend_id = ftp_cvr_campaign_disclosure.amend_id
  inner join ca_process.disclosure_filer_ids on ftp_cvr_campaign_disclosure.filer_id = disclosure_filer_ids.disclosure_filer_id
  inner join ca_process.ftp_filer_filings
    on disclosure_filer_ids.filer_id = ftp_filer_filings.filer_id
    and expenditures.filing_id = ftp_filer_filings.filing_id
    and ftp_cvr_campaign_disclosure.form_type = ftp_filer_filings.form_id
    and expenditures.amend_id = ftp_filer_filings.filing_sequence
where
  ftp_cvr_campaign_disclosure.form_type = 'F465'
;

update independent_expenditure_filings_temp
set TargetCandidateNamePreStandardization = if(
    TargetCandidateNameCvr not in ('','-, -','N/A, N/A','na, na')
  , TargetCandidateNameCvr
  , TargetCandidateNameExpenditure
  )
;

truncate table independent_expenditure_filings_names_to_standardize;

insert independent_expenditure_filings_names_to_standardize (
    ExpenditureFilingID
  , TargetCandidateNamePreStandardization
  )
select 
    ExpenditureFilingID
  , TargetCandidateNamePreStandardization
from independent_expenditure_filings_temp
where 
  Form in ('F465','F496')
  and TargetCandidateNamePreStandardization <> ''
;

update independent_expenditure_filings_names_to_standardize
set TargetCandidateNamePreStandardization = replace(TargetCandidateNamePreStandardization,'Assembly Member','AssemblyMember')
where TargetCandidateNamePreStandardization like '%assembly member%'
;
