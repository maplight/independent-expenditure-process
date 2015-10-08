-- Always have one or more blank lines between statements (after ;)
-- No blank lines within statements.
-- Can have multi-line statementents.
-- Only this kind of comments: -- 
-- No blank line after comments.
-- Okay to have lines of a statement commented out.
--
--
-- name parsing still running?
-- select count(*) from independent_expenditure_filings_names_to_standardize where last_name = '';
--
--
update independent_expenditure_filings_names_to_standardize
set 
    name_prefix = replace(name_prefix,'AssemblyMember','Assembly Member')
  , TargetCandidateNamePreStandardization = replace(TargetCandidateNamePreStandardization,'AssemblyMember','Assembly Member')
where name_prefix like '%assembly%member%'
;

update independent_expenditure_filings_names_to_standardize
set TargetCandidateName = concat(
      if(
          last_name <> ''
        , case
            when last_name = 'Alioto-Pier' then 'Alioto-Pier'
            when last_name = 'Bly-Chester' then 'Bly-Chester'
            when last_name = 'Brathwaite-Burk' then 'Brathwaite-Burk'
            when last_name = 'Cadena-Perez' then 'Cadena-Perez'
            when last_name = 'Christian-Heising' then 'Christian-Heising'
            when last_name = 'Davis-Holmes' then 'Davis-Holmes'
            when last_name = 'de la Fuente' then 'de la Fuente'
            when last_name = 'de la Libertad' then 'de la Libertad'
            when last_name = 'de la Piedra' then 'de la Piedra'
            when last_name = 'de la Rosa' then 'de la Rosa'
            when last_name = 'de la Torre' then 'de la Torre'
            when last_name = 'De Latorre' then 'de la Torre'
            when last_name = 'de Leon' then 'de Leon'
            when last_name = 'DeForge' then 'DeForge'
            when last_name = 'DeLara' then 'DeLara'
            when last_name = 'DeLaTorre' then 'DeLaTorre'
            when last_name = 'DeLeon' then 'DeLeon'
            when last_name = 'DeLong' then 'DeLong'
            when last_name = 'DeMaio' then 'DeMaio'
            when last_name = 'De''Maio' then 'DeMaio'
            when last_name = 'DeSaulnier' then 'DeSaulnier'
            when last_name = 'DeWane' then 'DeWane'
            when last_name = 'Gallardo-Rooker' then 'Gallardo-Rooker'
            when last_name = 'Gardea-Stinnett' then 'Gardea-Stinnett'
            when last_name = 'Harris-Forster' then 'Harris-Forster'
            when last_name = 'Hinton-Hodge' then 'Hinton-Hodge'
            when last_name = 'Hogan-Rowles' then 'Hogan-Rowles'
            when last_name = 'Hover-Smoot' then 'Hover-Smoot'
            when last_name = 'Huntley-Fenner' then 'Huntley-Fenner'
            when last_name = 'Jones-Sawyer' then 'Jones-Sawyer'
            when last_name = 'LaMalfa' then 'LaMalfa'
            when last_name = 'LaMotte' then 'LaMotte'
            when last_name = 'Lara-Gardner' then 'Lara-Gardner'
            when last_name = 'LaSuer' then 'LaSuer'
            when last_name = 'Lopez-Reid' then 'Lopez-Reid'
            when last_name = 'LoStracco' then 'LoStracco'
            when last_name = 'MacDonald' then 'MacDonald'
            when last_name = 'MacEnery' then 'MacEnery'
            when last_name = 'MacGlashan' then 'MacGlashan'
            when last_name = 'Mansfield-Reinking' then 'Mansfield-Reinking'
            when last_name = 'McAdams' then 'McAdams'
            when last_name = 'McAllister' then 'McAllister'
            when last_name = 'McBay' then 'McBay'
            when last_name = 'McCammack' then 'McCammack'
            when last_name = 'McCammon' then 'McCammon'
            when last_name = 'McCann' then 'McCann'
            when last_name = 'McCarthy' then 'McCarthy'
            when last_name = 'McCarty' then 'McCarty'
            when last_name = 'McCaulley' then 'McCaulley'
            when last_name = 'McClanahan' then 'McClanahan'
            when last_name = 'McClintock' then 'McClintock'
            when last_name = 'McCoy' then 'McCoy'
            when last_name = 'McDaniel' then 'McDaniel'
            when last_name = 'McEachron' then 'McEachron'
            when last_name = 'McGill' then 'McGill'
            when last_name = 'McGlashan' then 'McGlashan'
            when last_name = 'McGlodrick' then 'McGlodrick'
            when last_name = 'McGrath' then 'McGrath'
            when last_name = 'McGuire' then 'McGuire'
            when last_name = 'McKenna' then 'McKenna'
            when last_name = 'McKeon' then 'McKeon'
            when last_name = 'McKeown' then 'McKeown'
            when last_name = 'McKillop' then 'McKillop'
            when last_name = 'McKinley' then 'McKinley'
            when last_name = 'McLaughlin' then 'McLaughlin'
            when last_name = 'McLeod' then 'McLeod'
            when last_name = 'McManigal' then 'McManigal'
            when last_name = 'McNeil' then 'McNeil'
            when last_name = 'McNeill' then 'McNeill'
            when last_name = 'McNelis' then 'McNelis'
            when last_name = 'McPherson' then 'McPherson'
            when last_name = 'McSweeney' then 'McSweeney'
            when last_name = 'Mercado-Fortine' then 'Mercado-Fortine'
            when last_name = 'Musser-Lopez' then 'Musser-Lopez'
            when last_name = 'Musser-Mikels' then 'Musser-Mikels'
            when last_name = 'Negrete-McLeod' then 'Negrete-McLeod'
            when last_name = 'O''Connell' then 'O''Connell'
            when last_name = 'O''Connor' then 'O''Connor'
            when last_name = 'O''Donnell' then 'O''Donnell'
            when last_name = 'O''Farrell' then 'O''Farrell'
            when last_name = 'O''Neal' then 'O''Neal'
            when last_name = 'Quick-Silva' then 'Quirk-Silva'
            when last_name = 'Quirk-Silva' then 'Quirk-Silva'
            when last_name = 'Ridley-Thomas' then 'Ridley-Thomas'
            when last_name = 'Scott-Hayes' then 'Scott-Hayes'
            when last_name = 'Seaton-Msemaji' then 'Seaton-Msemaji'
            when last_name = 'Sotelo-Solis' then 'Sotelo-Solis'
            when last_name = 'Sullivan-Pepper' then 'Sullivan-Pepper'
            else functions.cap_first_letter(last_name)
            end
        , ''
        )
    , if(first_name <> '' or middle_name <> '' or name_suffix <> '',',','')
    , if(first_name <> '',concat(' ',functions.cap_first_letter(first_name)),'')
    , if(
        (
          nick_name in (
              'bob'
            , 'rico'
            , 'rj'
            , 'rod'
            , 'sat'
            )
          )
        , concat(' "',nick_name,'"') 
        , ''
        )
    , if(
        (
          length(replace(middle_name,'.','')) > 1 -- no initials
          and length(middle_name) - length(replace(middle_name,' ','')) = 0 -- no spaces
          )
        , concat(' ',functions.cap_first_letter(middle_name))
        , ''
        )
    , if(
        (
          replace(name_suffix,'.','') <> ''
          and name_suffix not in ('Ctbs.','md')
          )
        , concat(' ',replace(if(replace(name_suffix,'.','') in ('jr','sr'),functions.cap_first_letter(name_suffix),name_suffix),'.',''))
        , ''
        )
    )
where 
  TargetCandidateName = ''
  and last_name >= 'a'
  and last_name not in ('act','to')
  and length(last_name) > 1
  and length(middle_name) - length(replace(middle_name,' ','')) = 0
;

update
  independent_expenditure_filings_temp a
  join independent_expenditure_filings_names_to_standardize b using (ExpenditureFilingID)
set a.TargetCandidateName = b.TargetCandidateName
where 
  a.TargetCandidateName = ''
  and b.TargetCandidateName <> ''
;

update independent_expenditure_filings_temp
set TargetCandidateName = TargetCandidateNamePreStandardization
where 
  TargetCandidateName = ''
  and TargetCandidateNamePreStandardization <> ''
;

-- append CandidateID based on synonyms
update
  independent_expenditure_filings_temp e
  join candidate_name_spellings s 
    on e.TargetCandidateName = s.TargetCandidateName
    and e.ElectionCycle = ifnull(s.ElectionCycle,e.ElectionCycle)
set e.TargetCandidateID = s.TargetCandidateID
where e.Form in ('F465','F496')
;

-- append PropositionID based on synonyms
-- using a "left join" and "ifnull" here only because an inner join is inexplicably slow
update
  independent_expenditure_filings_temp e
  left join proposition_name_spellings s using (ElectionCycle, TargetPropositionNumber, TargetPropositionNameOriginal)
set e.TargetPropositionID = ifnull(s.TargetPropositionID,e.TargetPropositionID)
where e.Form in ('F465','F496')
;

-- move CandidateIDs to PropositionIDs when they're in the wrong field
update
  independent_expenditure_filings_temp e
  join ca_process.cal_access_propositions p on e.TargetCandidateID = p.proposition_id
set
    e.TargetPropositionID = e.TargetCandidateID
  , e.TargetCandidateID = 0
where e.TargetPropositionID = 0
;

-- move PropositionIDs to CandidateIDs when they're in the wrong field
update
  independent_expenditure_filings_temp e
  join ca_process.cal_access_candidates c on e.TargetPropositionID = c.id
set
    e.TargetCandidateID = e.TargetPropositionID
  , e.TargetPropositionID = 0
where e.TargetCandidateID = 0
;

drop table if exists temp_candidate_id_names;

create table temp_candidate_id_names (
  TargetCandidateID BIGINT NOT NULL DEFAULT 0,
  TargetCandidateName VARCHAR(250) NOT NULL DEFAULT '',
  Expenditures int not null default 0,
  RowCounter int not null primary key auto_increment
);

insert temp_candidate_id_names (TargetCandidateID, TargetCandidateName, Expenditures)
select TargetCandidateID, TargetCandidateName, count(*) 'Expenditures'
from independent_expenditure_filings_temp
where 
  TargetCandidateID <> 0
  and TargetCandidateName <> ''
group by TargetCandidateID, TargetCandidateName
order by TargetCandidateID, Expenditures desc, TargetCandidateName
;

update
  independent_expenditure_filings_temp e
  join (
    select t.TargetCandidateID, t.TargetCandidateName
    from
      temp_candidate_id_names t
      join (
        select TargetCandidateID, min(RowCounter) 'MinRowCounter'
        from temp_candidate_id_names
        group by TargetCandidateID
        ) t2 
          on t.TargetCandidateID = t2.TargetCandidateID
          and t.RowCounter = t2.MinRowCounter
    ) x using (TargetCandidateID)
set e.TargetCandidateName = x.TargetCandidateName
;  

-- the following commented-out section suspected of being extraneous
-- 
-- drop table if exists temp_proposition_id_cycles;
-- 
-- create table temp_proposition_id_cycles (
--   TargetPropositionID BIGINT NOT NULL DEFAULT 0,
--   ElectionCycle SMALLINT NOT NULL DEFAULT 0,
--   Expenditures int not null default 0,
--   RowCounter int not null primary key auto_increment
-- );
-- 
-- insert temp_proposition_id_cycles (TargetPropositionID, ElectionCycle, Expenditures)
-- select TargetPropositionID, ElectionCycle, count(*) 'Expenditures'
-- from independent_expenditure_filings_temp
-- where TargetPropositionID <> 0
-- group by TargetPropositionID, ElectionCycle
-- order by TargetPropositionID, Expenditures desc, ElectionCycle desc
-- ;
-- 
-- update
--   independent_expenditure_filings_temp e
--   join (
--     select t.TargetPropositionID, t.ElectionCycle
--     from
--       temp_proposition_id_cycles t
--       join (
--         select TargetPropositionID, min(RowCounter) 'MinRowCounter'
--         from temp_proposition_id_cycles
--         group by TargetPropositionID
--         ) t2 
--           on t.TargetPropositionID = t2.TargetPropositionID
--           and t.RowCounter = t2.MinRowCounter
--     ) x using (TargetPropositionID)
-- set e.TargetPropositionCycle = x.ElectionCycle
-- ;  
-- 
drop table if exists temp_proposition_fields;

create table temp_proposition_fields (
    TargetPropositionID bigint not null primary key
  , ScrapedName varchar(250) not null
  , ScrapedName2 varchar(250) not null default ''
  , ParsedNumber varchar(10) not null default ''
  , ParsedName varchar(250) not null default ''
  , TargetPropositionName varchar(250) not null default ''
  , Election date null
  )
;

insert temp_proposition_fields (TargetPropositionID, ScrapedName, Election)
select proposition_id, name, election_date
from ca_process.cal_access_propositions
;

update temp_proposition_fields
set ScrapedName2 = case
      when left(ScrapedName,5) = 'PROP ' then mid(ScrapedName,5,250)
      when left(ScrapedName,12) = 'PROPOSITION ' then mid(ScrapedName,12,250)
      else ScrapedName
      end
;

update temp_proposition_fields
set
    ParsedNumber = rtrim(ltrim(if(
        ScrapedName like 'prop%'
      , left(
            ScrapedName2
          , locate(' - ',ScrapedName2)
          )
      , ''
      )))
  , ParsedName = if(
        ScrapedName like 'prop%'
      , mid(
            ScrapedName2
          , locate(' - ',ScrapedName2) + 3
          , 250
          )
      , ScrapedName
      ) 
;

-- 1x
update temp_proposition_fields
set ParsedNumber = mid(ParsedNumber,2,99)
where ParsedNumber like '0%'
;

-- 2x
update temp_proposition_fields
set ParsedNumber = mid(ParsedNumber,2,99)
where ParsedNumber like '0%'
;

-- 3x (overkill)
update temp_proposition_fields
set ParsedNumber = mid(ParsedNumber,2,99)
where ParsedNumber like '0%'
;

update temp_proposition_fields
set TargetPropositionName = concat(
    if(
        ParsedNumber <> ''
      , concat('Prop ',ParsedNumber,' - ')
      , ''
      )
  , ParsedName
  )
;

update
  independent_expenditure_filings_temp a
  join temp_proposition_fields p using (TargetPropositionID)
set 
    a.TargetPropositionName = p.TargetPropositionName
  , a.Election = ifnull(p.Election,a.Election)
;

update independent_expenditure_filings_temp
set TargetPropositionName = concat(
    if(
        TargetPropositionNumber <> ''
      , concat('Prop ',TargetPropositionNumber,' - ')
      , ''
      )
  , TargetPropositionNameOriginal
  )
where TargetPropositionName = ''
;

update independent_expenditure_filings_temp
set 
  DateStart = ifnull(ExpenditureDate,FilingDateStart)
, DateEnd = ifnull(ExpenditureDate,FilingDateEnd)
, ExpenderPosition = if(
      ExpenderPositionCvr in ('S','O')
    , ExpenderPositionCvr
    , 'U'
    )
;

set @CurrentYear = year(current_date);

update independent_expenditure_filings_temp
set BadElectionCycle = 'Y'
where
  ElectionCycle < 2001
  or ElectionCycle > @CurrentYear + 10
;

update independent_expenditure_filings_temp
set PropositionExpenditure = 'Y'
where 
  TargetPropositionName <> ''
  and (TargetCandidateID = 0 or TargetPropositionID <> 0)
;

update independent_expenditure_filings_temp
set CandidateExpenditure = 'Y'
where 
  PropositionExpenditure = 'N'
  and TargetCandidateName <> ''
;

update
  independent_expenditure_filings_temp ef
  join candidate_jurisdiction_codes c on ef.TargetPropositionJurisdictionOriginal = c.TargetCandidateJurisdictionCode
set 
    ef.TargetPropositionJurisdiction = c.TargetCandidateJurisdiction
  , ef.StateExpenditure = if(c.StateOrLocal='S','Y','N')
  , ef.LocalExpenditure = if(c.StateOrLocal='L','Y','N')
where 
  -- ef.PropositionExpenditure = 'Y' and
  ef.TargetPropositionJurisdiction = ''
  and ef.TargetPropositionJurisdictionOriginal <> 'OTH'
;

update
  independent_expenditure_filings_temp ef
  join candidate_office_codes c on ef.TargetPropositionJurisdictionOriginal = c.TargetCandidateOfficeCode
set 
    ef.TargetPropositionJurisdiction = c.TargetCandidateOffice
  , ef.StateExpenditure = if(c.StateOrLocal='S','Y','N')
  , ef.LocalExpenditure = if(c.StateOrLocal='L','Y','N')
where 
  -- ef.PropositionExpenditure = 'Y' and
  ef.TargetPropositionJurisdiction = ''
  and ef.TargetPropositionJurisdictionOriginal <> 'OTH'
;

update independent_expenditure_filings_temp
set StateExpenditure = 'Y'
where 
  -- PropositionExpenditure = 'Y' and
  TargetPropositionJurisdiction = ''
  and (
    TargetPropositionJurisdictionOriginal like '%state%'
    or TargetPropositionJurisdictionOriginal like '%california%'
    or TargetPropositionJurisdictionOriginal like '%senate%'
    or TargetPropositionJurisdictionOriginal like '%assembly%'
    )
;

update independent_expenditure_filings_temp
set LocalExpenditure = 'Y'
where 
  -- PropositionExpenditure = 'Y' and
  TargetPropositionJurisdiction = ''
  and StateExpenditure = 'N'
  and TargetPropositionJurisdictionOriginal <> ''
;

-- fix a few cases where state expenditures (numeric prop number) have local jurisdictions
update independent_expenditure_filings_temp
set StateExpenditure = 'Y'
where
  PropositionExpenditure = 'Y'
  and LocalExpenditure = 'Y'
  and StateExpenditure = 'N'
  and TargetPropositionNumber >= '0'
  and TargetPropositionNumber < 'a'
;

update independent_expenditure_filings_temp
set TargetPropositionJurisdiction = TargetPropositionJurisdictionOriginal
where 
  -- PropositionExpenditure = 'Y' and
  TargetPropositionJurisdiction = ''
  and TargetPropositionJurisdictionOriginal <> ''
;

update
  independent_expenditure_filings_temp ef
  join candidate_jurisdiction_codes c on ef.TargetCandidateJurisdictionCode = c.TargetCandidateJurisdictionCode
set 
    ef.TargetCandidateJurisdiction = c.TargetCandidateJurisdiction
  , ef.StateExpenditure = if(c.StateOrLocal='S','Y','N')
  , ef.LocalExpenditure = if(c.StateOrLocal='L','Y','N')
where 
  -- ef.CandidateExpenditure = 'Y' and
  ef.TargetCandidateJurisdiction = ''
  and ef.TargetCandidateJurisdictionCode <> 'OTH'
;

update
  independent_expenditure_filings_temp ef
  join candidate_office_codes c on ef.TargetCandidateJurisdictionCode = c.TargetCandidateOfficeCode
set 
    ef.TargetCandidateJurisdiction = c.TargetCandidateOffice
  , ef.StateExpenditure = if(c.StateOrLocal='S','Y','N')
  , ef.LocalExpenditure = if(c.StateOrLocal='L','Y','N')
where 
  -- ef.CandidateExpenditure = 'Y' and
  ef.TargetCandidateJurisdiction = ''
  and ef.TargetCandidateJurisdictionCode <> 'OTH'
;

update
  independent_expenditure_filings_temp ef
  join candidate_jurisdiction_codes c on ef.TargetCandidateJurisdictionCustom = c.TargetCandidateJurisdictionCode
set 
    ef.TargetCandidateJurisdiction = c.TargetCandidateJurisdiction
  , ef.StateExpenditure = if(c.StateOrLocal='S','Y','N')
  , ef.LocalExpenditure = if(c.StateOrLocal='L','Y','N')
where 
  -- ef.CandidateExpenditure = 'Y' and
  ef.TargetCandidateJurisdiction = ''
  and ef.TargetCandidateJurisdictionCustom <> 'OTH'
;

update
  independent_expenditure_filings_temp ef
  join candidate_office_codes c on ef.TargetCandidateJurisdictionCustom = c.TargetCandidateOfficeCode
set 
    ef.TargetCandidateJurisdiction = c.TargetCandidateOffice
  , ef.StateExpenditure = if(c.StateOrLocal='S','Y','N')
  , ef.LocalExpenditure = if(c.StateOrLocal='L','Y','N')
where 
  -- ef.CandidateExpenditure = 'Y' and
  ef.TargetCandidateJurisdiction = ''
  and ef.TargetCandidateJurisdictionCustom <> 'OTH'
;

update independent_expenditure_filings_temp
set StateExpenditure = 'Y'
where 
  -- CandidateExpenditure = 'Y' and
  TargetCandidateJurisdiction = ''
  and (
    TargetCandidateJurisdictionCustom like '%state%'
    or TargetCandidateJurisdictionCustom like '%california%'
    or TargetCandidateJurisdictionCustom like '%senate%'
    or TargetCandidateJurisdictionCustom like '%assembly%'
    )
;

update independent_expenditure_filings_temp
set LocalExpenditure = 'Y'
where 
  -- CandidateExpenditure = 'Y' and
  TargetCandidateJurisdiction = ''
  and (
    TargetCandidateJurisdictionCustom like '%county%'
    or TargetCandidateJurisdictionCustom like '%city%'
    or TargetCandidateJurisdictionCustom like '%cty%'
    or TargetCandidateJurisdictionCustom like '%local%'
    or TargetCandidateJurisdictionCustom like '%judicial%'
    or TargetCandidateJurisdictionCustom like '%los angeles%'
    or TargetCandidateJurisdictionCustom like '%san %'
    or TargetCandidateJurisdictionCustom like '%santa %'
    or TargetCandidateJurisdictionCustom like '%sacramento%'
    or TargetCandidateJurisdictionCustom like '%fresno%'
    or TargetCandidateJurisdictionCustom like '%riverside%'
    or TargetCandidateJurisdictionCustom like '%yucca vall%y%'
    or TargetCandidateJurisdictionCustom like '%la c%ty%'
    or TargetCandidateJurisdictionCustom like '%alameda%'
    or TargetCandidateJurisdictionCustom like '%costa%'
    or TargetCandidateJurisdictionCustom like '%orange%'
    or TargetCandidateJurisdictionCustom like '%oceanside%'
    or TargetCandidateJurisdictionCustom like '%anaheim%'
    or TargetCandidateJurisdictionCustom like '%irvine%'
    or TargetCandidateJurisdictionCustom like '%Montebello%'
    or TargetCandidateJurisdictionCustom like '%Yorba %'
    or TargetCandidateJurisdictionCustom like '%usd%'
    or TargetCandidateJurisdictionCustom like '%fairfax%'
    or TargetCandidateJurisdictionCustom like '%capistrano%'
    or TargetCandidateJurisdictionCustom like '%palo alto%'
    or TargetCandidateJurisdictionCustom like '%hollywood%'
    or TargetCandidateJurisdictionCustom like '%santa%'
    or TargetCandidateJurisdictionCustom like '%rio %'
    or TargetCandidateJurisdictionCustom like '%solano%'
    or TargetCandidateJurisdictionCustom like '%pomona%'
    or TargetCandidateJurisdictionCustom like '%rosemead%'
    or TargetCandidateJurisdictionCustom like '%puente%'
    or TargetCandidateJurisdictionCustom like '%modesto%'
    or TargetCandidateJurisdictionCustom like '%cypress%'
    or TargetCandidateJurisdictionCustom like '%oxnard%'
    or TargetCandidateJurisdictionCustom like '% oaks%'
    or TargetCandidateJurisdictionCustom like '% vista%'
    or TargetCandidateJurisdictionCustom like '% forest%'
    or TargetCandidateJurisdictionCustom like '%lake %'
    or TargetCandidateJurisdictionCustom like '%laguna %'
    or TargetCandidateJurisdictionCustom like '%fullerton%'
    or TargetCandidateJurisdictionCustom like '%west %'
    or TargetCandidateJurisdictionCustom like '%peralta%'
    or TargetCandidateJurisdictionCustom like '%inglewood%'
    or TargetCandidateJurisdictionCustom like '%huntington%'
    or TargetCandidateJurisdictionCustom like '%colfax%'
    or TargetCandidateJurisdictionCustom like '% valley%'
    or TargetCandidateJurisdictionCustom like '%beach%'
    or TargetCandidateJurisdictionCustom like '%carson%'
    or TargetCandidateJurisdictionCustom like '%rancho%'
    or TargetCandidateJurisdictionCustom like '%calpers%'
    or TargetCandidateJurisdictionCustom like '%calstrs%'
    or TargetCandidateJurisdictionCustom like '%school%'
    or TargetCandidateJurisdictionCustom like '%college%'
    or TargetCandidateJurisdictionCustom like '%elementary%'
    or TargetCandidateJurisdictionCustom like '%water%'
    or TargetCandidateJurisdictionCustom like '% usd%'
    or TargetCandidateJurisdictionCustom like '%superior court%'
    or TargetCandidateJurisdictionCustom = 'district'
    )
;

update independent_expenditure_filings_temp
set TargetCandidateJurisdiction = TargetCandidateJurisdictionCustom
where 
  -- CandidateExpenditure = 'Y' and
  TargetCandidateJurisdiction = ''
  and TargetCandidateJurisdictionCustom <> ''
;

-- NOTE: for flagging as state/local, office takes precedence over jurisdiction, so it is done second
update
  independent_expenditure_filings_temp ef
  join candidate_office_codes c using (TargetCandidateOfficeCode)
set 
    ef.TargetCandidateOffice = c.TargetCandidateOffice
  , ef.StateExpenditure = if(c.StateOrLocal='S','Y','N')
  , ef.LocalExpenditure = if(c.StateOrLocal='L','Y','N')
where 
  -- ef.CandidateExpenditure = 'Y' and
  ef.TargetCandidateOffice = ''
  and ef.TargetCandidateOfficeCode <> 'OTH'
;

update independent_expenditure_filings_temp
set TargetCandidateOffice = case
      when TargetCandidateOfficeCustom like '%office held%' then ''
      when TargetCandidateOfficeCustom like '%Govern_r%' and TargetCandidateOfficeCustom not like '%Lieuten_nt%' then 'Governor'
      when TargetCandidateOfficeCustom like '%Lieuten_nt%Govern_r%' then 'Lieutenant Governor'
      when TargetCandidateOfficeCustom like '%Secretary%' then 'Secretary of State'
      when TargetCandidateOfficeCustom like '%state%Controll_r%' then 'State Controller'
      when TargetCandidateOfficeCustom like '%Attorn%y gen%' then 'Attorney General'
      when TargetCandidateOfficeCustom like '%state%Treasur_r%' then 'State Treasurer'
      when TargetCandidateOfficeCustom like '%Insur_nce Com%' then 'Insurance Commissioner'
      when TargetCandidateOfficeCustom like '%Superintend_nt%' then 'Superintendent of Public Instruction'
      when TargetCandidateOfficeCustom like '%supreme court%' or TargetCandidateOfficeCustom like '%supreme%justice%' then 'Supreme Court Justice'
      when TargetCandidateOfficeCustom like '%Senate%' or TargetCandidateOfficeCustom like '%Senat_r%' then 'State Senate'
      when TargetCandidateOfficeCustom like '%Assem%b%y%' or TargetCandidateOfficeCustom like '%ASM%' then 'State Assembly'
      when TargetCandidateOfficeCustom like '%board of eq%' or TargetCandidateOfficeCustom like '%boe%' then 'Board of Equalization'
      when TargetCandidateOfficeCustom like '%public%emp%ret%sys%' or TargetCandidateOfficeCustom like 'pers%' or TargetCandidateOfficeCustom like '%calpers%' then 'Public Employees Retirement System'
      when TargetCandidateOfficeCustom like '%appel%te%court%' or TargetCandidateOfficeCustom like '%appel%te%justice%' then 'State Appellate Court Justice'
      when TargetCandidateOfficeCustom like '%asses%r%' then 'Assessor'
      when TargetCandidateOfficeCustom like '%board of ed%' then 'Board of Education'
      when TargetCandidateOfficeCustom like '%board of super%' or TargetCandidateOfficeCustom like '%supervis_r%' then 'Board of Supervisors'
      when TargetCandidateOfficeCustom like '%city atto%rn%y%' then 'City Attorney'
      when TargetCandidateOfficeCustom like '%com%college%' then 'Community College Board'
      when 
        TargetCandidateOfficeCustom like '%city%council%' 
        or TargetCandidateOfficeCustom like '%council%mem%' 
        or TargetCandidateOfficeCustom like '%town%concil%' 
        then 'City Council'
      when TargetCandidateOfficeCustom like '%county coun__l%' then 'County Counsel'
      when TargetCandidateOfficeCustom like '%county supervis_r%' then 'County Supervisor'
      when TargetCandidateOfficeCustom like '%local%cont%' then 'Local Controller'
      when TargetCandidateOfficeCustom like '%dist% atto%rn%y%' then 'District Attorney'
      when TargetCandidateOfficeCustom like '%mayor%' then 'Mayor'
      when TargetCandidateOfficeCustom like '%public%def%' then 'Public Defender'
      when TargetCandidateOfficeCustom like '%planning%com%' then 'Planning Commissioner'
      when TargetCandidateOfficeCustom like '%sher%iff%' then 'Sheriff-Coroner'
      when TargetCandidateOfficeCustom like '%superior court%' or TargetCandidateOfficeCustom like '%judge%' then 'Superior Court Judge'
      when TargetCandidateOfficeCustom like '%Treasur_r%' and TargetCandidateOfficeCustom not like '%state Treasur_r%' then 'Local Treasurer'
      else ''
      end
where 
  -- CandidateExpenditure = 'Y' and
  TargetCandidateOffice = ''
;

update independent_expenditure_filings_temp
set TargetCandidateOffice = TargetCandidateOfficeCustom
where 
  -- CandidateExpenditure = 'Y' and
  TargetCandidateOffice = ''
  and TargetCandidateOfficeCustom <> ''
;

update independent_expenditure_filings_temp
set StateExpenditure = 'Y'
where 
  -- CandidateExpenditure = 'Y' and
  (
     TargetCandidateOffice like '%Assembl%y%'
  or TargetCandidateOffice like '%Senate%'
  or TargetCandidateOffice like '%Govern_r%'
  or (
    TargetCandidateOffice like '%Controll_r%'
    and TargetCandidateOffice not like '%local Controll_r%'
    )
  or (
    TargetCandidateOffice like '%Treasur_r%'
    and TargetCandidateOffice not like '%local Treasur_r%'
    )
  or TargetCandidateOffice like '%Insur_nce Com%'
  or TargetCandidateOffice like '%Lieuten_nt%'
  or TargetCandidateOffice like '%Secretary%'
  or TargetCandidateOffice like '%Superintend%nt%'
  or TargetCandidateOffice like '%Attorney gen%'
  or TargetCandidateOffice like '%board of eq%'
  or TargetCandidateOffice like '%boe%'
  )
;

update independent_expenditure_filings_temp
set LocalExpenditure = 'Y'
where
  -- CandidateExpenditure = 'Y' and
  (
     TargetCandidateOffice like '%mayor%'
  or TargetCandidateOffice like '%judge%'
  or TargetCandidateOffice like '%supervis_r%'
  or TargetCandidateOffice like '%city council%'
  or TargetCandidateOffice like '%superior court%'
  or TargetCandidateOffice like '%asses%r%'
  or TargetCandidateOffice like '%board of education%'
  or TargetCandidateOffice like '%college board%'
  or TargetCandidateOffice like '%school board%'
  or TargetCandidateOffice like '%sher%iff%'
  or TargetCandidateOffice like '%local treasur_r%'
  or TargetCandidateOffice like '%city attorn%y%'
  or TargetCandidateOffice like '%district attorn%y%'
  )
;

-- make sure propositions with IDs are all flagged as State
update independent_expenditure_filings_temp
set StateExpenditure = 'Y'
where TargetPropositionID <> 0
;

update independent_expenditure_filings_temp
set NotIndependent = 'Y'
where
--   (
--     Form in ('F465','F496')
--     and ExpenditureCode not in ('IND','')
--     )
--   or 
  (
    Form not in ('F465','F496')
    and ExpenditureCode <> 'IND'
    )  
;

update independent_expenditure_filings_temp
set HasAgent = 'Y'
where AgentName <> ''
;

update independent_expenditure_filings_temp
set IsMemo = 'Y'
where 
  -- Form = 'F465' and 
  MemoCode = 'X'
;

update independent_expenditure_filings_temp
set Exclude = 'Y'
where
  BadElectionCycle = 'Y'
  or NotIndependent = 'Y'
  or HasAgent = 'Y'
  or IsMemo = 'Y'
  or (LocalExpenditure = 'Y' and StateExpenditure = 'N')
;


drop table if exists ca_ie_search.independent_expenditures_temp_intermediary;

create table ca_ie_search.independent_expenditures_temp_intermediary 
like ca_ie_search.independent_expenditures_new
;

alter table ca_ie_search.independent_expenditures_temp_intermediary
  drop index `PRIMARY`
, modify column ExpenditureID bigint null
, add column ExpenditureFilingID bigint not null after ExpenditureID
, add column IntermediaryID bigint not null primary key auto_increment after ExpenditureFilingID
, add column Exclude enum ('Y','N') default 'N'
, add column MatchCode tinyint null
, add key ExpenditureFilingID (ExpenditureFilingID)
, add key ExpenditureID (ExpenditureID)
, add key MatchCode (MatchCode)
;

drop table if exists ca_ie_search.independent_expenditures_temp;

create table ca_ie_search.independent_expenditures_temp 
like ca_ie_search.independent_expenditures_new
;

-- *** pwr table insert: F465 (regular filings) ***
-- truncate intermediary table
truncate table ca_ie_search.independent_expenditures_temp_intermediary;

-- put in intermediary table
insert ca_ie_search.independent_expenditures_temp_intermediary (
    ExpenditureFilingID , ElectionCycle, Election, ExpenditureDscr, DateStart, DateEnd, Amount, ExpenderIDLegacy, ExpenderID, ExpenderName, ExpenderCity, ExpenderState, ExpenderZipCode, ExpenderEntity, ExpenderCommitteeType, ExpenderPosition, TargetCandidateID, TargetCandidateName, TargetCandidateOffice, TargetCandidateDistrict, TargetCandidateJurisdiction, TargetPropositionID, TargetPropositionName, TargetPropositionJurisdiction, PayeeName, PayeeCity, PayeeState, PayeeZipCode, PayeeCommitteeID, Unitemized, StateExpenditure, LocalExpenditure, CandidateExpenditure, PropositionExpenditure, Exclude
  )
select
    ExpenditureFilingID , ElectionCycle, Election, ExpenditureDscr, DateStart, DateEnd, Amount, ExpenderIDLegacy, ExpenderID, ExpenderName, ExpenderCity, ExpenderState, ExpenderZipCode, ExpenderEntity, ExpenderCommitteeType, ExpenderPosition, TargetCandidateID, TargetCandidateName, TargetCandidateOffice, TargetCandidateDistrict, TargetCandidateJurisdiction, TargetPropositionID, TargetPropositionName, TargetPropositionJurisdiction, PayeeName, PayeeCity, PayeeState, PayeeZipCode, PayeeCommitteeID, Unitemized, StateExpenditure, LocalExpenditure, CandidateExpenditure, PropositionExpenditure, Exclude
from independent_expenditure_filings_temp
where
  Form = 'F465'
  and OriginTable = 'expn'
  -- and Exclude = 'N'
;

-- set ExpenditureID
update ca_ie_search.independent_expenditures_temp_intermediary
set 
    ExpenditureID = IntermediaryID
  , MatchCode = 1
;

-- update ExpenditureID in supporting table
update
  independent_expenditure_filings_temp a
  join ca_ie_search.independent_expenditures_temp_intermediary b using (ExpenditureFilingID)
set 
    a.ExpenditureID = b.ExpenditureID
  , a.MatchCode = b.MatchCode
where b.ExpenditureID is not null
;

-- insert new records in pwr table
insert ca_ie_search.independent_expenditures_temp (
    ExpenditureID, ElectionCycle, Election, ExpenditureDscr, DateStart, DateEnd, Amount, ExpenderIDLegacy, ExpenderID, ExpenderName, ExpenderCity, ExpenderState, ExpenderZipCode, ExpenderEntity, ExpenderCommitteeType, ExpenderPosition, TargetCandidateID, TargetCandidateName, TargetCandidateOffice, TargetCandidateDistrict, TargetCandidateJurisdiction, TargetPropositionID, TargetPropositionName, TargetPropositionJurisdiction, PayeeName, PayeeCity, PayeeState, PayeeZipCode, PayeeCommitteeID, Unitemized, StateExpenditure, LocalExpenditure, CandidateExpenditure, PropositionExpenditure
  )
select
    ExpenditureID, ElectionCycle, Election, ExpenditureDscr, DateStart, DateEnd, Amount, ExpenderIDLegacy, ExpenderID, ExpenderName, ExpenderCity, ExpenderState, ExpenderZipCode, ExpenderEntity, ExpenderCommitteeType, ExpenderPosition, TargetCandidateID, TargetCandidateName, TargetCandidateOffice, TargetCandidateDistrict, TargetCandidateJurisdiction, TargetPropositionID, TargetPropositionName, TargetPropositionJurisdiction, PayeeName, PayeeCity, PayeeState, PayeeZipCode, PayeeCommitteeID, Unitemized, StateExpenditure, LocalExpenditure, CandidateExpenditure, PropositionExpenditure
from ca_ie_search.independent_expenditures_temp_intermediary
where Exclude = 'N'
;

-- *** pwr table insert: F496 (late filings) ***
-- truncate intermediary table
truncate table ca_ie_search.independent_expenditures_temp_intermediary;

-- put in intermediary table
insert ca_ie_search.independent_expenditures_temp_intermediary (
    ExpenditureFilingID , ElectionCycle, Election, ExpenditureDscr, DateStart, DateEnd, Amount, ExpenderIDLegacy, ExpenderID, ExpenderName, ExpenderCity, ExpenderState, ExpenderZipCode, ExpenderEntity, ExpenderCommitteeType, ExpenderPosition, TargetCandidateID, TargetCandidateName, TargetCandidateOffice, TargetCandidateDistrict, TargetCandidateJurisdiction, TargetPropositionID, TargetPropositionName, TargetPropositionJurisdiction, PayeeName, PayeeCity, PayeeState, PayeeZipCode, PayeeCommitteeID, Unitemized, StateExpenditure, LocalExpenditure, CandidateExpenditure, PropositionExpenditure
  )
select
    ExpenditureFilingID , ElectionCycle, Election, ExpenditureDscr, DateStart, DateEnd, Amount, ExpenderIDLegacy, ExpenderID, ExpenderName, ExpenderCity, ExpenderState, ExpenderZipCode, ExpenderEntity, ExpenderCommitteeType, ExpenderPosition, TargetCandidateID, TargetCandidateName, TargetCandidateOffice, TargetCandidateDistrict, TargetCandidateJurisdiction, TargetPropositionID, TargetPropositionName, TargetPropositionJurisdiction, PayeeName, PayeeCity, PayeeState, PayeeZipCode, PayeeCommitteeID, Unitemized, StateExpenditure, LocalExpenditure, CandidateExpenditure, PropositionExpenditure
from independent_expenditure_filings_temp
where
  Form = 'F496'
  and OriginTable = 's496'
  and Exclude = 'N'
;

-- get ExpenditureID for late records that match regular records (MatchCode = 2)
update 
  ca_ie_search.independent_expenditures_temp_intermediary i1
  join independent_expenditure_filings_temp s1 on i1.ExpenditureFilingID = s1.ExpenditureFilingID
  join independent_expenditure_filings_temp s2
    on s2.ExpenditureID is not null
    and s2.Form = 'F465'
    and s1.ElectionCycle = s2.ElectionCycle
    and s1.ExpenderID = s2.ExpenderID
    and (
      (
        s1.TargetCandidateName <> '' 
        and s1.TargetCandidateName = s2.TargetCandidateName
        )
      or (
        s1.TargetPropositionName <> ''
        and s1.TargetPropositionName = s2.TargetPropositionName
        )
      )
    and s1.Amount = s2.Amount
    and s1.DateStart = s2.DateStart
    and s1.TranID = s2.TranID
set 
    i1.ExpenditureID = s2.ExpenditureID
  , i1.MatchCode = 2
where i1.ExpenditureID is null
;

-- update ExpenditureID in supporting table (MatchCode = 2)
update
  independent_expenditure_filings_temp a
  join ca_ie_search.independent_expenditures_temp_intermediary b using (ExpenditureFilingID)
set
    a.ExpenditureID = b.ExpenditureID
  , a.MatchCode = b.MatchCode
where 
  a.ExpenditureID is null
  and b.ExpenditureID is not null
;

-- get ExpenditureID for late records that match regular records (MatchCode = 3)
update 
  ca_ie_search.independent_expenditures_temp_intermediary i1
  join independent_expenditure_filings_temp s1 on i1.ExpenditureFilingID = s1.ExpenditureFilingID
  join independent_expenditure_filings_temp s2
    on s2.ExpenditureID is not null
    and s2.Form = 'F465'
    and s1.ElectionCycle = s2.ElectionCycle
    and s1.ExpenderID = s2.ExpenderID
    and (
      (
        s1.TargetCandidateName <> '' 
        and s1.TargetCandidateName = s2.TargetCandidateName
        )
      or (
        s1.TargetPropositionName <> ''
        and s1.TargetPropositionName = s2.TargetPropositionName
        )
      )
    and s1.DateStart = s2.DateStart
    and s1.TranID = s2.TranID
set 
    i1.ExpenditureID = s2.ExpenditureID
  , i1.MatchCode = 3
where i1.ExpenditureID is null
;

-- update ExpenditureID in supporting table (MatchCode = 3)
update
  independent_expenditure_filings_temp a
  join ca_ie_search.independent_expenditures_temp_intermediary b using (ExpenditureFilingID)
set 
    a.ExpenditureID = b.ExpenditureID
  , a.MatchCode = b.MatchCode
where 
  a.ExpenditureID is null
  and b.ExpenditureID is not null
;

-- get ExpenditureID for late records that match regular records (MatchCode = 4)
update 
  ca_ie_search.independent_expenditures_temp_intermediary i1
  join independent_expenditure_filings_temp s1 on i1.ExpenditureFilingID = s1.ExpenditureFilingID
  join independent_expenditure_filings_temp s2
    on s2.ExpenditureID is not null
    and s2.Form = 'F465'
    and s1.ElectionCycle = s2.ElectionCycle
    and s1.ExpenderID = s2.ExpenderID
    and (
      (
        s1.TargetCandidateName <> '' 
        and s1.TargetCandidateName = s2.TargetCandidateName
        )
      or (
        s1.TargetPropositionName <> ''
        and s1.TargetPropositionName = s2.TargetPropositionName
        )
      )
    and s1.Amount = s2.Amount
    and s1.DateStart = s2.DateStart
set 
    i1.ExpenditureID = s2.ExpenditureID
  , i1.MatchCode = 4
where i1.ExpenditureID is null
;

-- update ExpenditureID in supporting table (MatchCode = 4)
update
  independent_expenditure_filings_temp a
  join ca_ie_search.independent_expenditures_temp_intermediary b using (ExpenditureFilingID)
set 
    a.ExpenditureID = b.ExpenditureID
  , a.MatchCode = b.MatchCode
where 
  a.ExpenditureID is null
  and b.ExpenditureID is not null
;

-- get ExpenditureID for late records that match regular records (MatchCode = 5)
update 
  ca_ie_search.independent_expenditures_temp_intermediary i1
  join independent_expenditure_filings_temp s1 on i1.ExpenditureFilingID = s1.ExpenditureFilingID
  join independent_expenditure_filings_temp s2
    on s2.ExpenditureID is not null
    and s2.Form = 'F465'
    and s1.ElectionCycle = s2.ElectionCycle
    and s1.ExpenderID = s2.ExpenderID
    and (
      (
        s1.TargetCandidateName <> '' 
        and s1.TargetCandidateName = s2.TargetCandidateName
        )
      or (
        s1.TargetPropositionName <> ''
        and s1.TargetPropositionName = s2.TargetPropositionName
        )
      )
    and s1.Amount = s2.Amount
    and s1.TranID = s2.TranID
set 
    i1.ExpenditureID = s2.ExpenditureID
  , i1.MatchCode = 5
where i1.ExpenditureID is null
;

-- update ExpenditureID in supporting table (MatchCode = 5)
update
  independent_expenditure_filings_temp a
  join ca_ie_search.independent_expenditures_temp_intermediary b using (ExpenditureFilingID)
set 
    a.ExpenditureID = b.ExpenditureID
  , a.MatchCode = b.MatchCode
where 
  a.ExpenditureID is null
  and b.ExpenditureID is not null
;

-- get ExpenditureID for late records that match regular records (MatchCode = 6)
update 
  ca_ie_search.independent_expenditures_temp_intermediary i1
  join independent_expenditure_filings_temp s1 on i1.ExpenditureFilingID = s1.ExpenditureFilingID
  join independent_expenditure_filings_temp s2
    on s2.ExpenditureID is not null
    and s2.Form = 'F465'
    and s1.ElectionCycle = s2.ElectionCycle
    and s1.ExpenderID = s2.ExpenderID
    and s1.Amount = s2.Amount
    and s1.DateStart = s2.DateStart
    and s1.TranID = s2.TranID
set 
    i1.ExpenditureID = s2.ExpenditureID
  , i1.MatchCode = 6
where i1.ExpenditureID is null
;

-- update ExpenditureID in supporting table (MatchCode = 6)
update
  independent_expenditure_filings_temp a
  join ca_ie_search.independent_expenditures_temp_intermediary b using (ExpenditureFilingID)
set 
    a.ExpenditureID = b.ExpenditureID
  , a.MatchCode = b.MatchCode
where 
  a.ExpenditureID is null
  and b.ExpenditureID is not null
;

-- set MatchCode for late records that match regular records (MatchCode = 7)
update
  ca_ie_search.independent_expenditures_temp_intermediary i1
  join independent_expenditure_filings_temp s1 on i1.ExpenditureFilingID = s1.ExpenditureFilingID
  join independent_expenditure_filings_temp s2
    on s2.ExpenditureID is not null
    and s2.Form = 'F465'
    and s1.ElectionCycle = s2.ElectionCycle
    and s1.ExpenderID = s2.ExpenderID
    and (
      (
        s1.TargetCandidateName <> '' 
        and s1.TargetCandidateName = s2.TargetCandidateName
        )
      or (
        s1.TargetPropositionName <> ''
        and s1.TargetPropositionName = s2.TargetPropositionName
        )
      )
    and s1.DateStart >= s2.FilingDateStart 
    and s1.DateEnd <= s2.FilingDateEnd
set 
    i1.ExpenditureID = s2.ExpenditureID
  , i1.MatchCode = 7
where 
  i1.ExpenditureID is null
  and i1.ExpenditureDscr like '%estimate%'
;

-- update ExpenditureID in supporting table (MatchCode = 7)
update
  independent_expenditure_filings_temp a
  join ca_ie_search.independent_expenditures_temp_intermediary b using (ExpenditureFilingID)
set 
  -- a.ExpenditureID = b.ExpenditureID -- not useful to have the matched ExpenditureID here in this case
  a.MatchCode = b.MatchCode
where 
  a.ExpenditureID is null
  and b.ExpenditureID is not null
  and b.MatchCode = 7
;

-- get ExpenditureID for late records that match regular records (MatchCode = 8)
update 
  ca_ie_search.independent_expenditures_temp_intermediary i1
  join independent_expenditure_filings_temp s1 on i1.ExpenditureFilingID = s1.ExpenditureFilingID
  join independent_expenditure_filings_temp s2
    on s2.ExpenditureID is not null
    and s2.Form = 'F465'
    and s1.ElectionCycle = s2.ElectionCycle
    and s1.ExpenderID = s2.ExpenderID
    and (
      (
        s1.TargetCandidateName <> '' 
        and s1.TargetCandidateName = s2.TargetCandidateName
        )
      or (
        s1.TargetPropositionName <> ''
        and s1.TargetPropositionName = s2.TargetPropositionName
        )
      )
    and s1.DateStart >= s2.FilingDateStart 
    and s1.DateEnd <= s2.FilingDateEnd
set 
    i1.ExpenditureID = s2.ExpenditureID
  , i1.MatchCode = 8
where 
  i1.ExpenditureID is null
;

-- update ExpenditureID in supporting table (MatchCode = 8)
update
  independent_expenditure_filings_temp a
  join ca_ie_search.independent_expenditures_temp_intermediary b using (ExpenditureFilingID)
set 
  -- a.ExpenditureID = b.ExpenditureID -- not useful to have the matched ExpenditureID here in this case
  a.MatchCode = b.MatchCode
where 
  a.ExpenditureID is null
  and b.ExpenditureID is not null
  and b.MatchCode = 8
;

set @MaxExpenditureID = (select max(ExpenditureID) from independent_expenditure_filings_temp);

-- assign ExpenditureID for unmatched late records where there are duplicates (MatchCode = 9)
update
  ca_ie_search.independent_expenditures_temp_intermediary e1
  join independent_expenditure_filings_temp ef1 using (ExpenditureFilingID)
  join (
    select
        e.ElectionCycle
      , e.ExpenderID
      , ef.Form
      , ef.TranID
      , e.TargetCandidateID
      , e.TargetCandidateName
      , e.TargetPropositionName
      , count(*) 'duplicates'
      , max(ef.FiledDate) 'FiledDate_max'
    from 
      ca_ie_search.independent_expenditures_temp_intermediary e
      join independent_expenditure_filings_temp ef using (ExpenditureFilingID)
    where 
      e.ExpenditureID is null
      and length(ef.TranID) > 1
    group by
        e.ElectionCycle
      , e.ExpenderID
      , ef.Form
      , ef.TranID
      , e.TargetCandidateID
      , e.TargetCandidateName
      , e.TargetPropositionName
    having duplicates > 1
    ) x
      on e1.ElectionCycle = x.ElectionCycle
      and e1.ExpenderID = x.ExpenderID
      and ef1.Form = x.Form
      and ef1.TranID = x.TranID
      and e1.TargetCandidateID = x.TargetCandidateID
      and e1.TargetCandidateName = x.TargetCandidateName
      and e1.TargetPropositionName = x.TargetPropositionName
  join (
    select
        e3.ElectionCycle
      , e3.ExpenderID
      , ef3.Form
      , ef3.TranID
      , e3.TargetCandidateID
      , e3.TargetCandidateName
      , e3.TargetPropositionName
      , ef3.FiledDate
      , max(e3.IntermediaryID) IntermediaryIDToUse
    from 
      ca_ie_search.independent_expenditures_temp_intermediary e3
      join independent_expenditure_filings_temp ef3 using (ExpenditureFilingID)
    where 
      e3.ExpenditureID is null
      and length(ef3.TranID) > 1
    group by
        e3.ElectionCycle
      , e3.ExpenderID
      , ef3.Form
      , ef3.TranID
      , e3.TargetCandidateID
      , e3.TargetCandidateName
      , e3.TargetPropositionName
      , ef3.FiledDate
    ) y
      on e1.ElectionCycle = y.ElectionCycle
      and e1.ExpenderID = y.ExpenderID
      and ef1.Form = y.Form
      and ef1.TranID = y.TranID
      and e1.TargetCandidateID = y.TargetCandidateID
      and e1.TargetCandidateName = y.TargetCandidateName
      and e1.TargetPropositionName = y.TargetPropositionName
      and x.FiledDate_max = y.FiledDate
set 
    e1.ExpenditureID = y.IntermediaryIDToUse + @MaxExpenditureID
  , e1.MatchCode = 9
where 
  e1.ExpenditureID is null
  and length(ef1.TranID) > 1
;

-- assign ExpenditureID for all remaining unmatched late records (MatchCode = 9)
update ca_ie_search.independent_expenditures_temp_intermediary
set 
    ExpenditureID = IntermediaryID + @MaxExpenditureID
  , MatchCode = 9
where ExpenditureID is null
;

-- update ExpenditureID in supporting table (MatchCode = 9)
update
  independent_expenditure_filings_temp a
  join ca_ie_search.independent_expenditures_temp_intermediary b using (ExpenditureFilingID)
set 
    a.ExpenditureID = b.ExpenditureID
  , a.MatchCode = b.MatchCode
where 
  a.ExpenditureID is null
  and b.ExpenditureID is not null
  and b.MatchCode = 9
;

-- don't insert duplicates
update
  ca_ie_search.independent_expenditures_temp_intermediary e
  join independent_expenditure_filings_temp ef using (ExpenditureFilingID)
set e.ExpenditureID = null
where 
  ef.MatchCode = 9
  and e.ExpenditureID <> e.IntermediaryID + @MaxExpenditureID
;

-- insert new records (should be MatchCode = 9 only) in pwr table
insert ca_ie_search.independent_expenditures_temp (
      ExpenditureID,   ElectionCycle,   Election,   ExpenditureDscr,   DateStart,   DateEnd,   Amount,   ExpenderIDLegacy,   ExpenderID,   ExpenderName,   ExpenderCity,   ExpenderState,   ExpenderZipCode,   ExpenderEntity,   ExpenderCommitteeType,   ExpenderPosition,   TargetCandidateID,   TargetCandidateName,   TargetCandidateOffice,   TargetCandidateDistrict,   TargetCandidateJurisdiction,   TargetPropositionID,   TargetPropositionName,   TargetPropositionJurisdiction,   PayeeName,   PayeeCity,   PayeeState,   PayeeZipCode,   PayeeCommitteeID,   Unitemized,   StateExpenditure,   LocalExpenditure,   CandidateExpenditure,   PropositionExpenditure
  )
select
    a.ExpenditureID, a.ElectionCycle, a.Election, a.ExpenditureDscr, a.DateStart, a.DateEnd, a.Amount, a.ExpenderIDLegacy, a.ExpenderID, a.ExpenderName, a.ExpenderCity, a.ExpenderState, a.ExpenderZipCode, a.ExpenderEntity, a.ExpenderCommitteeType, a.ExpenderPosition, a.TargetCandidateID, a.TargetCandidateName, a.TargetCandidateOffice, a.TargetCandidateDistrict, a.TargetCandidateJurisdiction, a.TargetPropositionID, a.TargetPropositionName, a.TargetPropositionJurisdiction, a.PayeeName, a.PayeeCity, a.PayeeState, a.PayeeZipCode, a.PayeeCommitteeID, a.Unitemized, a.StateExpenditure, a.LocalExpenditure, a.CandidateExpenditure, a.PropositionExpenditure
from 
  ca_ie_search.independent_expenditures_temp_intermediary a
  left join ca_ie_search.independent_expenditures_temp b on a.ExpenditureID = b.ExpenditureID
  left join (
    select distinct ExpenditureID 
    from independent_expenditure_filings_temp
    where 
      MatchCode = 1
      and Exclude = 'Y'
    ) c on a.ExpenditureID = c.ExpenditureID
where 
  a.ExpenditureID is not null
  and b.ExpenditureID is null
  and c.ExpenditureID is null
;

-- *** pwr table insert: summary table ***
-- truncate intermediary table
truncate table ca_ie_search.independent_expenditures_temp_intermediary;

-- put in intermediary table
insert ca_ie_search.independent_expenditures_temp_intermediary (
    ExpenditureFilingID , ElectionCycle, Election, ExpenditureDscr        , DateStart, DateEnd, Amount, ExpenderIDLegacy, ExpenderID, ExpenderName, ExpenderCity, ExpenderState, ExpenderZipCode, ExpenderEntity, ExpenderCommitteeType, ExpenderPosition, TargetCandidateID, TargetCandidateName, TargetCandidateOffice, TargetCandidateDistrict, TargetCandidateJurisdiction, TargetPropositionID, TargetPropositionName, TargetPropositionJurisdiction, PayeeName              , PayeeCity, PayeeState, PayeeZipCode, PayeeCommitteeID, Unitemized, StateExpenditure, LocalExpenditure, CandidateExpenditure, PropositionExpenditure
  )
select
    ExpenditureFilingID , ElectionCycle, Election, 'Unitemized under $100', DateStart, DateEnd, Amount, ExpenderIDLegacy, ExpenderID, ExpenderName, ExpenderCity, ExpenderState, ExpenderZipCode, ExpenderEntity, ExpenderCommitteeType, ExpenderPosition, TargetCandidateID, TargetCandidateName, TargetCandidateOffice, TargetCandidateDistrict, TargetCandidateJurisdiction, TargetPropositionID, TargetPropositionName, TargetPropositionJurisdiction, 'Unitemized under $100', PayeeCity, PayeeState, PayeeZipCode, PayeeCommitteeID, 'Y'       , StateExpenditure, LocalExpenditure, CandidateExpenditure, PropositionExpenditure
from independent_expenditure_filings_temp
where
  Form = 'F465'
  and OriginTable = 'smry'
  and LineItem = 2
  and Amount <> 0
  and Exclude = 'N'
;

-- set ExpenditureID
set @MaxExpenditureID = (select max(ExpenditureID) from independent_expenditure_filings_temp);

update ca_ie_search.independent_expenditures_temp_intermediary
set ExpenditureID = IntermediaryID + @MaxExpenditureID
where ExpenditureID is null
;

-- dedupe for multiple in same period? (none in 2013 - check other years)
-- (then, check for multiples with same max_FiledDate...)
update
  ca_ie_search.independent_expenditures_temp_intermediary e2
  join (
    select e.ElectionCycle, e.ExpenderID, e.TargetCandidateName, e.TargetPropositionName, e.DateStart, e.DateEnd
      , count(*) 'smry_filings'
      , max(s.FiledDate) 'max_FiledDate'
      , min(e.ExpenditureID) 'min_ExpenditureID'
    from 
      ca_ie_search.independent_expenditures_temp_intermediary e
      join ca_ie_process.independent_expenditure_filings_temp s using (ExpenditureFilingID)
    group by e.ElectionCycle, e.ExpenderID, e.TargetCandidateName, e.TargetPropositionName, e.DateStart, e.DateEnd
    having smry_filings > 1
    ) x using (ElectionCycle, ExpenderID, TargetCandidateName, TargetPropositionName, DateStart, DateEnd)
set e2.ExpenditureID = x.min_ExpenditureID
;

-- update ExpenditureID in supporting table
update
  independent_expenditure_filings_temp a
  join ca_ie_search.independent_expenditures_temp_intermediary b using (ExpenditureFilingID)
set 
    a.ExpenditureID = b.ExpenditureID
  , a.MatchCode = 1
where b.ExpenditureID is not null
;

-- delete duplicates
delete e2
from
  ca_ie_search.independent_expenditures_temp_intermediary e2
  join (
    select e.ElectionCycle, e.ExpenderID, e.TargetCandidateName, e.TargetPropositionName, e.DateStart, e.DateEnd
      , count(*) 'smry_filings'
      , max(s.FiledDate) 'max_FiledDate'
      , min(e.ExpenditureID) 'min_ExpenditureID'
    from 
      ca_ie_search.independent_expenditures_temp_intermediary e
      join ca_ie_process.independent_expenditure_filings_temp s using (ExpenditureFilingID)
    group by e.ElectionCycle, e.ExpenderID, e.TargetCandidateName, e.TargetPropositionName, e.DateStart, e.DateEnd
    having smry_filings > 1
    ) x using (ElectionCycle, ExpenderID, TargetCandidateName, TargetPropositionName, DateStart, DateEnd)
  join ca_ie_process.independent_expenditure_filings_temp s2 using (ExpenditureFilingID)
where s2.FiledDate <> x.max_FiledDate
;

-- insert new records in pwr table
insert ca_ie_search.independent_expenditures_temp (
    ExpenditureID, ElectionCycle, Election, ExpenditureDscr, DateStart, DateEnd, Amount, ExpenderIDLegacy, ExpenderID, ExpenderName, ExpenderCity, ExpenderState, ExpenderZipCode, ExpenderEntity, ExpenderCommitteeType, ExpenderPosition, TargetCandidateID, TargetCandidateName, TargetCandidateOffice, TargetCandidateDistrict, TargetCandidateJurisdiction, TargetPropositionID, TargetPropositionName, TargetPropositionJurisdiction, PayeeName, PayeeCity, PayeeState, PayeeZipCode, PayeeCommitteeID, Unitemized, StateExpenditure, LocalExpenditure, CandidateExpenditure, PropositionExpenditure
  )
select
    ExpenditureID, ElectionCycle, Election, ExpenditureDscr, DateStart, DateEnd, Amount, ExpenderIDLegacy, ExpenderID, ExpenderName, ExpenderCity, ExpenderState, ExpenderZipCode, ExpenderEntity, ExpenderCommitteeType, ExpenderPosition, TargetCandidateID, TargetCandidateName, TargetCandidateOffice, TargetCandidateDistrict, TargetCandidateJurisdiction, TargetPropositionID, TargetPropositionName, TargetPropositionJurisdiction, PayeeName, PayeeCity, PayeeState, PayeeZipCode, PayeeCommitteeID, Unitemized, StateExpenditure, LocalExpenditure, CandidateExpenditure, PropositionExpenditure
from ca_ie_search.independent_expenditures_temp_intermediary
;

update ca_ie_search.independent_expenditures_temp
set DateRange = if(
    ifnull(DateStart,'1990-01-01') = ifnull(DateEnd,'1990-01-01')
  , DateStart
  , concat(ifnull(DateStart,''),' to ',ifnull(DateEnd,''))
  )
;

optimize table ca_ie_search.independent_expenditures_temp;

drop table if exists independent_expenditure_filings;

rename table independent_expenditure_filings_temp to independent_expenditure_filings;

drop table if exists ca_ie_search.independent_expenditures;

rename table ca_ie_search.independent_expenditures_temp to ca_ie_search.independent_expenditures;

drop table if exists ca_ie_search.independent_expenditures_temp_intermediary;

drop table if exists temp_candidate_id_names;

drop table if exists temp_proposition_id_names;

drop table if exists temp_proposition_id_numbers;

-- drop table if exists temp_proposition_id_cycles;
-- 
drop table if exists temp_proposition_fields;