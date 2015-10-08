-- Always have one or more blank lines between statements (after ;)
-- No blank lines within statements.
-- Can have multi-line statementents.
-- Only this kind of comments: -- 
-- No blank line after comments.
-- Okay to have lines of a statement commented out.
--
--
delete from ca_process.nparser_titles
where Title = 'ASSEMBLYMEMBER'
;

insert ca_process.nparser_titles (Title)
select 'ASSEMBLYMEMBER'
;

DROP TABLE IF EXISTS candidate_office_codes;

CREATE TABLE candidate_office_codes (
  TargetCandidateOfficeCode VARCHAR(3) NOT NULL PRIMARY KEY,
  TargetCandidateOffice VARCHAR(200) NOT NULL,
  StateOrLocal ENUM('S','L',''),
  UNIQUE KEY TargetCandidateOffice (TargetCandidateOffice),
  KEY StateOrLocal (StateOrLocal) 
);

insert candidate_office_codes (TargetCandidateOfficeCode, TargetCandidateOffice, StateOrLocal)
select 'APP', 'State Appellate Court Justice',        'S' union
select 'ASM', 'State Assembly',                       'S' union
select 'ASR', 'Assessor',                             'L' union
select 'ATT', 'Attorney General',                     'S' union
select 'BED', 'Board of Education',                   'L' union
select 'BOE', 'Board of Equalization',                'S' union
select 'BSU', 'Board of Supervisors',                 'L' union
select 'CAT', 'City Attorney',                        'L' union
select 'CCB', 'Community College Board',              'L' union
select 'CCM', 'City Council',                         'L' union
select 'CON', 'State Controller',                     'S' union
select 'COU', 'County Counsel',                       'L' union
select 'CSU', 'County Supervisor',                    'L' union
select 'CTR', 'Local Controller',                     'L' union
select 'DAT', 'District Attorney',                    'L' union
select 'GOV', 'Governor',                             'S' union
select 'INS', 'Insurance Commissioner',               'S' union
select 'LTG', 'Lieutenant Governor',                  'S' union
select 'MAY', 'Mayor',                                'L' union
select 'OTH', 'Other',                                ''  union
select 'PER', 'Public Employees Retirement System',   'S' union
select 'PDR', 'Public Defender',                      'L' union
select 'PLN', 'Planning Commissioner',                'L' union
select 'SCJ', 'Superior Court Judge',                 'L' union
select 'SEN', 'State Senate',                         'S' union
select 'SHC', 'Sheriff-Coroner',                      'L' union
select 'SOS', 'Secretary of State',                   'S' union
select 'SPM', 'Supreme Court Justice',                'S' union
select 'SUP', 'Superintendent of Public Instruction', 'S' union
select 'TRE', 'State Treasurer',                      'S' union
select 'TRS', 'Local Treasurer',                      'L'
;

DROP TABLE IF EXISTS candidate_jurisdiction_codes;

CREATE TABLE candidate_jurisdiction_codes (
  TargetCandidateJurisdictionCode VARCHAR(3) NOT NULL PRIMARY KEY,
  TargetCandidateJurisdiction VARCHAR(50) NOT NULL,
  StateOrLocal ENUM('S','L',''),
  KEY TargetCandidateJurisdiction (TargetCandidateJurisdiction), 
  KEY StateOrLocal (StateOrLocal) 
);

insert candidate_jurisdiction_codes (TargetCandidateJurisdictionCode, TargetCandidateJurisdiction, StateOrLocal)
select 'CA',  'California',     'S' union
select 'CIT', 'City',           'L' union
select 'CTY', 'County',         'L' union
select 'LOC', 'Local',          'L' union
select 'OC',  'Orange County',  'L' union
select 'SD',  'San Diego',      'L' union
select 'STW', 'Statewide',      'S'
;

DROP TABLE IF EXISTS match_codes;

CREATE TABLE match_codes (
  MatchCode TINYINT NOT NULL PRIMARY KEY,
  MatchDescription VARCHAR(250) NOT NULL
);

INSERT match_codes (MatchCode, MatchDescription)
SELECT 1, 'Original F465' UNION
SELECT 2, 'S496 matches existing F465 on Cycle, Expender, Target, Amount, Date, TranID' UNION
SELECT 3, 'S496 matches existing F465 on Cycle, Expender, Target, Date, TranID' UNION
SELECT 4, 'S496 matches existing F465 on Cycle, Expender, Target, Amount, Date' UNION
SELECT 5, 'S496 matches existing F465 on Cycle, Expender, Target, Amount, TranID' UNION
SELECT 6, 'S496 matches existing F465 on Cycle, Expender, Amount, Date, TranID' UNION
SELECT 7, 'S496 with "estimate" in description matches existing F465 on Cycle, Expender, Target, filing date range' UNION
SELECT 8, 'S496 matches existing F465 on Cycle, Expender, Target, filing date range' UNION
SELECT 9, 'S496 with no F465 match found'
;

DROP TABLE IF EXISTS table_filing_ids_ie;

CREATE TABLE table_filing_ids_ie (
  OriginTable VARCHAR(20) NOT NULL,
  filing_id BIGINT NOT NULL,
  amend_id INTEGER NOT NULL,
  PRIMARY KEY OriginTable_filing_id (OriginTable, filing_id)
);

DROP TABLE IF EXISTS filing_ids_ie;

CREATE TABLE filing_ids_ie (
  filing_id BIGINT NOT NULL PRIMARY KEY,
  amend_id_to_use INTEGER NOT NULL,
  expn_amend_id INTEGER NULL,
  s497_amend_id INTEGER NULL,
  smry_amend_id INTEGER NULL,
  cvr_amend_id INTEGER NULL,
  FirstElectionCycle SMALLINT NULL DEFAULT NULL
);

DROP TABLE IF EXISTS independent_expenditure_filings_names_to_standardize;

CREATE TABLE independent_expenditure_filings_names_to_standardize (
  ExpenditureFilingID BIGINT NOT NULL PRIMARY KEY,
  TargetCandidateNamePreStandardization VARCHAR(250) NOT NULL DEFAULT '',
  first_name VARCHAR(50) NOT NULL DEFAULT '',
  middle_name VARCHAR(50) NOT NULL DEFAULT '',
  last_name VARCHAR(50) NOT NULL DEFAULT '',
  name_suffix VARCHAR(50) NOT NULL DEFAULT '',
  name_prefix VARCHAR(50) NOT NULL DEFAULT '',
  nick_name VARCHAR(50) NOT NULL DEFAULT '',
  gender CHAR(1) NOT NULL DEFAULT '',
  TargetCandidateName VARCHAR(250) NOT NULL DEFAULT ''
);

DROP TABLE IF EXISTS candidate_name_spellings;

CREATE TABLE candidate_name_spellings (
  ElectionCycle SMALLINT NULL,
  TargetCandidateName VARCHAR(250) NOT NULL,
  TargetCandidateID BIGINT NOT NULL,
  UNIQUE KEY CycleName (ElectionCycle, TargetCandidateName),
  KEY TargetCandidateName (TargetCandidateName),
  KEY ElectionCycle (ElectionCycle)
);

INSERT candidate_name_spellings (TargetCandidateName, TargetCandidateID)
select 'Aanestad, Sam'                           , 1003707 union
select 'Aceves, Larry'                           , 1317760 union
select 'Achadjian, Katcho'                       , 1317317 union
select 'Ackerman, Dick'                          , 1004825 union
select 'Ackerman, Linda'                         , 1321402 union
select 'Acuna, Joey'                             , 1005233 union
select 'Acuna, Joey Jr'                          , 1005233 union
select 'Adams, Anthony'                          , 1273674 union
select 'Adams, Steve'                            , 1276934 union
select 'Agbalog, Romeo'                          , 1365129 union
select 'Aghazarian, Greg'                        , 1005692 union
select 'Alarcon, Richard'                        , 1256876 union
select 'Alby, Barbara'                           , 1003679 union
select 'Alejo, Luis'                             , 1318708 union
select 'Allard, John'                            , 1327668 union
select 'Allen, Ben'                              , 1363828 union
select 'Allen, Gregory'                          , 1363128 union
select 'Allen, Michael'                          , 1317458 union
select 'Alquist, Elaine'                         , 1004827 union
select 'Alvarez, Claudia'                        , 1253556 union
select 'Amador, Tony'                            , 1343851 union
select 'Ammiano, Tom'                            , 1290517 union
select 'Anderson, Joel'                          , 1004048 union
select 'Andreas, Mary Ann'                       , 1255182 union
select 'Angelides - CA, Phil'                    , 1004467 union
select 'Angelides, Phil'                         , 1004467 union
select 'Angelides, Philip'                       , 1004467 union
select 'Arabo, Auday'                            , 1293656 union
select 'Arambula, Juan'                          , 1250945 union
select 'Aramula, Juan'                           , 1250945 union
select 'Areias, Rusty'                           , 1240721 union
select 'Arguello, Dan'                           , 1234187 union
select 'Arguello, Daniel'                        , 1234187 union
select 'Arguillo, Dan'                           , 1234187 union
select 'Ashburn, Roy'                            , 1004828 union
select 'Atkins, Toni'                            , 1314678 union
select 'Augustine, Len'                          , 1343842 union
select 'Avalos, Carmen'                          , 1315311 union
select 'Ayres, Jim'                              , 1273956 union
select 'Baca, Jeremy'                            , 1275362 union
select 'Baca, Joe'                               , 1002984 union
select 'Baca, Joe Jr'                            , 1002984 union
select 'Bade, Otto'                              , 1256415 union
select 'Baker, Catharine'                        , 1358730 union
select 'Barnes, Janet'                           , 1322053 union
select 'Barton, John'                            , 1252082 union
select 'Bass, Karen'                             , 1259008 union
select 'Bates, Pat'                              , 1003846 union
select 'Bates, Patricia'                         , 1003846 union
select 'Batey, Bill'                             , 1005696 union
select 'Batey, William'                          , 1005696 union
select 'Baugh, Les'                              , 1342941 union
select 'Beall, Jim'                              , 1251768 union
select 'Beecham, Nancy'                          , 1240106 union
select 'Benoit, John'                            , 1240093 union
select 'Berg, Patty'                             , 1233578 union
select 'Bermudez, Rudy'                          , 1005170 union
select 'Bernosky, Robert'                        , 1322746 union
select 'Berryhill, Bill'                         , 1291444 union
select 'Berryhill, Tom'                          , 1294245 union
select 'Bigelow, Frank'                          , 1342402 union
select 'Blais, Neil'                             , 1294534 union
select 'Blakeslee, Sam'                          , 1234847 union
select 'Block, Marty'                            , 1294014 union
select 'Bloom, Richard'                          , 1330273 union
select 'Bloomenfield, Robert'                    , 1295328 union
select 'Blumenfield, Bob'                        , 1295328 union
select 'Blumenfield, Robert'                     , 1295328 union
select 'Bocanegra, Raul'                         , 1330049 union
select 'Bogh, Russ'                              , 1005640 union
select 'Bogh, Russell'                           , 1005640 union
select 'Bonilla, Susan'                          , 1315657 union
select 'Bonta, Rob'                              , 1339733 union
select 'Bosetti, Rick'                           , 1342077 union
select 'Bowen, Debra'                            , 1003952 union
select 'Bradford, Stephen'                       , 1235136 union
select 'Bradford, Steve'                         , 1235136 union
select 'Bradford, Steven'                        , 1235136 union
select 'Britt, Harry'                            , 1236041 union
select 'Brown, Cheryl'                           , 1340553 union
select 'Brown, Edmund'                           , 1265530 union
select 'Brown, Jerry'                            , 1265530 union
select 'Brownley, Julia'                         , 1272017 union
select 'Brunton, Bob'                            , 1363959 union
select 'Bryson, Anna'                            , 1354879 union
select 'Buchanan, Joan'                          , 1299400 union
select 'Buck, Jill'                              , 1284549 union
select 'Burke, Autumn'                           , 1357823 union
select 'Bustamante, Cruz'                        , 1004150 union
select 'Butler, Betsy'                           , 1298929 union
select 'Cabaldon, Christopher'                   , 1233409 union
select 'Caballero, Anna'                         , 1282323 union
select 'Calderon, Charles'                       , 1001590 union
select 'Calderon, Ian'                           , 1336511 union
select 'Calderon, Ron'                           , 1235391 union
select 'Calderon, Ronald'                        , 1235391 union
select 'Calderon, Tom'                           , 1005220 union
select 'Camejo, Peter'                           , 1237501 union
select 'Campbell, John'                          , 1005647 union
select 'Campos, David'                           , 1359299 union
select 'Campos, Nora'                            , 1318599 union
select 'Canciamilla, Laura'                      , 1277237 union
select 'Cannella, Anthony'                       , 1318121 union
select 'Caplane, Ronnie Gail'                    , 1276459 union
select 'Carcione, John'                          , 1254583 union
select 'Carrillo, Pedro'                         , 1236557 union
select 'Carter, Wilmer'                          , 1281998 union
select 'Carter, Wilmer Amina'                    , 1281998 union
select 'Caserta, Dominic'                        , 1293657 union
select 'Castaneda, Steve'                        , 1353762 union
select 'Castaneda, Steven'                       , 1353762 union
select 'Chan, Wilma'                             , 1005709 union
select 'Chang, Ling Ling'                        , 1357038 union
select 'Chang, Ling-ling'                        , 1357038 union
select 'Charles, Schaupp'                        , 1301596 union
select 'Chau, Ed'                                , 1281706 union
select 'Chau, Edwin'                             , 1281706 union
select 'Chavez, Luis'                            , 1362454 union
select 'Chavez, Renee'                           , 1265975 union
select 'Chavez, Rocky'                           , 1339551 union
select 'Cherny, Andrei'                          , 1234513 union
select 'Chiang, John'                            , 1005192 union
select 'Chiu, David'                             , 1360423 union
select 'Chu, Judy'                               , 1004242 union
select 'Chu, Kansen'                             , 1356482 union
select 'Clute, Steve'                            , 1278271 union
select 'Cohelan, Tim'                            , 1236515 union
select 'Cohn, Rebecca'                           , 1005705 union
select 'Cohn, Steve'                             , 1358962 union
select 'Compac BBQ, Dominic Caserta'             , 1293657 union
select 'Conlon, Greg'                            , 1325714 union
select 'Contreras, Alfonso'                      , 1323332 union
select 'Cook, Jim'                               , 1262906 union
select 'Cook, Paul'                              , 1277238 union
select 'Cooley, Ken'                             , 1240640 union
select 'Cooley, Steve'                           , 1323827 union
select 'Cooper, Jim'                             , 1354349 union
select 'Corbett, Ellen'                          , 1005551 union
select 'Correa 34, Lou'                          , 1004849 union
select 'Correa, Lou'                             , 1004849 union
select 'Coto, Joe'                               , 1253525 union
select 'Cox, Dave'                               , 1004452 union
select 'Crettol, Jim'                            , 1234505 union
select 'Cristich, Christi'                       , 1253519 union
select 'Cristich, Cristi'                        , 1253519 union
select 'Critich, Cristi'                         , 1253519 union
select 'Curry, Keith'                            , 1362287 union
select 'Dababneh, Matt'                          , 1357054 union
select 'Dababneh, Matthew'                       , 1357054 union
select 'Dahle, Brian'                            , 1224716 union
select 'Daigle, Leslie'                          , 1339906 union
select 'Dale, Jack'                              , 1275501 union
select 'Daly, Tom'                               , 1341148 union
select 'Daucher, Lynn'                           , 1005667 union
select 'Davis, Gray'                             , 1000775 union
select 'Davis, Grey'                             , 1000775 union
select 'Davis, Mike'                             , 1277329 union
select 'Davis, Patty'                            , 1254541 union
select 'de la Libertad, Armando'                 , 1253528 union
select 'de la Piedra, Mario'                     , 1364603 union
select 'de la Torre, Hector'                     , 1253966 union
select 'de Leon, Keven'                          , 1263266 union
select 'de Leon, Kevin'                          , 1263266 union
select 'De Saulnier, Mark'                       , 1236046 union
select 'De Vore, Charles'                        , 1254089 union
select 'Dear, Don'                               , 1005801 union
select 'DeLaTorre, Hector'                       , 1253966 union
select 'DeLeon, Kevin'                           , 1263266 union
select 'Delepine, Joy'                           , 1366787 union
select 'Delgadillo, Rockard'                     , 1275366 union
select 'Denaham, Jeff'                           , 1005706 union
select 'Denham, Jeff'                            , 1005706 union
select 'Desaulinier, Mark'                       , 1236046 union
select 'DeSaulnier, Mark'                        , 1236046 union
select 'Devore, Chuck'                           , 1254089 union
select 'Diaz, Manny'                             , 1220783 union
select 'Dickerson, Dick'                         , 1005204 union
select 'Dickinson, Roger'                        , 1251341 union
select 'Diridon, Rod'                            , 1253716 union
select 'Diridon, Rod Jr'                         , 1253716 union
select 'Diridon, Ron'                            , 1253716 union
select 'Dodd, Bill'                              , 1359048 union
select 'Dominguez, Francisco'                    , 1318375 union
select 'Donnelly, Tim'                           , 1324846 union
select 'Douglas, Farrah'                         , 1340193 union
select 'Ducheny, Denise Moreno'                  , 1004297 union
select 'Dunn, Joe'                               , 1005289 union
select 'Dutra, John'                             , 1005277 union
select 'Dutton, Bob'                             , 1233959 union
select 'Duval, Mike'                             , 1226871 union
select 'Duvall, Mike'                            , 1226871 union
select 'Dymally, Mervin'                         , 1238979 union
select 'Dymally, Mervyn'                         , 1238979 union
select 'Eastman, John'                           , 1323771 union
select 'Echols, Elizabeth'                       , 1357374 union
select 'Eggman, Susan'                           , 1337454 union
select 'Eggman, Susan Talamantes'                , 1337454 union
select 'Eisenhut, John'                          , 1304607 union
select 'Ellis, Stan'                             , 1284544 union
select 'Emmerson, Bill'                          , 1261353 union
select 'Eng, Mike'                               , 1275685 union
select 'Evans, Noreen'                           , 1227859 union
select 'Farrise, Simona'                         , 1364174 union
select 'Feuer, Mike'                             , 1257933 union
select 'Figeroa, Liz'                            , 1004964 union
select 'Figueroa, Liz'                           , 1004964 union
select 'Florez, Dean'                            , 1005244 union
select 'Florez, Fran'                            , 1227860 union
select 'Flowers, Sally Zuniga'                   , 1237208 union
select 'Fluke, Sandra'                           , 1363477 union
select 'Fong, Darrell'                           , 1358768 union
select 'Fong, Paul'                              , 1296276 union
select 'Ford, Jo'                                , 1278268 union
select 'Ford, Mary Jo'                           , 1278268 union
select 'Fox, Steve'                              , 1297103 union
select 'Frazier, Jim'                            , 1341446 union
select 'Friends For Mike Gordon'                 , 1252137 union
select 'Friends Of Bonnie Garcia 2004'           , 1240067 union
select 'Friends Of Patty Davis'                  , 1254541 union
select 'Fuentes, Felipe'                         , 1295035 union
select 'Fuentes, Yolanda'                        , 1240051 union
select 'Fuller, Jean'                            , 1284988 union
select 'Furutani, Warren'                        , 1265441 union
select 'Gabl, Diane'                             , 1365082 union
select 'Gaines, Beth'                            , 1335196 union
select 'Gaines, Ted'                             , 1265444 union
select 'Galgiani, Cathleen'                      , 1273495 union
select 'Gallardo-Rooker, Alex'                   , 1227998 union
select 'Gallardo-Rooker, Alexandra'              , 1227998 union
select 'Gallardo-Rooker, Alexendra'              , 1227998 union
select 'Gallegos, Martin'                        , 1004371 union
select 'Gantt, Gene'                             , 1343148 union
select 'Garamedi, John'                          , 1000842 union
select 'Garamendi, John'                         , 1000842 union
select 'Garcia, Bonnie'                          , 1240067 union
select 'Garcia, Cristina'                        , 1343926 union
select 'Garcia, Eduardo'                         , 1355371 union
select 'Gardner, Dean'                           , 1237532 union
select 'Gardner, Joe Lara'                       , 1343990 union
select 'Garland, Chris'                          , 1321316 union
select 'Garrick, Martin'                         , 1274198 union
select 'Gary, Podesto'                           , 1256414 union
select 'Gatto, Mike'                             , 1005008 union
select 'Gerber, Donna'                           , 1233414 union
select 'Gibson, Jim'                             , 1254184 union
select 'Gilmore, Danny'                          , 1283919 union
select 'Gipson, Michael'                         , 1299805 union
select 'Gipson, Mike'                            , 1299805 union
select 'Glazer, Steve'                           , 1355210 union
select 'Glazer, Steven'                          , 1355210 union
select 'Glover, Michael'                         , 1283593 union
select 'Gold, Ron'                               , 1364756 union
select 'Gomez, Armando'                          , 1356332 union
select 'Gomez, Jimmy'                            , 1334135 union
select 'Gordon, Michael'                         , 1252137 union
select 'Gordon, Mike'                            , 1252137 union
select 'Gordon, Rich'                            , 1316724 union
select 'Gorell, Jeff'                            , 1236048 union
select 'Goya, John'                              , 1358230 union
select 'Gray, Adam'                              , 1315410 union
select 'Grose, Ted'                              , 1361796 union
select 'Groveman, Barry'                         , 1272726 union
select 'Guerra, Mario'                           , 1358733 union
select 'Guillen, Abel'                           , 1338643 union
select 'Hadley, David'                           , 1359993 union
select 'Hagman, Curt'                            , 1297723 union
select 'Halderman, Linda'                        , 1323720 union
select 'Hall, Isadore'                           , 1276161 union
select 'Hall, Isadore III'                       , 1276161 union
select 'Hall, Isodore'                           , 1276161 union
select 'Hall, Vince'                             , 1233427 union
select 'Hallinan, Thomas'                        , 1226825 union
select 'Hallinan, Tom'                           , 1226825 union
select 'Hammond, Lauren'                         , 1245151 union
select 'Hancock, Loni'                           , 1238901 union
select 'Hardy, Steve'                            , 1234068 union
select 'Harkey, Diane'                           , 1281241 union
select 'Harman, Tom'                             , 1282258 union
select 'Harmon, Tom'                             , 1282258 union
select 'Harper, Matt'                            , 1341264 union
select 'Harper, Matthew'                         , 1341264 union
select 'Harrington 4 Assembly 2010, Mickey'      , 1283210 union
select 'Harrington, Mickey'                      , 1283210 union
select 'Harris, Kamala'                          , 1313503 union
select 'Harris-Forster, Linda'                   , 1292886 union
select 'Hartz, Barry'                            , 1282576 union
select 'Haughey, Thomas'                         , 1358091 union
select 'Haughey, Tom'                            , 1358091 union
select 'Hayashi, Dennis'                         , 1256412 union
select 'Hayashi, Mary'                           , 1266779 union
select 'Hayaski, Dennis'                         , 1256412 union
select 'Haynes, Ray'                             , 1003467 union
select 'Headington, Ed'                          , 1340991 union
select 'Healey, Laurette'                        , 1293653 union
select 'Healy, Laurette'                         , 1293653 union
select 'Hegyi, Paul'                             , 1295619 union
select 'Henry, Kathleen'                         , 1365093 union
select 'Hernandez, Ed'                           , 1266775 union
select 'Hernandez, Edward'                       , 1266775 union
select 'Hernandez, Manny'                        , 1251832 union
select 'Hernandez, Patricia'                     , 1342667 union
select 'Hernandez, Roger'                        , 1276119 union
select 'Hill, Greg'                              , 1255064 union
select 'Hill, Jerrry'                            , 1290757 union
select 'Hill, Jerry'                             , 1290757 union
select 'Hodge, Jason'                            , 1338764 union
select 'Hodges, Sherry'                          , 1336275 union
select 'Hoffman, Andra'                          , 1356984 union
select 'Holden, Chris'                           , 1336467 union
select 'Holden, Nate'                            , 1259132 union
select 'Hollingsworth, Dennis'                   , 1005700 union
select 'Holober, Richard'                        , 1268260 union
select 'Horton, Jerome'                          , 1220801 union
select 'Horton, Shirley'                         , 1240526 union
select 'Houston, Guy'                            , 1226434 union
select 'Howorth, Amy'                            , 1363859 union
select 'Hu, Grace'                               , 1005713 union
select 'Huber, Alyson'                           , 1297647 union
select 'Hueso, Ben'                              , 1315742 union
select 'Huey, Craig'                             , 1342938 union
select 'Huff, Bob'                               , 1005380 union
select 'Huffman, Jared'                          , 1273044 union
select 'Hunter, Tricia'                          , 1003099 union
select 'Iglesias, Cecilia'                       , 1364375 union
select 'Imbasciani, Vito'                        , 1363537 union
select 'Irwin, Jacqui'                           , 1362509 union
select 'Irwin, Jaqui'                            , 1362509 union
select 'Ivie, Rickey'                            , 1255129 union
select 'Jackson, Hanna Beth'                     , 1005917 union
select 'Jackson, Hannah Beth'                    , 1005917 union
select 'Jackson, Hannah-beth'                    , 1005917 union
select 'Jahn, Bill'                              , 1342665 union
select 'Jeandron, Gary'                          , 1294051 union
select 'Jeffries, Kevin'                         , 1274283 union
select 'Jehn, Bob'                               , 1234790 union
select 'Jelincic, J.j.'                          , 1316066 union
select 'Jimmy Gomez for Assembly'                , 1334135 union
select 'Johnson, Brian'                          , 1333179 union
select 'Jones, Brian'                            , 1319720 union
select 'Jones, Dave'                             , 1224542 union
select 'Jones, Henry'                            , 1297428 union
select 'Jones, Linda'                            , 1302094 union
select 'Jones-Sawyer, Reggie'                    , 1317870 union
select 'Jones-Sawyer, Reginald'                  , 1317870 union
select 'Kamala, Harris'                          , 1313503 union
select 'Kamena, Scott'                           , 1290760 union
select 'Karnette, Betty'                         , 1003821 union
select 'Karno, Nick'                             , 1317404 union
select 'Kashkari, Neel'                          , 1362979 union
select 'Keene, Richard'                          , 1239063 union
select 'Keene, Rick'                             , 1239063 union
select 'Kehoe, Christine'                        , 1005669 union
select 'Kim, Young'                              , 1358869 union
select 'Kishimoto, Yoriko'                       , 1316212 union
select 'Klehs, Johan'                            , 1001372 union
select 'Knight, Steve'                           , 1295329 union
select 'Kokkonen, Matt'                          , 1236050 union
select 'Konnyu, Ernie'                           , 1000902 union
select 'Koretz, Paul'                            , 1004239 union
select 'Kraft, Greg'                             , 1341018 union
select 'Kramer, Dan'                             , 1240266 union
select 'Krekorian, Paul'                         , 1005796 union
select 'Krovoza, Joe'                            , 1357709 union
select 'Kuehl, Sheila'                           , 1004301 union
select 'Kuo, Peter'                              , 1361920 union
select 'Kurth, Don'                              , 1314365 union
select 'Kuykendall, Steve'                       , 1257367 union
select 'Kuykendall, Steven'                      , 1257367 union
select 'La Suer, Jay'                            , 1005766 union
select 'Lachman, Andrew'                         , 1333941 union
select 'Lackey, Tom'                             , 1345765 union
select 'Laird, John'                             , 1226901 union
select 'LaMalfa, Doug'                           , 1239935 union
select 'Lancaster, Chris'                        , 1004674 union
select 'Lara, Ricardo'                           , 1304215 union
select 'Lara-Gardner, Joseph'                    , 1343990 union
select 'Laskaris, Greg'                          , 1345828 union
select 'LaSuer, Jay'                             , 1005766 union
select 'Lau, James'                              , 1318502 union
select 'Leddy, Jim'                              , 1250540 union
select 'Ledford, James'                          , 1004988 union
select 'Ledford, Jim'                            , 1004988 union
select 'Leiber, Sally'                           , 1231723 union
select 'Lempert, Ted'                            , 1002880 union
select 'Leno, Mark'                              , 1226645 union
select 'Leon, Paul'                              , 1354799 union
select 'Leonard, Bill'                           , 1000000 union
select 'Levine, Lloyd'                           , 1233568 union
select 'Levine, Marc'                            , 1338897 union
select 'Leyva, Connie'                           , 1364478 union
select 'Lieber, Sally'                           , 1231723 union
select 'Lieu, Ted'                               , 1277958 union
select 'Lin, Matthew'                            , 1343682 union
select 'Linder, Eric'                            , 1345603 union
select 'Liu, Carol'                              , 1005704 union
select 'Lloyd, Judy'                             , 1294244 union
select 'Lockyer, Bill'                           , 1000654 union
select 'Logue, Dan'                              , 1292895 union
select 'Logue, Daniel'                           , 1292895 union
select 'Longville, John'                         , 1003717 union
select 'Lopez, Luis'                             , 1328641 union
select 'Lori Saldana For State Assembly'         , 1252223 union
select 'Low, Evan'                               , 1335519 union
select 'Lowenthal, Alan'                         , 1005392 union
select 'Lowenthal, Bonnie'                       , 1297235 union
select 'Lowenthal, Suja'                         , 1361565 union
select 'Lutness, Carole'                         , 1304206 union
select 'Ma, Fiona'                               , 1261661 union
select 'Machado, Michael'                        , 1003830 union
select 'Machado, Mike'                           , 1003830 union
select 'Maddox, Ken'                             , 1005211 union
select 'Maddox, Kenneth'                         , 1005211 union
select 'Madison, Jonathan'                       , 1365081 union
select 'Maestas, Katherine'                      , 1239998 union
select 'Maggard, Mike'                           , 1235724 union
select 'Maienschein, Brian'                      , 1339637 union
select 'Maldonado, Abbel'                        , 1005389 union
select 'Maldonado, Abel'                         , 1005389 union
select 'Manayan, Henry'                          , 1255423 union
select 'Mansoor, Allan'                          , 1317797 union
select 'Marquez, Luis'                           , 1318038 union
select 'Marshall, G. Rick'                       , 1367063 union
select 'Masry, Ferial'                           , 1262087 union
select 'Mathews, Barbara'                        , 1005671 union
select 'Matthews, Barabara'                      , 1005671 union
select 'Matthews, Barbara'                       , 1005671 union
select 'Mayes, Chad'                             , 1351765 union
select 'Maze, Bill'                              , 1005213 union
select 'Mc Clintock, Tom'                        , 1001573 union
select 'Mc Coy, Rob'                             , 1362964 union
select 'McCammon, Bill'                          , 1275014 union
select 'McCann, John'                            , 1295491 union
select 'McCarthy, Kevin'                         , 1234228 union
select 'McCarty, Kelly'                          , 1297973 union
select 'McCarty, Kevin'                          , 1314046 union
select 'McCaulley, Ollie'                        , 1005214 union
select 'McClintock, Tom'                         , 1001573 union
select 'McCoy, Rob'                              , 1362964 union
select 'McGill, Michael'                         , 1272372 union
select 'McGuire, Mike'                           , 1361301 union
select 'McLeod, Gloria'                          , 1005234 union
select 'McLeod, Gloria Negrete'                  , 1005234 union
select 'McPherson, Bruce'                        , 1004237 union
select 'Medina, Jose'                            , 1005789 union
select 'Melendez, Melissa'                       , 1340675 union
select 'Mendoza, Rodolfo Rudy'                   , 1356174 union
select 'Mendoza, Rudy'                           , 1356174 union
select 'Mendoza, Tony'                           , 1238223 union
select 'Mettler, Ken'                            , 1319804 union
select 'Migden, Carole'                          , 1005175 union
select 'Miles, Larry'                            , 1226768 union
select 'Miller, Glenn'                           , 1356623 union
select 'Miller, Jeff'                            , 1224578 union
select 'Mintz, Nathan'                           , 1323498 union
select 'Mitchell, Holly'                         , 1307762 union
select 'Mobley, Jack'                            , 1294243 union
select 'Mobley, Jack Jr'                         , 1294243 union
select 'Monning, Bill'                           , 1297947 union
select 'Montanez, Cindy'                         , 1238513 union
select 'Monville, Lou'                           , 1238716 union
select 'Moorlach, John'                          , 1241305 union
select 'More, Diana Peterson'                    , 1005687 union
select 'Morrell, Mike'                           , 1252076 union
select 'Mullin, Gene'                            , 1239028 union
select 'Muratsuchi, Al'                          , 1315952 union
select 'Muratsuchi, Albert'                      , 1315952 union
select 'Murray, Cynthia'                         , 1272845 union
select 'Musser-Lopez, Ruth'                      , 1366955 union
select 'Nahabedian, Nayiri'                      , 1323763 union
select 'Nakanishi, Alan'                         , 1005260 union
select 'Nakano, George'                          , 1005226 union
select 'Napoli, Kathy'                           , 1255728 union
select 'Napoli, Kathy Chavez'                    , 1255728 union
select 'Nation, Joe'                             , 1005654 union
select 'Nava, Pedro'                             , 1237583 union
select 'Nazarian, Adrin'                         , 1323126 union
select 'Neal, Steve'                             , 1356272 union
select 'Negrete-McLeod, Gloria'                  , 1005234 union
select 'Nehring, Ron'                            , 1363814 union
select 'Nesbet, Barbara'                         , 1253676 union
select 'Nestande, Brian'                         , 1301731 union
select 'Nevin, Mike'                             , 1253916 union
select 'Newsom, Gavin'                           , 1308192 union
select 'Nguyen, Janet'                           , 1282277 union
select 'Nguyen, Phu'                             , 1323127 union
select 'Nickel, Wiley'                           , 1281915 union
select 'Niello, Roger'                           , 1251659 union
select 'Nielsen, Jim'                            , 1299401 union
select 'Nielson, Jim'                            , 1299401 union
select 'Norby, Chris'                            , 1005701 union
select 'Nunez, Fabian'                           , 1238937 union
select 'Obernolte, Jay'                          , 1362835 union
select 'O''Connell, Jack'                        , 1001286 union
select 'O''Donnell, Patrick'                     , 1296270 union
select 'Ogunleye, Emmanuel'                      , 1284103 union
select 'Olberg, Keith'                           , 1000443 union
select 'Oller, Rico'                             , 1004843 union
select 'Oller, Thomas "Rico"'                    , 1004843 union
select 'Oller, Thomas Rico'                      , 1004843 union
select 'Olsen, Kristin'                          , 1323478 union
select 'Ong, Jennifer'                           , 1337035 union
select 'Ornellas, Leroy'                         , 1342825 union
select 'Oropeza, Jenny'                          , 1005665 union
select 'Ortega, Barbara'                         , 1344203 union
select 'Ortiz, Deborah'                          , 1004844 union
select 'Osborn, Torie'                           , 1331563 union
select 'Pacheco, Gayle'                          , 1252686 union
select 'Paderes, Xochitl Raya'                   , 1343025 union
select 'Padilla, Alex'                           , 1278243 union
select 'Page, Chuck'                             , 1364063 union
select 'Pan, Richard'                            , 1319205 union
select 'Pan., Richard'                           , 1319205 union
select 'Papan, Gina'                             , 1222411 union
select 'Papan, Lou'                              , 1005182 union
select 'Pappan, Gina'                            , 1222411 union
select 'Parker, Darren'                          , 1334890 union
select 'Parra, Nicole'                           , 1234191 union
select 'Parra, Pete'                             , 1322460 union
select 'Paule, Phil'                             , 1339613 union
select 'Pavley, Fran'                            , 1005757 union
select 'Peppler, Susan'                          , 1234645 union
select 'Perea, Henry'                            , 1235519 union
select 'Perez, John'                             , 1304250 union
select 'Perez, Julio'                            , 1338324 union
select 'Perez, Leticia'                          , 1356259 union
select 'Perez, Manuel'                           , 1304928 union
select 'Perez, V. Manuel'                        , 1304928 union
select 'Perozzi, Eliah'                          , 1253677 union
select 'Peterson, Pete'                          , 1356987 union
select 'Pettis, Greg'                            , 1236382 union
select 'Pfeiler, Lori'                           , 1239937 union
select 'Phares, Ana Ventura'                     , 1279382 union
select 'Pinard, Margaret'                        , 1260404 union
select 'Pinard, Peg'                             , 1264204 union
select 'Pineda, Dorthy'                          , 1358125 union
select 'Pirozzi, Elia'                           , 1253677 union
select 'Plescia, George'                         , 1240145 union
select 'Podesto, Gary'                           , 1256414 union
select 'Pohl, Bob'                               , 1240644 union
select 'Pohl, Robert'                            , 1240644 union
select 'Poizner, Steve'                          , 1256885 union
select 'Ponce, Oliver'                           , 1364568 union
select 'Poochigian, Charles'                     , 1004258 union
select 'Poochigian, Chuck'                       , 1004258 union
select 'Portantino, Anthony'                     , 1267043 union
select 'Price, Curren'                           , 1317525 union
select 'Pruitt, David'                           , 1252396 union
select 'Pruitt, David Roa'                       , 1252396 union
select 'Pugno, Andrew'                           , 1318501 union
select 'Pugno, Andy'                             , 1318501 union
select 'Quintero, Frank'                         , 1279157 union
select 'Quinto, Ray'                             , 1005526 union
select 'Quirk, Bill'                             , 1336944 union
select 'Quirk-Silva, Sharon'                     , 1345707 union
select 'Ramani, Sunder'                          , 1323715 union
select 'Ramirez, Rick'                           , 1268262 union
select 'Ramirez, Rudy'                           , 1343680 union
select 'Ramsey, Charles'                         , 1234430 union
select 'Rao, Robert'                             , 1274869 union
select 'Reilly, Emily'                           , 1226904 union
select 'Reilly, Janet'                           , 1274238 union
select 'Rendon, Anthony'                         , 1335212 union
select 'Ricasa, Arlie'                           , 1255515 union
select 'Richardson, Laura'                       , 1272529 union
select 'Richardson, Luara'                       , 1272529 union
select 'Richman, Keith'                          , 1005656 union
select 'Ridley-Thomas, Mark'                     , 1240873 union
select 'Ridley-Thomas, Sebastian'                , 1358246 union
select 'Riordan, Richard'                        , 1236522 union
select 'Rios, Pedro'                             , 1343678 union
select 'Rodriguez, Freddie'                      , 1354976 union
select 'Roelle, Rick'                            , 1362190 union
select 'Romero, Gloria'                          , 1005525 union
select 'Roth, Richard'                           , 1343716 union
select 'Rubio, Michael'                          , 1308516 union
select 'Runner, George'                          , 1005399 union
select 'Runner, Sharon'                          , 1238644 union
select 'Rush, Robert'                            , 1345430 union
select 'Ruskin, Ira'                             , 1252810 union
select 'Rusnak, Victoria'                        , 1344862 union
select 'Russo, John'                             , 1272104 union
select 'Salas, Mary'                             , 1276162 union
select 'Salas, Rudy'                             , 1340989 union
select 'Saldana, Lori'                           , 1252223 union
select 'Salinas, Simon'                          , 1005673 union
select 'Sanchez, Alfonso'                        , 1364707 union
select 'Santiago, Miguel'                        , 1357853 union
select 'Sbranti, Tim'                            , 1356108 union
select 'Schaupp, Charles'                        , 1301596 union
select 'Schauppp, Charles'                       , 1301596 union
select 'Scherman, Sophia'                        , 1337935 union
select 'Schnur, Dan'                             , 1362691 union
select 'Schwarzenegger, Arnold'                  , 1256983 union
select 'Schwarzenegger, Californians For'        , 1256983 union
select 'Scott, Jack'                             , 1004873 union
select 'Sd, Ellen Corbett'                       , 1005551 union
select 'Secretary of State, Debra Bowen for'     , 1003952 union
select 'Shaw, Elaine'                            , 1260782 union
select 'Shelley, Kevin'                          , 1004818 union
select 'Shelley, Susan'                          , 1355797 union
select 'Sherard, Maxine'                         , 1241244 union
select 'Sidhu, Harry'                            , 1296043 union
select 'Sieglock, Jack'                          , 1296571 union
select 'Silva, Sharon Quark'                     , 1345707 union
select 'Silva, Sharon Quirk'                     , 1345707 union
select 'Silva, Sharon Quirk-'                    , 1345707 union
select 'Simitian, Joe'                           , 1004819 union
select 'Simitian, Joseph'                        , 1004819 union
select 'Simon, Bill'                             , 1233558 union
select 'Skinner, Nancy'                          , 1303644 union
select 'Smith, Bob'                              , 1295956 union
select 'Smyth, Cameron'                          , 1277161 union
select 'Snodgrass, Donna'                        , 1334350 union
select 'Solario, Jose'                           , 1279123 union
select 'Soloria, Jose'                           , 1279123 union
select 'Solorio, Jose'                           , 1279123 union
select 'Soto, Nell'                              , 1005200 union
select 'Speier, Jackie'                          , 1005471 union
select 'Steckler, Craig'                         , 1360848 union
select 'Steel, Michelle Park'                    , 1257034 union
select 'Steele, Michelle'                        , 1257034 union
select 'Stein, Greg'                             , 1235090 union
select 'Steinorth, Marc'                         , 1362221 union
select 'Stevens, George'                         , 1240050 union
select 'Stirling, Larry'                         , 1001128 union
select 'Stoker, Mike'                            , 1319188 union
select 'Stone, Jeff'                             , 1238568 union
select 'Stone, Mark'                             , 1340922 union
select 'Strickland, Audra'                       , 1251045 union
select 'Strickland, Tony'                        , 1005462 union
select 'Sullinger, Michael'                      , 1343885 union
select 'Swanson, Sandre'                         , 1268691 union
select 'Swearengin, Ashley'                      , 1364602 union
select 'Tateishi, Peter'                         , 1341059 union
select 'Taylor, Theresa'                         , 1365563 union
select 'Thiesen, Tim'                            , 1325253 union
select 'Thomas, Mark Ridley-'                    , 1240873 union
select 'Thurmond, Tony'                          , 1295704 union
select 'Ting, Phil'                              , 1343138 union
select 'Topalian, Rita'                          , 1259659 union
select 'Torkalson, Tom'                          , 1314864 union
select 'Torlakson, Tom'                          , 1314864 union
select 'Torliatt, Pam'                           , 1277236 union
select 'Torliatt, Pamela'                        , 1277236 union
select 'Torres, Norma'                           , 1226719 union
select 'Torrico, Albert'                         , 1253526 union
select 'Torrico, Alberto'                        , 1253526 union
select 'Tran, Kim'                               , 1287566 union
select 'Tran, Van'                               , 1228283 union
select 'Tuck, Marshal'                           , 1359836 union
select 'Tuck, Marshall'                          , 1359836 union
select 'Umberg, Thomas'                          , 1241318 union
select 'Umberg, Tom'                             , 1241318 union
select 'Uranga, Tonia Reyes'                     , 1005074 union
select 'Valadao, David'                          , 1322852 union
select 'Vargas, Juan'                            , 1005741 union
select 'Velazquez, Ignacio'                      , 1282084 union
select 'Vidak, Andy'                             , 1356182 union
select 'Vidak, James Andrew'                     , 1356182 union
select 'Villaraigosa, Antonio'                   , 1004202 union
select 'Villines, Michael'                       , 1255183 union
select 'Villines, Mike'                          , 1255183 union
select 'Vincent, Ed'                             , 1004240 union
select 'Von Assembly, Heidi'                     , 1255130 union
select 'Voorakkara, Sid'                         , 1342400 union
select 'Wagner, Don'                             , 1260382 union
select 'Waldman, Stuart'                         , 1232025 union
select 'Waldron, Marie'                          , 1273672 union
select 'Walker, Larry'                           , 1354087 union
select 'Walker, Propher'                         , 1357980 union
select 'Walker, Prophet'                         , 1357980 union
select 'Walsh, Chad'                             , 1341787 union
select 'Walters, Mimi'                           , 1251751 union
select 'Wapner, Alan'                            , 1260456 union
select 'Warren, Acquanetta'                      , 1315949 union
select 'Weber, Shirley'                          , 1342820 union
select 'Weickowski, Robert'                      , 1315744 union
select 'Wells, Bill'                             , 1319865 union
select 'Werdegar, Kathryn'                       , 1004646 union
select 'Westley, Steve'                          , 1230848 union
select 'Westly, Steve'                           , 1230848 union
select 'Whalen, Bob'                             , 1305348 union
select 'Whitman, Margaret'                       , 1315466 union
select 'Whitman, Meg'                            , 1315466 union
select 'Wieckowski, Bob'                         , 1315744 union
select 'Wieckowski, Robert'                      , 1315744 union
select 'Wilk, Scott'                             , 1339656 union
select 'Williams, Bob'                           , 1344726 union
select 'Williams, Das'                           , 1316434 union
select 'Willoughby, Abthony'                     , 1258980 union
select 'Willoughby, Anthony'                     , 1258980 union
select 'Wilson, Abram'                           , 1298171 union
select 'Wilson, Michael'                         , 1321642 union
select 'Wilson, Thomas'                          , 1241312 union
select 'Wilson, Tom'                             , 1241312 union
select 'Wolk, Dan'                               , 1358062 union
select 'Wolk, Lois'                              , 1235630 union
select 'Wood, James'                             , 1353393 union
select 'Wood, Jim'                               , 1353393 union
select 'Wright, Rod'                             , 1005448 union
select 'Wyland, Mark'                            , 1231396 union
select 'Wyman, Phil'                             , 1000286 union
select 'Yamada, Mariko'                          , 1295701 union
select 'Yee, Betty'                              , 1273041 union
select 'Yee, Garrett'                            , 1318661 union
select 'Yee, Leland'                             , 1226856 union
select 'Young, Joel'                             , 1334464 union
select 'Zettel, Charlene'                        , 1005446 union
select 'Zettle, Charlene'                        , 1005446 union
select 'Zink, Todd'                              , 1345540 union
-- new synonyms 2015-09-03
select 'Californians for Better Jobs and a Stronger Economy, to Elect Bob Wieckowski for Senate 2014', 1315744 union
select 'Criminal Sentences. Misdemeanor Penalties; State of California', 1363898 union
select 'Dababneh, Assemblymember Matt'           , 1357054 union
select 'Davis, Recall Gray'                      , 1256382 union
select 'Davis, Recall of Governor'               , 1256382 union
select 'Dickinson, Assemblymember Roger'         , 1251341 union
select 'Gonzalez, Lorena'                        , 1353845 union
select 'Gray, Assemblymember Adam'               , 1315410 union
select 'Hernandez, Assemblymember Roger'         , 1276119 union
select 'Hill, Assemblymember Jerry'              , 1290757 union
select 'Initiative, Cigarette Tax'               , 1285369 union
select 'Lancaster, Christopher'                  , 1004674 union
select 'Levine, Assemblymember Marc'             , 1338897 union
select 'Lowe, Robin'                             , 1274674 union
select 'Medi-Cal Funding and Accountability Act of 2014 AG#13-0022', 1362198 union
select 'Miller, Assemblymember Jeff'             , 1224578 union
select 'No on 23 - Californians to Stop the Dirty Energy Proposition', 1324800 union
select 'Pan, Assemblymember Richard'             , 1319205 union
select 'Perez, Irella'                           , 1361430 union
select 'Pico, Tom'                               , 1226606 union
select 'Prohibits Political Contributions by payroll deductions, Prohibitions on Contribution to Candidates, Intiative Statute', 1338955 union
select 'Recall of Jeff Denham'                   , 1305462 union
select 'Salas, Assemblymember Rudy'              , 1340989 union
select 'Salas, Brenda'                           , 1273312 union
select 'The Schools and Local Public Safety Protection Act of 2012', 1346100 union
select 'Torres, Assemblymember Norma'            , 1226719 union
select 'Verone, Patric'                          , 1364606 union
select 'Wieckowski, Assemblymember Bob'          , 1315744 union
select 'Working Californians to Oppose Prop. 32' , 1338955 union
select 'Yee, Assemblymember Garrett'             , 1318661 union
select 'Yes on 21, Californians for State Parks and Wildlife Conservation, sponsored by conservation and state parks organizations', 1323361
;

-- for ambiguous cases where ElectionCycle matters (propositions, different candidates with the same name)
INSERT candidate_name_spellings (ElectionCycle, TargetCandidateName, TargetCandidateID)
select 2009, 'PROPOSITION 20'                          , 1322428 union
select 2009, 'Proposition 23'                          , 1324800 union
select 2009, 'Proposition 24'                          , 1323279 union
select 2009, 'PROPOSITION 25'                          , 1323274 union
select 2009, 'Proposition 26'                          , 1323965 union
select 2009, 'PROPOSITION 27'                          , 1324469 union
select 2003, 'Proposition 57'                          , 1261013 union
select 2005, 'PROPOSITION 86'                          , 1285369 union
select 2003, 'Recall, No On'                           , 1256382
;

DROP TABLE IF EXISTS candidate_name_spellings_ignore;

CREATE TABLE candidate_name_spellings_ignore (
  ElectionCycle SMALLINT NULL,
  TargetCandidateName VARCHAR(250) NOT NULL,
  UNIQUE KEY CycleName (ElectionCycle, TargetCandidateName),
  KEY TargetCandidateName (TargetCandidateName),
  KEY ElectionCycle (ElectionCycle)
);

INSERT candidate_name_spellings_ignore (TargetCandidateName)
-- 2015-09-03
select ', Nunez' union
select 'Alari, Steven' union
select 'Alliance For A Better California' union
select 'Alpay For SchoolBoard 2012' union
select 'Amy Hanacek For School Board 2012' union
select 'Anderson, Charlene' union
select 'Avila, Paul' union
select 'Baxter, Marvin' union
select 'Benitez, Ricardo' union
select 'Bennett Kayser for School Board 2011' union
select 'Bera, Ami' union
select 'Betancourt, Paul' union
select 'Bui, Nancy' union
select 'Call, Dustin' union
select 'Calvert, Sandy' union
select 'capoRecall2010' union
select 'Christian-Heising, Mary' union
select 'Coffey, John' union
select 'Contra Costa United for Responsible Growth' union
select 'Coulter, George' union
select 'Donna Frye For Mayor' union
select 'Eaton, David' union
select 'F., Moreno Jose' union
select 'For, Susan Peters' union
select 'Foster, Linda' union
select 'Fuentes, Chuck' union
select 'Fuentes, Linda' union
select 'Fuller, Clyde' union
select 'Geer, Bob' union
select 'Gonsalves, Kevin' union
select 'Gonzales, Richard' union
select 'Gonzales, Rick' union
select 'Gorsulowsky, Tim' union
select 'Guerrero, Arthur Bravo' union
select 'Heising, Mary Christian' union
select 'Hernandez, Reuben "RJ"' union
select 'Hernandez, Reuben Rj' union
select 'Hertle, Michaela' union
select 'Hurley, Patrick' union
select 'Kern, Lori' union
select 'Lillpop, Gerald' union
select 'MacEnery, Eileen' union
select 'Montaine, Rick' union
select 'Monterey Bay Central Labor Council' union
select 'Moreno, Carlos' union
select 'Morgan, Mike' union
select 'Morrison, Holly' union
select 'Needs, Sandra' union
select 'nevada county candidates, Republican candidates' union
select 'Ohls, Lou' union
select 'Padilla, Steven' union
select 'Party, California Democratic' union
select 'Party, California Republican' union
select 'Paul, Betancourt' union
select 'Pedretti, Gino' union
select 'Perez, Jose Luis' union
select 'Pimentel, Billy' union
select 'Preciado, Jose' union
select 'Proposition B, City of San Diego' union
select 'Responsible Government, Taxpayers for' union
select 'Rogers, Barbara' union
select 'SACRAMENTO FOR RESPONSIBLE GOVERNMENT' union
select 'Salazar, Jerry' union
select 'San Diegans For Scott Peters 2004' union
select 'San Francisco Labor Council' union
select 'South Bay Labor Council' union
select 'Stamps, Bill' union
select 'Svolos, Charlotte' union
select 'Tsai, Nathaniel' union
select 'United, Neighborhoods' union
select 'Voss, Ed' union
select 'Voter Education And Registration Fund (VERF)' union
select 'Yes On Measure B' union
select 'Yes On Measure D Santa Clara County' union
select 'Yes On Measure P - Delano' union
select 'Zamudio, Ernesto' union
select 'Zucchet for City Council' union
select 'Zucchet, Michael' union
-- 2015-09-18
select 'Clc, Contra Costa'
;

-- TK for cases (if any) where ElectionCycle matters (propositions, candidates with similar names)
-- INSERT candidate_name_spellings_ignore (ElectionCycle, TargetCandidateName)
-- ;
-- 
DROP TABLE IF EXISTS proposition_name_spellings;

CREATE TABLE proposition_name_spellings (
  ElectionCycle SMALLINT NOT NULL,
  TargetPropositionNumber VARCHAR(10) NOT NULL,
  TargetPropositionNameOriginal VARCHAR(250) NOT NULL,
  TargetPropositionID BIGINT NOT NULL DEFAULT 0,
  PRIMARY KEY (ElectionCycle, TargetPropositionNumber, TargetPropositionNameOriginal)
);

INSERT proposition_name_spellings (ElectionCycle, TargetPropositionID, TargetPropositionNumber, TargetPropositionNameOriginal)
select 2001, 1239148, '40' , 'CA Clean Water, Clean Air, Safe Neighborhood Parks and Coastal Protection Act of 2002'                                                                                                               union
select 2001, 1239148, '40' , 'CA. CLEAN WATER, CLEAN AIR, SAFE NEIGHBORHOOD PARKS AND COASTAL PROTECTION  ACT OF 2002'                                                                                                             union
select 2001, 1239148, '40' , 'Prop. 40 - CA Clean Water, Clean Air, Safe Neighborhood Parks & Coastal Protection Act'                                                                                                              union
select 2001, 1239148, '40' , 'Proposition 40'                                                                                                                                                                                      union
select 2001, 1239150, '41' , 'Prop. 41 - Voting Modernization Bond Act of 2002'                                                                                                                                                    union
select 2001, 1239150, '41' , 'Proposition 41'                                                                                                                                                                                      union
select 2001, 1239150, '41' , 'Voting Modernization Act of 2002'                                                                                                                                                                    union
select 2001, 1238835, '42' , 'Prop. 42 - Transportation Funding: Sales & Use Tax Revenues'                                                                                                                                         union
select 2001, 1238835, '42' , 'Transportation Funding: Sales & Use Tax Revenues'                                                                                                                                                    union
select 2001, 1238835, '42' , 'Transportaton Funding: Sales & Use Tax Revenue'                                                                                                                                                      union
select 2001, 1238846, '43' , 'Prop. 43 - Right to Have Vote Counted.'                                                                                                                                                              union
select 2001, 1238846, '43' , 'Proposition 43'                                                                                                                                                                                      union
select 2001, 1238846, '43' , 'Right to Have Vote Counted'                                                                                                                                                                          union
select 2001, 1238847, '44' , 'Insurance Fraud'                                                                                                                                                                                     union
select 2001, 1238847, '44' , 'Prop. 44 - Insurance Fraud'                                                                                                                                                                          union
select 2001, 1238847, '44' , 'Proposition 44'                                                                                                                                                                                      union
select 2001, 1237346, '45' , 'Legislative Term Limits'                                                                                                                                                                             union
select 2001, 1237346, '45' , 'Legislative Term Limits, Local Vote Petitions'                                                                                                                                                       union
select 2001, 1237346, '45' , 'Legislative Term Limits. Local Voter Petitions. Constitutional Amend.'                                                                                                                               union
select 2001, 1237346, '45' , 'Legislative Term Limits. Local Voter Petitions. Constitutional Amend. Prop. 45'                                                                                                                      union
select 2001, 1237346, '45' , 'Proposition 45'                                                                                                                                                                                      union
select 2001, 1244959, '46' , 'Coalition for Emergency Shelter and Afforable Housing - Prop 46'                                                                                                                                     union
select 2001, 1244959, '46' , 'Housing and Emergency Shelter Trust Fund Act of 2002'                                                                                                                                                union
select 2001, 1244959, '46' , 'Prop. 46 - Housing & Emergency Shelter Trust Fund Act of 2002'                                                                                                                                       union
select 2001, 1244959, '46' , 'Proposition 46'                                                                                                                                                                                      union
select 2001, 1244959, '46' , 'Proposition 46 - Housing and Emergency Shelter Trust Fund Act of 2002'                                                                                                                               union
select 2001, 1244960, '46' , 'School Bonds'                                                                                                                                                                                        union
select 2001, 1244959, '46' , 'Yes on Proposition 46 -Housing & Emergency Shelter Trust Fund Act of 2002'                                                                                                                           union
select 2001, 1244960, '47' , 'Accountability and Better Schools'                                                                                                                                                                   union
select 2001, 1244960, '47' , 'Education Bond 2002'                                                                                                                                                                                 union
select 2001, 1244960, '47' , 'Fund for Better Schools - Proposition 47'                                                                                                                                                            union
select 2001, 1244960, '47' , 'Prop 47 - Kindergarten-University Public Education Facilities Bond Act of 2002'                                                                                                                      union
select 2001, 1244960, '47' , 'Prop. 47 - Kindergarten-University Public Education Facilities Bond Act of 2002'                                                                                                                     union
select 2001, 1244960, '47' , 'Proposition 47'                                                                                                                                                                                      union
select 2001, 1244960, '47' , 'Proposition 47 - Kindergarten-University Public Education Facilities Bond Act of 2002'                                                                                                               union
select 2001, 1245253, '48' , 'Proposition 48'                                                                                                                                                                                      union
select 2001, 1245253, '48' , 'Proposition 48 -Court Consolidation'                                                                                                                                                                 union
select 2001, 1245288, '49' , 'Before and After School Programs'                                                                                                                                                                    union
select 2001, 1245288, '49' , 'Prop 49 - Before & After School Programs, State Grants'                                                                                                                                              union
select 2001, 1245288, '49' , 'Prop 49 - Before & After School Programs, State Grants, Initiative Statute'                                                                                                                          union
select 2001, 1245288, '49' , 'Prop 49 - State of California, Before & After School Programs, State Grants'                                                                                                                         union
select 2001, 1244594, '50' , 'Prop. 50 - Water Quality, Supply & Safe Drinking Water Projects, Coastal Wetlands...'                                                                                                                union
select 2001, 1244594, '50' , 'Proposition 50'                                                                                                                                                                                      union
select 2001, 1244594, '50' , 'Proposition 50 -Water Quality'                                                                                                                                                                       union
select 2001, 1244594, '50' , 'Water Quality, Supply & Safe Drinking Water Projects. Coastal Wetlands Purchase Protection'                                                                                                          union
select 2001, 1244594, '50' , 'Water Quality, Supply, & Safe Drinking Water'                                                                                                                                                        union
select 2001, 1244594, '50' , 'Yes Proposition 50-Water Quality, Supply & Safe Drinking Water Projects.'                                                                                                                            union
select 2001, 1244589, '51' , 'Distribution of Existing Motor Vehicle Sales & Use Tax'                                                                                                                                              union
select 2001, 1244589, '51' , 'Prop 51 - Transportation, Distribution of Existing Motor Vehicle Sales & Use Tax'                                                                                                                    union
select 2001, 1244589, '51' , 'Prop 51 - Transportation, Distribution of Existing Motor Vehicle Sales and Use Tax'                                                                                                                  union
select 2001, 1244588, '52' , 'Californians for Election Day Voter Reg. - Prop 52'                                                                                                                                                  union
select 2001, 1244588, '52' , 'Election Day Voter Registration Act of 2002'                                                                                                                                                         union
select 2001, 1244588, '52' , 'No On Prop 52'                                                                                                                                                                                       union
select 2001, 1244588, '52' , 'Prop. 52 - Election Day Voter Registration Initative Statue'                                                                                                                                         union
select 2001, 1244588, '52' , 'Proposition 52'                                                                                                                                                                                      union
select 2001, 1244588, '52' , 'Proposition 52 - Election Day Voter Registration'                                                                                                                                                    union
select 2001, 1244588, '52' , 'Proposition 52 - Election Day Voter Registration, Initiative Statute'                                                                                                                                union
select 2001, 1244588, '52' , 'Yes on Proposition 52- Election Day Voter Registration'                                                                                                                                              union
select 2001, 1237346, ''   , 'Proposition 45'                                                                                                                                                                                      union
select 2001, 1244588, ''   , 'Proposition 52 - Election Day Voter Registration'                                                                                                                                                    union
select 2003, 1256382, '*'  , 'Recall of Governor Gray Davis'                                                                                                                                                                       union
select 2003, 1256382, '00' , 'Recall of the Governor'                                                                                                                                                                              union
select 2003, 1267682, '1A' , 'Cas to Protect Local Taxpayers & Public Safety - Yes on Prop 1A'                                                                                                                                     union
select 2003, 1267682, '1A' , 'Prop. 1A, Protection of Local Government Revenues'                                                                                                                                                   union
select 2003, 1267682, '1A' , 'Proposition 1A'                                                                                                                                                                                      union
select 2003, 1267682, '1A' , 'Proposition 1A - Protection of Local Government Revenues'                                                                                                                                            union
select 2003, 1267682, '1A' , 'Proposition 1A. Protection of Local Government Revenues'                                                                                                                                             union
select 2003, 1267682, '1A' , 'PROTECTION OF LOCAL GOVERNMENT REVENUES'                                                                                                                                                             union
select 2003, 1255050, '53' , 'Funds Dedicated for State & Local Infrastructure'                                                                                                                                                    union
select 2003, 1255050, '53' , 'Funds Dedicated For State and Local Infrastructure'                                                                                                                                                  union
select 2003, 1255050, '53' , 'Infrastructure Finance'                                                                                                                                                                              union
select 2003, 1255050, '53' , 'Infrastructure Finance - Proposition 53'                                                                                                                                                             union
select 2003, 1255050, '53' , 'Infrastructure: Finance'                                                                                                                                                                             union
select 2003, 1244577, '54' , 'Classification by race ethnicity color or national origin.'                                                                                                                                          union
select 2003, 1244577, '54' , 'Classification by Race, Ethicity, Color or National Origin'                                                                                                                                          union
select 2003, 1244577, '54' , 'Classification by Race, Ethnicity, Color or National Origin'                                                                                                                                         union
select 2003, 1244577, '54' , 'Classificaton by Race, Ethnicity, Color or National Origin'                                                                                                                                          union
select 2003, 1244577, '54' , 'Prop. 54 - Classification by Race, Ethnicity, Color, or National Origin'                                                                                                                             union
select 2003, 1244577, '54' , 'Proposition 54'                                                                                                                                                                                      union
select 2003, 1255049, '55' , 'Kindergarten-University Public Education Bond Act 2004'                                                                                                                                              union
select 2003, 1255049, '55' , 'Kindergarten-University Public Education Facilities Bond Act'                                                                                                                                        union
select 2003, 1255049, '55' , 'Prop. 55 - Kindergarten-University Public Education Facilities Bond Act of 2004'                                                                                                                     union
select 2003, 1255049, '55' , 'Proposition 55 - Kindergarten University Public Education Facilities Bond'                                                                                                                           union
select 2003, 1260878, '56' , 'Budget Accountability Act'                                                                                                                                                                           union
select 2003, 1260878, '56' , 'No Blank Check'                                                                                                                                                                                      union
select 2003, 1260878, '56' , 'Proposition 56 - Budget Accountability Act'                                                                                                                                                          union
select 2003, 1260878, '56' , 'Proposition 56 - State Budget, Related Taxes and Reserve. Voting Requirements, Penalties..'                                                                                                          union
select 2003, 1260878, '56' , 'Proposition 56. Budget Accountability Act'                                                                                                                                                           union
select 2003, 1260878, '56' , 'State Budget Related Taxes and Reserve Voting Requirement Initiative Constitutional'                                                                                                                 union
select 2003, 1260878, '56' , 'State Budget, Related Taxes, and Reserve'                                                                                                                                                            union
select 2003, 1260878, '56' , 'State Budget, Related Taxes, And Reserve, Voting Requirement Initiative Constitutional Amendment'                                                                                                    union
select 2003, 1261013, '57' , 'Economic Recovery Bond Act'                                                                                                                                                                          union
select 2003, 1261013, '57' , 'Prop. 57 - The Economic Recovery Action'                                                                                                                                                             union
select 2003, 1261013, '57' , 'Proposition 57 - Economic Recovery Bond'                                                                                                                                                             union
select 2003, 1261013, '57' , 'The Economic Recovery Bond Act - Prop. 57'                                                                                                                                                           union
select 2003, 1261015, '58' , 'California Balanced Budget Act'                                                                                                                                                                      union
select 2003, 1261015, '58' , 'The California Balanced Budget Act. - Prop. 58'                                                                                                                                                      union
select 2003, 1265077, '59' , 'Proposition 59'                                                                                                                                                                                      union
select 2003, 1265077, '59' , 'Public Records, Open Meetings Leg. Const. Amend.'                                                                                                                                                    union
select 2003, 1266469, '60' , 'Proposition 60'                                                                                                                                                                                      union
select 2003, 1267683, '60A', 'Proposition 60A'                                                                                                                                                                                     union
select 2003, 1260985, '61' , 'Proposition 61'                                                                                                                                                                                      union
select 2003, 1260985, '61' , 'Yes on Childrens Hospitals - Yes on Prop 61'                                                                                                                                                         union
select 2003, 1260856, '62' , 'Elections. Primaries. Initiative Constitutional Am'                                                                                                                                                  union
select 2003, 1260856, '62' , 'Proposition 62'                                                                                                                                                                                      union
select 2003, 1260927, '63' , 'MENTAL HEALTH SERVICES EXPANSION'                                                                                                                                                                    union
select 2003, 1260927, '63' , 'No on 63'                                                                                                                                                                                            union
select 2003, 1260927, '63' , 'Proposition'                                                                                                                                                                                         union
select 2003, 1260927, '63' , 'Proposition 63'                                                                                                                                                                                      union
select 2003, 1264264, '64' , 'Limits on Enf. Of Unfair Bus. Competition Laws'                                                                                                                                                      union
select 2003, 1264264, '64' , 'Proposition'                                                                                                                                                                                         union
select 2003, 1264264, '64' , 'Proposition 64'                                                                                                                                                                                      union
select 2003, 1264264, '64' , 'Yes on 64'                                                                                                                                                                                           union
select 2003, 1264316, '65' , 'Local Gov. Funds, Revenues. State Mandates. Initi'                                                                                                                                                   union
select 2003, 1264261, '66' , 'Limitation on Three Strikes'                                                                                                                                                                         union
select 2003, 1264261, '66' , 'Limitation on Three Strikes Law'                                                                                                                                                                     union
select 2003, 1264261, '66' , 'Limitations on Three Strikes Law'                                                                                                                                                                    union
select 2003, 1264261, '66' , 'Prop. 66, Limits Three Strikes Law'                                                                                                                                                                  union
select 2003, 1264261, '66' , 'Proposition 66'                                                                                                                                                                                      union
select 2003, 1263795, '67' , 'Emergency Room Services Tax on Telephones'                                                                                                                                                           union
select 2003, 1263795, '67' , 'No on 67'                                                                                                                                                                                            union
select 2003, 1263795, '67' , 'Proposition'                                                                                                                                                                                         union
select 2003, 1263795, '67' , 'Proposition 67'                                                                                                                                                                                      union
select 2003, 1263795, '67' , 'Yes on Prop. 67 '                                                                                                                                                                                    union
select 2003, 1263263, '68' , 'Californians Against the Deceptive Gambling Proposition 68'                                                                                                                                          union
select 2003, 1263263, '68' , 'No On 68'                                                                                                                                                                                            union
select 2003, 1263263, '68' , 'Proposition'                                                                                                                                                                                         union
select 2003, 1263263, '68' , 'Proposition 68'                                                                                                                                                                                      union
select 2003, 1264308, '69' , 'DNA Samples. Collection. Database. Funding. Initiative Statute.'                                                                                                                                     union
select 2003, 1264308, '69' , 'Prop. 69, DNA Samples; Database'                                                                                                                                                                     union
select 2003, 1264308, '69' , 'Proposition 69'                                                                                                                                                                                      union
select 2003, 1264308, '69' , 'Proposition 69 - DNA Samples. Collection. Database Funding, Initiative Statute.'                                                                                                                     union
select 2003, 1264308, '69' , 'Proposition 69.  DNA Samples. Collection. Database.'                                                                                                                                                 union
select 2003, 1264620, '70' , 'Proposition 70'                                                                                                                                                                                      union
select 2003, 1265692, '71' , 'Coalition for Stem Cell Research an Cures - Yes on Prop 71'                                                                                                                                          union
select 2003, 1265692, '71' , 'Proposition 71'                                                                                                                                                                                      union
select 2003, 1265692, '71' , 'Yes on 71'                                                                                                                                                                                           union
select 2003, 1265692, '71' , 'Yes on Prop.71'                                                                                                                                                                                      union
select 2003, 1260875, '72' , 'Health Care'                                                                                                                                                                                         union
select 2003, 1260875, '72' , 'Health Care Coverage'                                                                                                                                                                                union
select 2003, 1260875, '72' , 'Health Care Coverage Requirements Referendum'                                                                                                                                                        union
select 2003, 1260875, '72' , 'No on 72'                                                                                                                                                                                            union
select 2003, 1260875, '72' , 'Proposition'                                                                                                                                                                                         union
select 2003, 1260875, '72' , 'Proposition 72'                                                                                                                                                                                      union
select 2003, 1260875, '72' , 'Proposition 72 - Health Care Coverage Requirements'                                                                                                                                                  union
select 2003, 1260875, '72' , 'Proposition 72. Health Care Coverage Requirements'                                                                                                                                                   union
select 2003, 1260875, '72' , 'Ref Pet. To Overturn Amend. To Health Coverage Req'                                                                                                                                                  union
select 2003, 1260875, '72' , 'Save Your Healthcare Supported by Nurses, Doctors, Unions, Consumer Advocates - Yes on 72'                                                                                                           union
select 2003, 1260875, '72' , 'Yes on 72'                                                                                                                                                                                           union
select 2003, 1260875, '72' , 'Yes on 72 Save Our Healthcare'                                                                                                                                                                       union
select 2003, 1260875, '72' , 'Yes on Prop.72  '                                                                                                                                                                                    union
select 2003, 1256382, 'n/a', 'No On Recall Of Governor Davis'                                                                                                                                                                      union
select 2003, 1256382, 'N/A', 'Shall Gray Davis be recalled from the office of Governor?'                                                                                                                                           union
select 2003, 1256382, 'YES', 'Recall'                                                                                                                                                                                              union
select 2003, 1256382, ''   , 'Californians Against the Costly Recall of the Governor'                                                                                                                                              union
select 2003, 1256382, ''   , 'Californians For Stability - No On The Governor''s Recall'                                                                                                                                           union
select 2003, 1256382, ''   , 'Gubernatorial Recall'                                                                                                                                                                                union
select 2003, 1256382, ''   , 'Gubernatorial Recall Election'                                                                                                                                                                       union
select 2003, 1255050, ''   , 'Local Government: General Obligation Bonds: Infrastructure Projects - Prop. 53'                                                                                                                      union
select 2003, 1256382, ''   , 'No On Recall'                                                                                                                                                                                        union
select 2003, 1256382, ''   , 'No On Recall Of Governor Davis     '                                                                                                                                                                 union
select 2003, 1256382, ''   , 'NO ON THE RECALL'                                                                                                                                                                                    union
select 2003, 1260875, ''   , 'Proposition 72 - Health Care Coverage Requirements'                                                                                                                                                  union
select 2003, 1256382, ''   , 'Recall Governor Gray Davis'                                                                                                                                                                          union
select 2003, 1256382, ''   , 'Recall of Governor Davis'                                                                                                                                                                            union
select 2003, 1256382, ''   , 'Recall of Governor Gray Davis'                                                                                                                                                                       union
select 2003, 1256382, ''   , 'Recall of the Governor'                                                                                                                                                                              union
select 2003, 1256382, ''   , 'Shall Gray Davis be recalled from the office of Governor?'                                                                                                                                           union
select 2003, 1256382, ''   , 'Yes on Recall'                                                                                                                                                                                       union
select 2005, 1286823, '1A' , 'Prop. 1A - Transportation Investment Fund'                                                                                                                                                           union
select 2005, 1286823, '1A' , 'Proposition 1A. Transportation Investment Fund'                                                                                                                                                      union
select 2005, 1286823, '1A' , 'Proposition 1A. Transportation Investment Fund.'                                                                                                                                                     union
select 2005, 1286824, '1B' , 'Highway Safety, Traffic Reduction, Air Quality, and Port Security Bond Act of 2006'                                                                                                                  union
select 2005, 1286824, '1B' , 'Prop. 1B - Highway Safety, Traffic Reduction, Air Quality, Port Security Bond'                                                                                                                       union
select 2005, 1286824, '1B' , 'Proposition 1B. Highway Safety, Traffic Reduction, Air Quality, Port Security Bond'                                                                                                                  union
select 2005, 1286824, '1B' , 'Proposition 1B. Highway Safety, Traffic Reduction, Air Quality, Port Security Bond Act.'                                                                                                             union
select 2005, 1286826, '1C' , 'Housing and Emergency Shelter Trust Fund Act of 2006.'                                                                                                                                               union
select 2005, 1286826, '1C' , 'Porp. 1C - Housing and Emergency Shelter Trust Fund Act of 2006'                                                                                                                                     union
select 2005, 1286826, '1C' , 'Proposition 1C. Housing and Emergency Shelter Trust Fund Act of 2006.'                                                                                                                               union
select 2005, 1286827, '1D' , 'Kindergarten - University Public Education Facilities Bond Act of 2006.'                                                                                                                             union
select 2005, 1286827, '1D' , 'Prop. 1D - Education Facilities. Kindergarten - Univeristy Public Facilities Bond'                                                                                                                   union
select 2005, 1286827, '1D' , 'Prop. 1D - Kindergarten-University Public Education Facilities Bond Act of 2006'                                                                                                                     union
select 2005, 1286827, '1D' , 'Proposition 1D. Education Facilities. Kindergarten-University Public Facilites Bond'                                                                                                                 union
select 2005, 1286828, '1E' , 'Disaster Preparedness and Flood Prevention Bond Act of 2006.'                                                                                                                                        union
select 2005, 1286828, '1E' , 'Prop. 1E - Disaster Preparedness and Flood Prevention Act of 2006'                                                                                                                                   union
select 2005, 1286828, '1E' , 'Proposition 1E. Disaster Preparedness and Flood Prevention Act of 2006'                                                                                                                              union
select 2005, 1286828, '1E' , 'Proposition 1E. Disaster Preparedness and Flood Prevention Act of 2006.'                                                                                                                             union
select 2005, 1276349, '73' , 'No on Proposition 73'                                                                                                                                                                                union
select 2005, 1276349, '73' , 'Parental Notification'                                                                                                                                                                               union
select 2005, 1276349, '73' , 'Parental Notification. Initiative Constitutional Amendment'                                                                                                                                          union
select 2005, 1276349, '73' , 'Proposition 73'                                                                                                                                                                                      union
select 2005, 1276349, '73' , 'Proposition 73. Termination Minor''s Pregnancy Waiting Period & Parental Notification'                                                                                                               union
select 2005, 1276349, '73' , 'Proposition 73. Termination of Minor''s Pregnancy. Waiting Period & Parental Notification.'                                                                                                          union
select 2005, 1276349, '73' , 'Proposition 73. Termination of Minor''s Pregnancy. Waiting Period and Parentl Notification.'                                                                                                         union
select 2005, 1276349, '73' , 'Term Minor''s Preg. Wait Period and Parental Notification. Initiative Const Amend'                                                                                                                   union
select 2005, 1276349, '73' , 'Term of minor preg. Waiting period & parental noti'                                                                                                                                                  union
select 2005, 1276349, '73' , 'Term of Minor Pregnancy. Wait Period & Parent Notif. Initiative Const Amend'                                                                                                                         union
select 2005, 1276349, '73' , 'Term of Minor Pregnancy. Waiting Period & Parental Notif. Initiative Const Amend'                                                                                                                    union
select 2005, 1276349, '73' , 'Term of Minor Pregnancy. Waiting Period & Parental Notif. Initiative Const Amend.'                                                                                                                   union
select 2005, 1276349, '73' , 'Term of Minor''s Preg. Waiting Period & Parental Notif'                                                                                                                                              union
select 2005, 1276349, '73' , 'Term. of Minor''s Pregnancy, Waiting Period and Parental Notify'                                                                                                                                     union
select 2005, 1276349, '73' , 'Termination of Minor''s Pregnancy, Waiting Period and Parental Notification'                                                                                                                         union
select 2005, 1276349, '73' , 'Termination of Minor''s Pregnancy. Waiting Period and Parental Notification. Initiative'                                                                                                             union
select 2005, 1276349, '73' , 'Waiting period and Parental Notification'                                                                                                                                                            union
select 2005, 1276349, '73' , 'Waiting Period and Parental Notification Before Terminaiton of Minor''s Pregnancy'                                                                                                                   union
select 2005, 1276349, '73' , 'Waiting Period and Parental Notification/Term. of Minor''s Pregnancy'                                                                                                                                union
select 2005, 1276349, '73' , 'Yes on Proposition 73'                                                                                                                                                                               union
select 2005, 1275738, '74' , 'No on Proposition 74'                                                                                                                                                                                union
select 2005, 1275738, '74' , 'Pblc Schl Tchrs. Waiting Period for Perm Status. Initiative Statute'                                                                                                                                 union
select 2005, 1275738, '74' , 'Proposition 74'                                                                                                                                                                                      union
select 2005, 1275738, '74' , 'Proposition 74. Public School Teachers. Waiting Period for Permanent Status'                                                                                                                         union
select 2005, 1275738, '74' , 'Proposition 74. Public School Teachers. Waiting Period for Permanent Status.'                                                                                                                        union
select 2005, 1275738, '74' , 'Public School Teachers'                                                                                                                                                                              union
select 2005, 1275738, '74' , 'Public School Teachers Tenure. Initiative Statute'                                                                                                                                                   union
select 2005, 1275738, '74' , 'Public School Teachers Waiting Period for Permanent Status Dismissal'                                                                                                                                union
select 2005, 1275738, '74' , 'Public School Teachers Waiting Period for Permanent Status Dismissal Initiative Statute'                                                                                                             union
select 2005, 1275738, '74' , 'Public School Teachers Waiting Period for Permanent Status, Dismissal'                                                                                                                               union
select 2005, 1275738, '74' , 'Public School Teachers Waiting Period for Permanent Status. Dismissal'                                                                                                                               union
select 2005, 1275738, '74' , 'Public School Teachers, Waiting period for Perm Status'                                                                                                                                              union
select 2005, 1275738, '74' , 'Public School Teachers, Waiting Period for Permanent Status'                                                                                                                                         union
select 2005, 1275738, '74' , 'Public School Teachers.'                                                                                                                                                                             union
select 2005, 1275738, '74' , 'Public School Teachers.  Waiting Pd. For Perm Stat. Dismissal. Init. Statute'                                                                                                                        union
select 2005, 1275738, '74' , 'Public School Teachers.  Waiting Pd. For Perm Stat. Dismissal. Initiative Statute.'                                                                                                                  union
select 2005, 1275738, '74' , 'Public School Teachers. Wait Period For Perm Status. Dismissal. Initiative Statute'                                                                                                                  union
select 2005, 1275738, '74' , 'Public School Teachers. Waiting Pd. For Perm Status. Dismissal. Initiative Statue.'                                                                                                                  union
select 2005, 1275738, '74' , 'Public School Teachers. Waiting Period'                                                                                                                                                              union
select 2005, 1275738, '74' , 'Public School Teachers. Waiting Period for Perm Status. Initiative Statute'                                                                                                                          union
select 2005, 1275738, '74' , 'Public School Teachers. Waiting Period for Perm.'                                                                                                                                                    union
select 2005, 1275738, '74' , 'Public School Teachers. Waiting Period for Permanent Status'                                                                                                                                         union
select 2005, 1275738, '74' , 'Public School Teachers. Waiting Period for Permanent Status. Dismissal.'                                                                                                                             union
select 2005, 1275738, '74' , 'Public School Teachers.Waiting Period for Perm Status.Dismissal.Initiative Statute.'                                                                                                                 union
select 2005, 1275738, '74' , 'Yes on Propositions 74 & 76'                                                                                                                                                                         union
select 2005, 1276369, '75' , 'No On Proposition 75'                                                                                                                                                                                union
select 2005, 1276369, '75' , 'Prop 75'                                                                                                                                                                                             union
select 2005, 1276369, '75' , 'Proposition 75'                                                                                                                                                                                      union
select 2005, 1276369, '75' , 'Proposition 75. Public Employee Union Dues. Required Consent for Political Contributions'                                                                                                            union
select 2005, 1276369, '75' , 'Proposition 75. Public Employee Union Dues. Required Consent for Political Contributions.'                                                                                                           union
select 2005, 1276369, '75' , 'Proposition 75. Public Employee Union Dues. Required Employee Consent.'                                                                                                                              union
select 2005, 1276369, '75' , 'PROPOSTION 75  PUBLIC EMPLOYEE UNION DUES.  RESTRICTIONS ON POLITICAL CONTRIBUTIONS.  EMPLOYEE CONSENT REQUIREMENT.  INITIATIVE'                                                                     union
select 2005, 1276369, '75' , 'Publc Employee Union Dues'                                                                                                                                                                           union
select 2005, 1276369, '75' , 'Public Emp Union Dues. Reqd Emp Consent for Polit Contr. Initiative Statute'                                                                                                                         union
select 2005, 1276369, '75' , 'Public Emp Union Dues. Reqd Emp Consent for Political Cont. Initiative Statute'                                                                                                                      union
select 2005, 1276369, '75' , 'Public Emp Union Dues. Restrictions on Political Contribs.'                                                                                                                                          union
select 2005, 1276369, '75' , 'Public Emp Union Dues.Reqd Emp Consent for Political Cont.Initiative Statute.'                                                                                                                       union
select 2005, 1276369, '75' , 'Public Empl Union Dues. Reqd Employee Consnt for Political Ctbs. Initiative Statute'                                                                                                                 union
select 2005, 1276369, '75' , 'Public Employee Union Dues'                                                                                                                                                                          union
select 2005, 1276369, '75' , 'Public Employee Union Dues Restriction on Political Contributions EMployee Consent Requirement'                                                                                                      union
select 2005, 1276369, '75' , 'Public Employee Union Dues Restrictions on Political Contributions Employee Consent Required'                                                                                                        union
select 2005, 1276369, '75' , 'Public Employee Union Dues Restrictions on Political Contributions Employee Consent Requirement'                                                                                                     union
select 2005, 1276369, '75' , 'Public Employee Union Dues Restrictions on Political Contributions Employee Consent Requirement Initiative Statue'                                                                                   union
select 2005, 1276369, '75' , 'Public Employee Union Dues, Consent for Political Cont.'                                                                                                                                             union
select 2005, 1276369, '75' , 'Public Employee Union Dues, Req. Emp. Consent for Political Contributions'                                                                                                                           union
select 2005, 1276369, '75' , 'Public Employee Union Dues, Required Employee Consent for Political Contribution. Initiative Statue'                                                                                                 union
select 2005, 1276369, '75' , 'Public Employee Union Dues, Required Employee Consent for Political Contributions'                                                                                                                   union
select 2005, 1276369, '75' , 'Public Employee Union Dues.'                                                                                                                                                                         union
select 2005, 1276369, '75' , 'Public Employee Union Dues.  Restrict Pol. Ctb. Empl. Consent Reg. Init. Statute'                                                                                                                    union
select 2005, 1276369, '75' , 'Public Employee Union Dues.  Restrict Pol. Ctb. Employee Consent Reg. Initiative Statute.'                                                                                                           union
select 2005, 1276369, '75' , 'Public Employee Union Dues.  Restrictions on Political Contributions.'                                                                                                                               union
select 2005, 1276369, '75' , 'Public Employee Union Dues. Required Employee Consent for Political Contribution. Initiative Statue'                                                                                                 union
select 2005, 1276369, '75' , 'Public Employee Union Dues. Required Employee Consent for Political Contribution. Intiative Statue'                                                                                                  union
select 2005, 1276369, '75' , 'Public Employee Union Dues. Restrict Pol. Ctb. Employee Consent Req. Initiative Statue.'                                                                                                             union
select 2005, 1276369, '75' , 'Public Employee Union Dues. Restrictions on Political Contributions.'                                                                                                                                union
select 2005, 1276369, '75' , 'Public Employee Union Dues. Restrictions on Political Contributions. Employee Consent Requirement'                                                                                                   union
select 2005, 1276369, '75' , 'Public Employee Union Dues. Restrictions on Political Contributions. Employee Consent Requirement.'                                                                                                  union
select 2005, 1276369, '75' , 'Public Employee Union Dues. Restrictions on Political Contributions. Employee Consent Requirement. I'                                                                                                union
select 2005, 1276369, '75' , 'RESTRICTIONS ON PUBLIC EMPLOYEE UNION DUES'                                                                                                                                                          union
select 2005, 1276369, '75' , 'Union Dues-Political Contributions. Initiative Statute'                                                                                                                                              union
select 2005, 1276369, '75' , 'Yes on Proposition 75'                                                                                                                                                                               union
select 2005, 1276374, '76' , 'No on Proposition 76'                                                                                                                                                                                union
select 2005, 1276374, '76' , 'Proposition 76'                                                                                                                                                                                      union
select 2005, 1276374, '76' , 'Proposition 76. School Funding. State Spending.'                                                                                                                                                     union
select 2005, 1276374, '76' , 'Proposition 76. School Funding. State Spending. Initiative Constitutional Amendment'                                                                                                                 union
select 2005, 1276374, '76' , 'Proposition 76. School Funding. State Spending. Initiative Constitutional Amendment.'                                                                                                                union
select 2005, 1276374, '76' , 'Propostion 76. School Funding. State Spending Initiative Constitutional Amendment.'                                                                                                                  union
select 2005, 1276374, '76' , 'School Funding, State Spending'                                                                                                                                                                      union
select 2005, 1276374, '76' , 'School Funding, State Spending, Initiative Constitutional Amendment'                                                                                                                                 union
select 2005, 1276374, '76' , 'School Funding, State Spending. Initiative Constitutional Amendment'                                                                                                                                 union
select 2005, 1276374, '76' , 'School Funding.  State Spending'                                                                                                                                                                     union
select 2005, 1276374, '76' , 'School Funding.  State Spending.  Initiative Constitutional Amendment'                                                                                                                               union
select 2005, 1276374, '76' , 'School Funding. State Spending Limits. Initiative Constitutional Amendment'                                                                                                                          union
select 2005, 1276374, '76' , 'School Funding. State Spending. Initiative Constitutional Amendment'                                                                                                                                 union
select 2005, 1276374, '76' , 'School Funding.State Spending.Initiative Constitutional Amendment.'                                                                                                                                  union
select 2005, 1276374, '76' , 'State Spending & School Funding Limits'                                                                                                                                                              union
select 2005, 1276374, '76' , 'State Spending and School Funding Limits'                                                                                                                                                            union
select 2005, 1276374, '76' , 'State Spending and School Funding Limits Initiative Constitutional Amendament'                                                                                                                       union
select 2005, 1276374, '76' , 'State Spending and School Funding Limits Initiative Constitutional Amendment'                                                                                                                        union
select 2005, 1276374, '76' , 'State Spending and School Funding Limits.'                                                                                                                                                           union
select 2005, 1276374, '76' , 'State Spending and School Funding Limits. Initiative Constitutional Amendment'                                                                                                                       union
select 2005, 1276374, '76' , 'State Spending and School Funding Limits. Initiative Constitutional Amendment.'                                                                                                                      union
select 2005, 1276374, '76' , 'State Spending Limits. Initiative Consitutional Amendment'                                                                                                                                           union
select 2005, 1276374, '76' , 'Yes on Propositions 74 & 76'                                                                                                                                                                         union
select 2005, 1276356, '77' , 'No on 77, A Coalition of Working People, Entrepeneurs, Educators'                                                                                                                                    union
select 2005, 1276356, '77' , 'No on Proposition 77'                                                                                                                                                                                union
select 2005, 1276356, '77' , 'Prop 77'                                                                                                                                                                                             union
select 2005, 1276356, '77' , 'Proposition 77'                                                                                                                                                                                      union
select 2005, 1276356, '77' , 'Proposition 77 - Reapportionment. Initiative Constitutional Amendment'                                                                                                                               union
select 2005, 1276356, '77' , 'Proposition 77. Reapportionment.'                                                                                                                                                                    union
select 2005, 1276356, '77' , 'Proposition 77. Reapportionment. Initiative Constitutional Amendment'                                                                                                                                union
select 2005, 1276356, '77' , 'Proposition 77. Reapportionment. Initiative Constitutional Amendment.'                                                                                                                               union
select 2005, 1276356, '77' , 'Reapportionment'                                                                                                                                                                                     union
select 2005, 1276356, '77' , 'Reapportionment. Initiative Constitutional Amendment'                                                                                                                                                union
select 2005, 1276356, '77' , 'Reapportionment. Initiative Constitutional Amendment.'                                                                                                                                               union
select 2005, 1276356, '77' , 'Redistricting'                                                                                                                                                                                       union
select 2005, 1276356, '77' , 'Redistricting Initiative'                                                                                                                                                                            union
select 2005, 1276356, '77' , 'Redistricting Initiative Constitutional Amendme'                                                                                                                                                     union
select 2005, 1276356, '77' , 'Redistricting Initiative Constitutional Amendment'                                                                                                                                                   union
select 2005, 1276356, '77' , 'Redistricting Initiative Constitutional Amendment.'                                                                                                                                                  union
select 2005, 1276356, '77' , 'Redistricting Intitiative'                                                                                                                                                                           union
select 2005, 1276356, '77' , 'Redistricting. Initiative Consitutional Amendment'                                                                                                                                                   union
select 2005, 1276356, '77' , 'Redistricting. Initiative Constitutional Amendment'                                                                                                                                                  union
select 2005, 1276356, '77' , 'Redistricting. Initiative Constitutional Amendment.'                                                                                                                                                 union
select 2005, 1276356, '77' , 'Yes on Proposition 77'                                                                                                                                                                               union
select 2005, 1275966, '78' , 'Discount on Prescription Drugs Initative Statute'                                                                                                                                                    union
select 2005, 1275966, '78' , 'Discounts on Prescription Drugs'                                                                                                                                                                     union
select 2005, 1275966, '78' , 'Discounts on Prescription Drugs Initiative Statute'                                                                                                                                                  union
select 2005, 1275966, '78' , 'Discounts on Prescription Drugs.'                                                                                                                                                                    union
select 2005, 1275966, '78' , 'Discounts on Prescription Drugs.  Initiative Statute.'                                                                                                                                               union
select 2005, 1275966, '78' , 'DISCOUNTS ON PRESCRIPTION DRUGS. INITIATIVE STATUTE'                                                                                                                                                 union
select 2005, 1275966, '78' , 'DISCOUNTS ON PRESCRIPTION DRUGS. INITIATIVE STATUTE.'                                                                                                                                                union
select 2005, 1275966, '78' , 'No on Proposition 78'                                                                                                                                                                                union
select 2005, 1275966, '78' , 'Perscrition drug discounts'                                                                                                                                                                          union
select 2005, 1275966, '78' , 'PRESCRIPTION DRUG DISCOUNTS.'                                                                                                                                                                        union
select 2005, 1275966, '78' , 'Prescription Drugs, Discounts'                                                                                                                                                                       union
select 2005, 1275966, '78' , 'Prescription Drugs. Discounts. Initiative Statue'                                                                                                                                                    union
select 2005, 1275966, '78' , 'Prescription Drugs. Discounts. Initiative Statute'                                                                                                                                                   union
select 2005, 1275966, '78' , 'Prescription Drugs. Discounts. Initiative Statute.'                                                                                                                                                  union
select 2005, 1275966, '78' , 'Proposition 78'                                                                                                                                                                                      union
select 2005, 1275966, '78' , 'Proposition 78. Prescription Drugs. Discounts.'                                                                                                                                                      union
select 2005, 1275966, '78' , 'Proposition 78. Prescription Drugs. Discounts. Initiative Status.'                                                                                                                                   union
select 2005, 1275966, '78' , 'Proposition 78. Prescription Drugs. Discountst.'                                                                                                                                                     union
select 2005, 1276277, '79' , 'Prescription Drug Discounts.'                                                                                                                                                                        union
select 2005, 1276277, '79' , 'Prescription Drug Discounts.  State Negotiated Rebates.  Initiative Statute.'                                                                                                                        union
select 2005, 1276277, '79' , 'Prescription Drug Discounts. State - Negotiated Rebates. Initiative Statute'                                                                                                                         union
select 2005, 1276277, '79' , 'Prescription Drug Discounts. State-Negotiated Rebates'                                                                                                                                               union
select 2005, 1276277, '79' , 'Prescription Drug Discounts. State-Negotiated Rebates.'                                                                                                                                              union
select 2005, 1276277, '79' , 'PRESCRIPTION DRUG DISCOUNTS. STATE-NEGOTIATED REBATES. INITIATIVE'                                                                                                                                   union
select 2005, 1276277, '79' , 'PRESCRIPTION DRUG DISCOUNTS. STATE-NEGOTIATED REBATES. INITIATIVE STATUTE'                                                                                                                           union
select 2005, 1276277, '79' , 'Prop 79 - Prescription Drugs Discounts. State Negotiated Rebates. Initiative Statute'                                                                                                                union
select 2005, 1276277, '79' , 'Proposition 79'                                                                                                                                                                                      union
select 2005, 1276277, '79' , 'Proposition 79. Prescription Drugs Discounts. State Negotiated Rebates. Initiative'                                                                                                                  union
select 2005, 1275935, '80' , 'Electric Service Providers. Regulation.'                                                                                                                                                             union
select 2005, 1275935, '80' , 'Electric Service Providers. Regulation. Initiative Statute'                                                                                                                                          union
select 2005, 1275935, '80' , 'Proposition 80'                                                                                                                                                                                      union
select 2005, 1275935, '80' , 'Proposition 80. Electric Service Providers. Regulation'                                                                                                                                              union
select 2005, 1275935, '80' , 'Proposition 80. Electric Service Providers. Regulation. Initiative Statute.'                                                                                                                         union
select 2005, 1275935, '80' , 'Propostion 80. Electric Service Providers. Regulation.'                                                                                                                                              union
select 2005, 1275935, '80' , 'Yes on Proposition 80'                                                                                                                                                                               union
select 2005, 1276095, '81' , 'California Reading & Library Bond'                                                                                                                                                                   union
select 2005, 1276095, '81' , 'California reading and Library Bond'                                                                                                                                                                 union
select 2005, 1276095, '81' , 'Prop 81 Reading&Literacy Improvement & Public Library Construction & Renovation Bond Act'                                                                                                            union
select 2005, 1276095, '81' , 'Prop 81, Literacy, Learning & Libraries'                                                                                                                                                             union
select 2005, 1276095, '81' , 'Prop. 81 - CA Reading and Literacy Improvement and Public Library Construction'                                                                                                                      union
select 2005, 1276095, '81' , 'Prop. 81-CA Reading and Literacy Improvement & Public Library Construction & Renovation'                                                                                                             union
select 2005, 1276095, '81' , 'Proposition 81'                                                                                                                                                                                      union
select 2005, 1276095, '81' , 'Reading and Literacy Improvement & Public Library Construction'                                                                                                                                      union
select 2005, 1282459, '82' , 'Preschool Education'                                                                                                                                                                                 union
select 2005, 1282459, '82' , 'Prop 82 Preschool Education'                                                                                                                                                                         union
select 2005, 1282459, '82' , 'Prop 82, Invest in our Kids Strengthen our Schools'                                                                                                                                                  union
select 2005, 1282459, '82' , 'Prop. 82 - Public PreSchool Education. Tax Increase on Incomes'                                                                                                                                      union
select 2005, 1282459, '82' , 'Proposition 82'                                                                                                                                                                                      union
select 2005, 1282459, '82' , 'Proposition 82 - Public Preschool Education'                                                                                                                                                         union
select 2005, 1282459, '82' , 'Proposition 82 - Public Preschool Education. Tax Increase.'                                                                                                                                          union
select 2005, 1282459, '82' , 'Proposition 82. Preschool Education Tax.'                                                                                                                                                            union
select 2005, 1282459, '82' , 'Proposition 82. Public Preschool Education. Tax Increase.'                                                                                                                                           union
select 2005, 1282459, '82' , 'Proposition 82. Public Preschool Education. Tax Increase. Initiative Consitutional Amend'                                                                                                            union
select 2005, 1282459, '82' , 'Yes on 82, Preschool for All'                                                                                                                                                                        union
select 2005, 1282459, '82' , ''                                                                                                                                                                                                    union
select 2005, 1285554, '83' , 'Sex Offenders'                                                                                                                                                                                       union
select 2005, 1285554, '83' , 'Yes on 83 - Jessica''s Law'                                                                                                                                                                          union
select 2005, 1283864, '84' , 'Proposition 84'                                                                                                                                                                                      union
select 2005, 1283864, '84' , 'WATER QUALITY, SAFETY AND SUPPLY. FLOOD CONTROL. NATURAL RESOURCE PROTECTION.'                                                                                                                       union
select 2005, 1283864, '84' , 'Water Quality, Safety and Supply. Flood Control. Natural Resource Protection. Park Improvements. Bonds. Initiative Statute.'                                                                         union
select 2005, 1283864, '84' , 'Water Quality. Safety and Supply. Flood Control Bond.'                                                                                                                                               union
select 2005, 1283871, '85' , 'Proposition 85 - Waiting Period & Parental Notification'                                                                                                                                             union
select 2005, 1283871, '85' , 'Proposition 85 - Waiting Period & Parental Notification Before Term of Minor''s Pregnancy'                                                                                                           union
select 2005, 1283871, '85' , 'Wait Period and Parent Notification of Minor Pregnancy. Init Const Amend.'                                                                                                                           union
select 2005, 1283871, '85' , 'Waiting Period & Parent Notification before Term of Minor Pregnancy. Init Const Amend.'                                                                                                              union
select 2005, 1283871, '85' , 'Waiting Period and Parental Notification Before Term of Minor Preg.Init Const Amend.'                                                                                                                union
select 2005, 1283871, '85' , 'Waiting Period and Parental Notification Before Termination of Minor''s Pregnancy.'                                                                                                                  union
select 2005, 1283871, '85' , 'Yes on 85 - Waiting Period & Parental Notification'                                                                                                                                                  union
select 2005, 1285369, '86' , 'Proposition 86'                                                                                                                                                                                      union
select 2005, 1285369, '86' , 'Proposition 86 - Tax on Cigarettes'                                                                                                                                                                  union
select 2005, 1285369, '86' , 'Proposition 86. Tax on Cigarettes.'                                                                                                                                                                  union
select 2005, 1285369, '86' , 'Proposition 86. Tax on Cigarettes. Initiative Constitutional Amendment and Statute.'                                                                                                                 union
select 2005, 1285369, '86' , 'Tax on Cigarettes. Initiative Constitutional Amendment and Statute.'                                                                                                                                 union
select 2005, 1285369, '86' , 'TAX ON CIGARETTES. INTIATIVE CONSTITUTIONAL AMENDMENT & STATUTE. SA2005RF0139'                                                                                                                       union
select 2005, 1285369, '86' , 'Tobacco Tax'                                                                                                                                                                                         union
select 2005, 1284170, '87' , 'Alternate Energy Res., Production Incentives Tax.'                                                                                                                                                   union
select 2005, 1284170, '87' , 'Alternate Energy. Research, Production Incentives. Tax on Ca. Oil Producers'                                                                                                                         union
select 2005, 1284170, '87' , 'Alternative Energy'                                                                                                                                                                                  union
select 2005, 1284170, '87' , 'ALTERNATIVE ENERGY, RESEARCH, PRODUCTION INCENTIVES'                                                                                                                                                 union
select 2005, 1284170, '87' , 'Alternative Energy. Research, Production Incentives.'                                                                                                                                                union
select 2005, 1284170, '87' , 'Alternative Energy. Research, Production, Incentives. Tax on California Oil Producers. Initiative Constitutional Amendment and Statute.'                                                             union
select 2005, 1284170, '87' , 'Prop 87 - Alternative Energy. Research Statewide, Production, Incentives. Tax on CA Oil'                                                                                                             union
select 2005, 1284170, '87' , 'Prop. 87 - Alternative Energy. Research, Production, Incentives. Tax on CA Oil.'                                                                                                                     union
select 2005, 1284170, '87' , 'Proposition 87 - Alternative Energy. Research, Production, Incentives. Tax on CA Oil.'                                                                                                               union
select 2005, 1284115, '88' , 'Education Funding'                                                                                                                                                                                   union
select 2005, 1284115, '88' , 'Education Funding. Real Property Parcel Tax.'                                                                                                                                                        union
select 2005, 1284115, '88' , 'Education Funding. Real Property Parcel Tax. Initiative Constitutional Amendment and Statute.'                                                                                                       union
select 2005, 1284115, '88' , 'Prop. 88 - Education Funding. Real Property Parcel Tax.'                                                                                                                                             union
select 2005, 1284115, '88' , 'Proposition 88'                                                                                                                                                                                      union
select 2005, 1284115, '88' , 'Proposition 88 - Education Funding. Real Property Parcel Tax'                                                                                                                                        union
select 2005, 1284115, '88' , 'Proposition 88 - Education Funding. Real Property Parcel Tax.'                                                                                                                                       union
select 2005, 1285981, '89' , 'POLITICAL CAMPAIGNS'                                                                                                                                                                                 union
select 2005, 1285981, '89' , 'POLITICAL CAMPAIGNS, PUBLIC FINANCING, CORPORATE TAX'                                                                                                                                                union
select 2005, 1285981, '89' , 'Political Campaigns, Public Financing, Corporate Tax Increase.'                                                                                                                                      union
select 2005, 1285981, '89' , 'Political Campaigns.'                                                                                                                                                                                union
select 2005, 1285981, '89' , 'Political Campaigns. Public Financing. Corporate Tax Increase. Campaign Contribution and Expenditure Limits. Initiative Statute.'                                                                    union
select 2005, 1285981, '89' , 'Prop 89 - Political Campaigns, Pulic Statewide Financing, Contribution & Expenditure limit'                                                                                                          union
select 2005, 1285981, '89' , 'Prop 89-Political Campaigns. Public Financing. Corporate Tax Increase. Cont. & Exp. Limits'                                                                                                          union
select 2005, 1285981, '89' , 'Proposition 89. Political Campaigns, Public Financing, Contribution & Expenditure Limits'                                                                                                            union
select 2005, 1284381, '90' , 'GOVERNMENT ACQUISITION,'                                                                                                                                                                             union
select 2005, 1284381, '90' , 'GOVERNMENT ACQUISITION, REGULATION OF PRIVATE PROPERTY.'                                                                                                                                             union
select 2005, 1284381, '90' , 'Government Acquisition, Regulation of Private Property. Init Const Amend.'                                                                                                                           union
select 2005, 1284381, '90' , 'Government Acquisition, Regulation of Private Property. Initiative Constitutional Amendment'                                                                                                         union
select 2005, 1284381, '90' , 'Government Aquisitions, Regulation of Private Property'                                                                                                                                              union
select 2005, 1284381, '90' , 'Govt Acquisition, Regulation of Private Property. Init Const Amend.'                                                                                                                                 union
select 2005, 1284381, '90' , 'Govt Acquisition. Regulation of Private Property. Init Const Amend.'                                                                                                                                 union
select 2005, 1284381, '90' , 'Govt Acquisition. Regulation of Private Property. Init. Const. Amend.'                                                                                                                               union
select 2005, 1284381, '90' , 'Govt. Acquisition. Regulation of Private Property.'                                                                                                                                                  union
select 2005, 1284381, '90' , 'Govt. Acquisition. Regulation of Private Property. Init. Const. Amend.'                                                                                                                              union
select 2005, 1284381, '90' , 'Proposition 90'                                                                                                                                                                                      union
select 2005, 1284381, '90' , 'Proposition 90 - Government Acquisition, Regulation of Private Property'                                                                                                                             union
select 2005, 1284381, '90' , 'Proposition 90 - Government Acquisition. Regulation of Private Property.'                                                                                                                            union
select 2005, 1284381, '90' , 'Proposition 90 - Government Acquisitions, Regulation of Private Property'                                                                                                                            union
select 2005, 1276369, ''   , 'NO ON PROP 75'                                                                                                                                                                                       union
select 2005, 1276349, ''   , 'No On Proposition 73'                                                                                                                                                                                union
select 2005, 1276369, ''   , 'No On Proposition 75'                                                                                                                                                                                union
select 2005, 1285981, ''   , 'Political Campaigns. Public Financing. Corporate Tax Increase. Cont. & Expenditure Limits'                                                                                                           union
select 2005, 1275738, ''   , 'Proposition 74'                                                                                                                                                                                      union
select 2005, 1275738, ''   , 'Proposition 74 - Public School Teachers.  Waiting Period For Permanent Status.  Dismissal Initiative Statute.'                                                                                       union
select 2005, 1276369, ''   , 'Proposition 75'                                                                                                                                                                                      union
select 2005, 1276369, ''   , 'Proposition 75 - Public Employees Union Dues.  Requiresd Employee Consent For Political Contributions.  Initiative Statute.'                                                                         union
select 2005, 1276369, ''   , 'Proposition 75. Public Employee Union Dues. Required Consent for Political Contributions'                                                                                                            union
select 2005, 1276374, ''   , 'Proposition 76'                                                                                                                                                                                      union
select 2005, 1276374, ''   , 'Proposition 76 - School Funding.  State Spending'                                                                                                                                                    union
select 2005, 1276374, ''   , 'Proposition 76 - School Funding.  State Spending.  Initiative Amendment.'                                                                                                                            union
select 2005, 1276356, ''   , 'Proposition 77'                                                                                                                                                                                      union
select 2005, 1276356, ''   , 'Proposition 77 - Reapportionment'                                                                                                                                                                    union
select 2005, 1276356, ''   , 'Proposition 77 - Reapportionment.  Initiative Constitutional Amendment.'                                                                                                                             union
select 2005, 1284381, ''   , 'Proposition 90 - Government Acquisition, Regulation of Private Property'                                                                                                                             union
select 2005, 1283435, ''   , 'Transportation Funding Initiative Constitutional Amendment and Statute'                                                                                                                              union
select 2007, 1310496, '1'  , 'Proposition 1. Safe, Reliable High-Speed Passenger Train'                                                                                                                                            union
select 2007, 1304276, '10' , 'Alternative Fuel Vehicles and Renewable Energy. Bnds. Init. Stat.'                                                                                                                                   union
select 2007, 1304276, '10' , 'Alternative Fuel Vehicles and Renewable Energy. Bonds. Proposition'                                                                                                                                  union
select 2007, 1304276, '10' , 'Alternative Fuel Vehicles and Renewable Energy. Proposition'                                                                                                                                         union
select 2007, 1304276, '10' , 'Clean Emissions Standard Bond'                                                                                                                                                                       union
select 2007, 1304276, '10' , 'Prop 10'                                                                                                                                                                                             union
select 2007, 1304276, '10' , 'Proposition 10. Alternative Fuel Vehicles and Renewable Energy. Bonds'                                                                                                                               union
select 2007, 1303165, '11' , 'No on 11'                                                                                                                                                                                            union
select 2007, 1303165, '11' , 'Prop 11'                                                                                                                                                                                             union
select 2007, 1303165, '11' , 'Redistricting Initiative'                                                                                                                                                                            union
select 2007, 1303165, '11' , 'Redistricting Initiative Constitutional Amendment.'                                                                                                                                                  union
select 2007, 1303165, '11' , 'Redistricting. Constitutional Amendment & Statute'                                                                                                                                                   union
select 2007, 1303165, '11' , 'Redistricting. Constitutional Amendment & Statute. Proposition'                                                                                                                                      union
select 2007, 1303165, '11' , 'Redistricting. Initiative Const. Amend. & Stat.'                                                                                                                                                     union
select 2007, 1308397, '12' , 'Prop 12, Yes on 12 for Veterans'                                                                                                                                                                     union
select 2007, 1308397, '12' , 'Proposition 12. Veteran''s Bond Act of 2008'                                                                                                                                                         union
select 2007, 1308397, '12' , 'Veterans'' Bond Act of 2008'                                                                                                                                                                         union
select 2007, 1308397, '12' , 'Veteran''s Bond Act of 2008. Proposition'                                                                                                                                                            union
select 2007, 1310496, '1A' , 'Prop 1A, Yes on High Speed Rail'                                                                                                                                                                     union
select 2007, 1310496, '1A' , 'Safe, Reliable High Speed Passenger Train Bond Act'                                                                                                                                                  union
select 2007, 1310496, '1A' , 'Safe, Reliable High-Speed Passenger Train Bond Act. Proposition'                                                                                                                                     union
select 2007, 1310496, '1A' , 'Safe, Reliable High-Speed Passenger Train. Proposition'                                                                                                                                              union
select 2007, 1301126, '1A' , 'Yes on Children''s Hospitals'                                                                                                                                                                        union
select 2007, 1310496, '1A' , 'Yes on Measure 1A'                                                                                                                                                                                   union
select 2007, 1301652, '2'  , 'Proposition 2'                                                                                                                                                                                       union
select 2007, 1301652, '2'  , 'Proposition 2. Standards for Confining Farm Animals'                                                                                                                                                 union
select 2007, 1301652, '2'  , 'Standards for Confining Farm Animals. Proposition'                                                                                                                                                   union
select 2007, 1301652, '2'  , 'Yes On Prop 2'                                                                                                                                                                                       union
select 2007, 1301126, '3'  , 'Childrens Hospital Bond Act. Grant Program. Init. Stat.'                                                                                                                                            union
select 2007, 1301126, '3'  , 'Children''s Hospital Bond Act. Grant Program. Proposition'                                                                                                                                           union
select 2007, 1301126, '3'  , 'Children''s Hospital Bond Act. Proposition'                                                                                                                                                          union
select 2007, 1301126, '3'  , 'Prop 3'                                                                                                                                                                                              union
select 2007, 1301126, '3'  , 'Prop 3, Yes on 3 for Kids'                                                                                                                                                                           union
select 2007, 1301126, '3'  , 'Proposition 3.Children''s Hospital Bond Act. Grant Program'                                                                                                                                          union
select 2007, 1302575, '4'  , 'No on Prop 4'                                                                                                                                                                                        union
select 2007, 1302575, '4'  , 'Parental Notification and Waiting Period Before Termination of a Minor''s Pregnancy. Proposition'                                                                                                    union
select 2007, 1302575, '4'  , 'Parental Notification Initiative'                                                                                                                                                                    union
select 2007, 1302575, '4'  , 'Prop 4'                                                                                                                                                                                              union
select 2007, 1302575, '4'  , 'Proposition 4.Waiting Period and Parental Notification Before Termination of Minor''s Pregnancy'                                                                                                     union
select 2007, 1302575, '4'  , 'Sarah''s Law'                                                                                                                                                                                        union
select 2007, 1302575, '4'  , 'Waiting Period and Parental Notification Before Term. of Minor Preg. Init. Const. Amend.'                                                                                                            union
select 2007, 1302575, '4'  , 'Waiting Period and Parental Notification Before Termination of Minor''s Pregnancy. Proposition'                                                                                                      union
select 2007, 1302575, '4'  , 'Waiting Period Parent Notif. Before Term. Minor'                                                                                                                                                     union
select 2007, 1302575, '4'  , 'Waiting Period Parent Notif. Before Term. Minor Pregnancy'                                                                                                                                           union
select 2007, 1303172, '5'  , 'Nonviolent Drug Offenses, Sentencing, Parole and Rehabilitation. Proposition'                                                                                                                        union
select 2007, 1303172, '5'  , 'Nonviolent Drug Offenses. Sentencing, Parole and Rehabilitation. Proposition'                                                                                                                        union
select 2007, 1303172, '5'  , 'Nonviolent Offenders: Sentencing Parole & Rehabilitation'                                                                                                                                            union
select 2007, 1303172, '5'  , 'Nonviolent Offenders; Sentencing, Parole & Rehabilitation'                                                                                                                                           union
select 2007, 1303172, '5'  , 'Proposition 5'                                                                                                                                                                                       union
select 2007, 1303172, '5'  , 'Proposition 5. Nonviolent Drug Offenses, Sentencing, Parole and Rehabilitation'                                                                                                                      union
select 2007, 1303172, '5'  , 'Yes on 5'                                                                                                                                                                                            union
select 2007, 1304171, '6'  , 'Californians Proposition 6'                                                                                                                                                                          union
select 2007, 1304171, '6'  , 'No on Proposition 6'                                                                                                                                                                                 union
select 2007, 1304171, '6'  , 'Police and Law Enforcement Funding. Crim. Pen. & Laws. Init. Stat.'                                                                                                                                  union
select 2007, 1304171, '6'  , 'Police and Law Enforcement Funding. Criminal Penalties and Laws. Proposition'                                                                                                                        union
select 2007, 1304171, '6'  , 'Prop 6'                                                                                                                                                                                              union
select 2007, 1304171, '6'  , 'PROPOSITION'                                                                                                                                                                                         union
select 2007, 1304171, '6'  , 'Proposition 6'                                                                                                                                                                                       union
select 2007, 1304171, '6'  , 'Proposition 6. Police and Law Enforcement Funding. Criminal Penalties and Laws'                                                                                                                      union
select 2007, 1303161, '7'  , 'Prop 7'                                                                                                                                                                                              union
select 2007, 1303161, '7'  , 'Proposition 7'                                                                                                                                                                                       union
select 2007, 1303161, '7'  , 'Proposition 7.  Renewable Energy Generation'                                                                                                                                                         union
select 2007, 1303161, '7'  , 'Renewable Energy Generation'                                                                                                                                                                         union
select 2007, 1303161, '7'  , 'Renewable Energy Generation. Initiative Statute.'                                                                                                                                                    union
select 2007, 1303161, '7'  , 'Renewable Energy Generation. Proposition'                                                                                                                                                            union
select 2007, 1303161, '7'  , 'Renewable Energy. Proposition'                                                                                                                                                                       union
select 2007, 1302602, '8'  , 'California Marriage Protection Act'                                                                                                                                                                  union
select 2007, 1302602, '8'  , 'Eliminates Marriage for Same Sex Couples.  Initiative. Constitutional Amendment.'                                                                                                                    union
select 2007, 1302602, '8'  , 'Eliminates Right of Same Sex Couple to Marry. Proposition'                                                                                                                                           union
select 2007, 1302602, '8'  , 'Eliminates Right of Same Sex Couples to Marry'                                                                                                                                                       union
select 2007, 1302602, '8'  , 'Eliminates Right of Same-Sex Couples to Marry'                                                                                                                                                       union
select 2007, 1302602, '8'  , 'Limit on Marriage. Constitutional Amendment'                                                                                                                                                         union
select 2007, 1302602, '8'  , 'Limitation of Marriage'                                                                                                                                                                              union
select 2007, 1302602, '8'  , 'Limitation on Marriage'                                                                                                                                                                              union
select 2007, 1302602, '8'  , 'Limitation on Marriage, State Constitutional Initiative'                                                                                                                                             union
select 2007, 1302602, '8'  , 'Limits on Marriage'                                                                                                                                                                                  union
select 2007, 1302602, '8'  , 'No on 8 - Equality California'                                                                                                                                                                       union
select 2007, 1302602, '8'  , 'Vote No on Prop 8, Equality for all'                                                                                                                                                                 union
select 2007, 1302602, '8'  , 'Yes on Prop 8 - Protect Marriage.com'                                                                                                                                                                union
select 2007, 1283871, '85' , 'Proposition 85'                                                                                                                                                                                      union
select 2007, 1304168, '9'  , 'Criminal Justice System, Victims'' Rights. Proposition'                                                                                                                                              union
select 2007, 1304168, '9'  , 'CRIMINAL JUSTICE SYSTEM. VICTIMS'' RIGHTS. PAROLE. CONSTITUTIONAL AMENDMENT AND STATUTE'                                                                                                             union
select 2007, 1304168, '9'  , 'Criminal Justice System. Victims Rights. Parole. Init. Const. Amend. & Stat.'                                                                                                                       union
select 2007, 1304168, '9'  , 'Criminal Justice System. Victims'' Rights. Parole. Proposition'                                                                                                                                      union
select 2007, 1304168, '9'  , 'No on 9'                                                                                                                                                                                             union
select 2007, 1304168, '9'  , 'Prop 9'                                                                                                                                                                                              union
select 2007, 1304168, '9'  , 'Proposition 9'                                                                                                                                                                                       union
select 2007, 1304168, '9'  , 'Proposition 9. Criminal Justice System. Victims'' Rights. Parole'                                                                                                                                    union
select 2007, 1297596, '92' , 'CA Comm. College Initiative'                                                                                                                                                                         union
select 2007, 1297596, '92' , 'Community College Initiative'                                                                                                                                                                        union
select 2007, 1297596, '92' , 'Community Colleges. Funding. Governance. Fees.'                                                                                                                                                      union
select 2007, 1299177, '93' , 'LIMIT ON LEGISLATURES'' TERMS IN OFFICE'                                                                                                                                                             union
select 2007, 1299177, '93' , 'Limits on Legislators'' Terms in Office.'                                                                                                                                                            union
select 2007, 1299177, '93' , 'Proposition 93'                                                                                                                                                                                      union
select 2007, 1299177, '93' , 'Proposition 93, Limits on Legislators'' Terms in Office Initiative Constitutional Amendment'                                                                                                         union
select 2007, 1299177, '93' , 'Proposition 93. Limits on Legislators'' Terms in Office'                                                                                                                                             union
select 2007, 1299177, '93' , 'Proposition 93. Limits on Legislators'' Terms in Office.  Initiative Constitutional Amendment.'                                                                                                      union
select 2007, 1299177, '93' , 'Term Limits and Legislative Reform Act'                                                                                                                                                              union
select 2007, 1300220, '94' , 'Referendum on Amendment to Indian Gaming Compact.'                                                                                                                                                   union
select 2007, 1300220, '94' , 'Referendums On Amendment to Indian Gaming Pacts'                                                                                                                                                     union
select 2007, 1300218, '95' , 'Referendum on Amendment to Indian Gaming Compact.'                                                                                                                                                   union
select 2007, 1300219, '96' , 'Referendum on Amendment to Indian Gaming Compact.'                                                                                                                                                   union
select 2007, 1300221, '97' , 'Referendum on Amendment to Indian Gaming Compact.'                                                                                                                                                   union
select 2007, 1299308, '98' , 'CA Property Owners and Farmland Protection Act'                                                                                                                                                      union
select 2007, 1299308, '98' , 'Eminent Domain.  Limits on Gov''t Authority. Initiative Constitutional Amend.'                                                                                                                       union
select 2007, 1299308, '98' , 'Eminent Domain. Limits on Government Authority.'                                                                                                                                                     union
select 2007, 1299308, '98' , 'Eminent Domain. Limits on Gov''t Authority. Initiative Constitutional Amendment'                                                                                                                     union
select 2007, 1299308, '98' , 'Eminent Domain. Limits on Gov''t Authority. Initiative Constitutional Amendment.'                                                                                                                    union
select 2007, 1299308, '98' , 'Government Acquisition, Regulation of Private Property'                                                                                                                                              union
select 2007, 1299308, '98' , 'Government Acquisition, Regulation Of Private Property - Yes On Proposition 98'                                                                                                                      union
select 2007, 1299308, '98' , 'Government Acquisition, Regulation of Private Property.'                                                                                                                                             union
select 2007, 1299308, '98' , 'Government Acquisition, Regulation of Private Property. Constitutional Amendment, Proposition'                                                                                                       union
select 2007, 1299308, '98' , 'Govt. Acquisition, Regulation of Private Property. Constitutional Amendment.'                                                                                                                        union
select 2007, 1299308, '98' , 'No on Proposition 98'                                                                                                                                                                                union
select 2007, 1299308, '98' , 'Proposition 98'                                                                                                                                                                                      union
select 2007, 1299473, '99' , 'Eminent Domain.  Acq. by Gov''t of Owner-occupied Res.  Initiative Constitutional Amend.'                                                                                                            union
select 2007, 1299473, '99' , 'Eminent Domain. Acquisition of Owner-Occupied Residence'                                                                                                                                             union
select 2007, 1299473, '99' , 'Eminent Domain. Acquisition of Owner-Occupied Residence.'                                                                                                                                            union
select 2007, 1299473, '99' , 'Eminent Domain. Limits on Gov''t Acquisition of Owner-Occupied Residence.'                                                                                                                           union
select 2007, 1299473, '99' , 'Proposition 99'                                                                                                                                                                                      union
select 2007, 1299473, '99' , 'Yes On Proposition 99'                                                                                                                                                                               union
select 2007, 1299308, 'AG' , 'California Property Owners and Farmland Protection Act'                                                                                                                                              union
select 2007, 1276349, ''   , 'Parental Notification Initiative'                                                                                                                                                                    union
select 2007, 1299308, ''   , 'PROPOSITION 98'                                                                                                                                                                                      union
select 2007, 1300220, ''   , 'Referendums On Amendment to Indian Gaming Pacts'                                                                                                                                                     union
select 2009, 1316063, '13' , 'Seismic Retrofitting Amendment'                                                                                                                                                                      union
select 2009, 1316969, '14' , 'Elections: Open Primaries'                                                                                                                                                                           union
select 2009, 1316969, '14' , 'No on Prop 14'                                                                                                                                                                                       union
select 2009, 1316969, '14' , 'Protect Voter Choice'                                                                                                                                                                                union
select 2009, 1316967, '15' , 'California Fair Elections Act of 2008'                                                                                                                                                               union
select 2009, 1316967, '15' , 'Prop 15 - Political Reform Act of 1974: California Fair Elections Act of 2008'                                                                                                                       union
select 2009, 1321695, '16' , '2/3 Requirement for Local Public Elec. Providers'                                                                                                                                                    union
select 2009, 1321695, '16' , 'Proposition 16, the New Two-Thirds Requirement for Local Public Electricity Providers Act'                                                                                                           union
select 2009, 1322446, '17' , 'Auto Insurance Based on Driver''s Coverage History'                                                                                                                                                  union
select 2009, 1322446, '17' , 'Prop 17 - Allows Auto Insurance Companies to Base Their Prices in Part on a Driver''s History of Insurance Coverage'                                                                                 union
select 2009, 1321713, '19' , 'Changes CA Law to Legalize Marijuana & Allow Tax'                                                                                                                                                    union
select 2009, 1321713, '19' , 'Changes California Law To Legalize Marijuana and Allow It To Be Regulated and Taxed'                                                                                                                 union
select 2009, 1321713, '19' , 'Legalizes Marijuana Under California Law but not Federal Law'                                                                                                                                        union
select 2009, 1321713, '19' , 'Legalizes marijuana under California, not federal, law.'                                                                                                                                             union
select 2009, 1321713, '19' , 'Legalizes marijuana under state not federal law.'                                                                                                                                                    union
select 2009, 1321713, '19' , 'Permits Local Governments to Regulate and Tax Commercial Production, Distribution, and Sale of Marijuana. Proposition'                                                                               union
select 2009, 1321713, '19' , 'Prop. 19 (I) - Changes California Law to Legalize Marijuana & Allow it to be Regulated and Taxed'                                                                                                    union
select 2009, 1316044, '1A' , 'No on 1A'                                                                                                                                                                                            union
select 2009, 1316044, '1A' , 'Prop 1A - State Budget.  Changes California Budget Process. Limits Spending.'                                                                                                                        union
select 2009, 1316044, '1A' , 'Rainy Day Budget Stabilization Fund, Education Funding, Lottery Modernization Act, Children''s Services Funding, Mental Health Funding, Elected Officials'' Salaries'                                union
select 2009, 1316044, '1A' , 'SAFE, RELIABLE HIGH-SPEED TRAIN BOND ACT'                                                                                                                                                            union
select 2009, 1316044, '1A' , 'State Budget Changes CA Budget Process'                                                                                                                                                              union
select 2009, 1316044, '1A' , 'State Budget.  Changes California Budget Process, Limits Spending. Increases ''Rainy Day'' Budget Stabilization Fund. Prop'                                                                          union
select 2009, 1316044, '1A' , 'State Budget. Changes to Budget  Process-Prop'                                                                                                                                                       union
select 2009, 1316044, '1A' , 'State Budget. Changes to Budget Process'                                                                                                                                                             union
select 2009, 1316047, '1B' , 'Education Funding Payment Plan'                                                                                                                                                                      union
select 2009, 1316047, '1B' , 'Education Funding.  Payment Plan. Prop'                                                                                                                                                              union
select 2009, 1316047, '1B' , 'No on 1B'                                                                                                                                                                                            union
select 2009, 1316047, '1B' , 'Prop 1B - Education Funding.  Payment Plan.'                                                                                                                                                         union
select 2009, 1316047, '1B' , 'Proposition 1B'                                                                                                                                                                                      union
select 2009, 1316047, '1B' , 'Propositions 1B'                                                                                                                                                                                     union
select 2009, 1316048, '1C' , 'Lottery Modernization Act'                                                                                                                                                                           union
select 2009, 1316048, '1C' , 'Lottery Modernization Act.  Prop'                                                                                                                                                                    union
select 2009, 1316048, '1C' , 'Lottery Modernization Act. Proposition 1C'                                                                                                                                                           union
select 2009, 1316048, '1C' , 'No on 1C'                                                                                                                                                                                            union
select 2009, 1316048, '1C' , 'Prop 1C - Lottery Modernization Act.'                                                                                                                                                                union
select 2009, 1316048, '1C' , 'Proposition 1C'                                                                                                                                                                                      union
select 2009, 1316048, '1C' , 'Proposition 1C - Lottery Modernization Act'                                                                                                                                                          union
select 2009, 1316060, '1D' , 'No on 1D'                                                                                                                                                                                            union
select 2009, 1316060, '1D' , 'Prop 1D - Protects Children''s Services Funding.  Helps Balance State Budget.'                                                                                                                       union
select 2009, 1316060, '1D' , 'Protects Children''s Services Funding.  Helps Balance State Budget.  Prop'                                                                                                                           union
select 2009, 1316061, '1E' , 'Mental Health Services Funding. Temporary Reallocation.  Prop'                                                                                                                                       union
select 2009, 1316061, '1E' , 'No on 1E'                                                                                                                                                                                            union
select 2009, 1316061, '1E' , 'Prop 1E - Mental Health Services Funding. Temporary Reallocation.'                                                                                                                                   union
select 2009, 1316062, '1F' , 'Elected Officials'' Salaries'                                                                                                                                                                        union
select 2009, 1316062, '1F' , 'Elected Officials'' Salaries.  Prevents Pay Increases During Budget Deficit Years.  Prop'                                                                                                            union
select 2009, 1316062, '1F' , 'No on 1F'                                                                                                                                                                                            union
select 2009, 1316062, '1F' , 'Prop 1F - Elected Officials'' Salaries.  Prevents Pay Increases During Budget Deficit Years.'                                                                                                        union
select 2009, 1322428, '20' , 'California Congressional Redistricting Initiative'                                                                                                                                                   union
select 2009, 1322428, '20' , 'Prop. 20 (I) - Redistricting of Congressional Districts'                                                                                                                                             union
select 2009, 1322428, '20' , 'Proposition 20'                                                                                                                                                                                      union
select 2009, 1322428, '20' , 'Proposition 20 (IE)'                                                                                                                                                                                 union
select 2009, 1322428, '20' , 'Redistricting of Congressional Districts'                                                                                                                                                            union
select 2009, 1323361, '21' , 'Establish Annual Surcharge to Fund State Parks'                                                                                                                                                      union
select 2009, 1323361, '21' , 'Establishes $18 Annual Vehicle License Surcharge to Help Fund State Parks and Wildlife Programs. Proposition'                                                                                        union
select 2009, 1323361, '21' , 'Prop. 21 (I) - Establishes $18 Annual Vehicle License Surcharge to Help Fund State Parks & Wildlife Programs'                                                                                        union
select 2009, 1323361, '21' , 'Proposition 21'                                                                                                                                                                                      union
select 2009, 1323361, '21' , 'Yes on Proposition 21'                                                                                                                                                                               union
select 2009, 1323281, '22' , 'Prohibits State from Taking Transp./Loc. Gov Funds'                                                                                                                                                  union
select 2009, 1323281, '22' , 'Prohibits the State from Borrowing or Taking Funds'                                                                                                                                                  union
select 2009, 1323281, '22' , 'Proposition 22'                                                                                                                                                                                      union
select 2009, 1323281, '22' , 'Proposition 22 - Prohibits the State From Borrowing Or Taking Funds Used for Transportation, Redevelopement, Or Local Government Projects and Services'                                              union
select 2009, 1324800, '23' , 'California Jobs Initiative'                                                                                                                                                                          union
select 2009, 1324800, '23' , 'No on Proposition 23'                                                                                                                                                                                union
select 2009, 1324800, '23' , 'Prop. 23 (I) - Suspends Air Pollution Control Laws Requiring Major Polluters to Report and Reduce Greenhouse Gas Emissions'                                                                          union
select 2009, 1324800, '23' , 'Proposition 23'                                                                                                                                                                                      union
select 2009, 1324800, '23' , 'Proposition 23 (IE)'                                                                                                                                                                                 union
select 2009, 1324800, '23' , 'Proposition 23, Suspend AB 32, the Global Warming Act of 2006'                                                                                                                                       union
select 2009, 1324800, '23' , 'Propostion 23 - Suspends Air Pollution Control Laws Requiring Major Polluters to Report and Reduce Greenhouse Gas Emissions Until Unemployment Drops to 5.5%'                                        union
select 2009, 1324800, '23' , 'SUSPEND AB 32'                                                                                                                                                                                       union
select 2009, 1324800, '23' , 'Suspends Air Poll. Control Laws Until Unemp. Drops'                                                                                                                                                  union
select 2009, 1324800, '23' , 'Suspends Air Pollution Control Laws Requiring Major Polluters to Report and Reduce Greenhouse Gas Emissions That Cause Global Warming Until Unemployment Drops to 5.5 Percent Or Less for Full Year' union
select 2009, 1324800, '23' , 'Suspends Implementation Air Pollution Control Law'                                                                                                                                                   union
select 2009, 1324800, '23' , 'Suspends Implementation of Air Pollution Control Law'                                                                                                                                                union
select 2009, 1323279, '24' , 'Business Tax Liability Proposition'                                                                                                                                                                  union
select 2009, 1323279, '24' , 'Prop. 24 (I) - Repeals Recent Legislation that Would Allow Businesses to Carry Back Losses'                                                                                                          union
select 2009, 1323279, '24' , 'Proposition 24'                                                                                                                                                                                      union
select 2009, 1323279, '24' , 'Proposition 24 - Repeals Recent Legislation That Would Allow Businesses to Lower Their Tax Liability'                                                                                                union
select 2009, 1323279, '24' , 'REPEAL OF CORPORATE TAX BREAKS'                                                                                                                                                                      union
select 2009, 1323279, '24' , 'Repeals Leg. To Allow Lower Tax Liab. For Business'                                                                                                                                                  union
select 2009, 1323279, '24' , 'Repeals legis. that would allow lower bus. Tax'                                                                                                                                                      union
select 2009, 1323279, '24' , 'Repeals Recent Legislation That Would Allow Businesses to Lower Their Tax Liability. Proposition'                                                                                                    union
select 2009, 1323274, '25' , 'Change Leg. Vote Req. to Pass Budget to Simp. Maj.'                                                                                                                                                  union
select 2009, 1323274, '25' , 'Change legis. vote req. to pass budget to major.'                                                                                                                                                    union
select 2009, 1323274, '25' , 'Changes Legislative Vote Requirement to Pass Budget  from 2/3''s to a Simple Majority'                                                                                                               union
select 2009, 1323274, '25' , 'Changes Legislative Vote Requirement to Pass Budget and Budget-Related Legislation From Two-Thirds to A Simple Majority. Retains Two-Thirds Vote Requirement for Taxes. Proposition'                 union
select 2009, 1323274, '25' , 'Changes Legislative Vote Requirement to Pass Budget from 2/3''s to a Simple Majority'                                                                                                                union
select 2009, 1323274, '25' , 'PASSING THE BUDGET ON TIME ACT'                                                                                                                                                                      union
select 2009, 1323274, '25' , 'Prop. 25 (I) - Changes Legislative Vote Requirement to Pass a Budget from 2/3 to a Simple Majority'                                                                                                  union
select 2009, 1323274, '25' , 'Prop. 25 (I) - Changes Legislative vote requirement to pass a budget from 2/3 to a simple majority.'                                                                                                 union
select 2009, 1323274, '25' , 'Proposition 25'                                                                                                                                                                                      union
select 2009, 1323274, '25' , 'Proposition 25 - Changes Legislative Vote Requirements to Pass Budget and Budget-Related Legislation From Two-Thirds to A Simple Majority.'                                                          union
select 2009, 1323274, '25' , 'Simple Majority Budget Proposition'                                                                                                                                                                  union
select 2009, 1323274, '25' , 'Yes On Proposition 25'                                                                                                                                                                               union
select 2009, 1323965, '26' , 'Inc. Leg. Vote to 2/3 for State Levies & Charges'                                                                                                                                                    union
select 2009, 1323965, '26' , 'Increases Legislative Vote Requirement to 2/3 for State Levies & Charges'                                                                                                                            union
select 2009, 1323965, '26' , 'No on Proposition 26'                                                                                                                                                                                union
select 2009, 1323965, '26' , 'Prop. 26 (I) - Increases Legislative Vote Requirement to 2/3 for State Levies and Charges'                                                                                                           union
select 2009, 1323965, '26' , 'Proposition 26'                                                                                                                                                                                      union
select 2009, 1323965, '26' , 'Proposition 26 - Requires That Certain State and Local Fees Be Approved By Two-Thirds Vote'                                                                                                          union
select 2009, 1323965, '26' , 'Requires Certain State and Local Fees to be Approved by 2/3 Vote'                                                                                                                                    union
select 2009, 1323965, '26' , 'Requires That Certain State and Local Fees Be Approved By Two-Thirds Vote. Proposition'                                                                                                              union
select 2009, 1323965, '26' , 'Stop Hidden Taxes'                                                                                                                                                                                   union
select 2009, 1323965, '26' , 'SUPERMAJORITY VOTE TO PASS NEW TAXES'                                                                                                                                                                union
select 2009, 1323965, '26' , 'Supermajority Vote to Pass New Taxes and Fees'                                                                                                                                                       union
select 2009, 1324469, '27' , 'Elimination of the Citizen Redistricting Commission Initiative'                                                                                                                                      union
select 2009, 1324469, '27' , 'Prop. 27 (I) - Eliminates State Commission on Redistricting'                                                                                                                                         union
select 2009, 1324469, '27' , 'Proposition 27'                                                                                                                                                                                      union
select 2009, 1324469, '27' , 'Proposition 27 (IE)'                                                                                                                                                                                 union
select 2009, 1338955, 'N/A', 'The Public Employee Paycheck Protection Act'                                                                                                                                                         union
select 2009, 1323279, 'NA' , 'Corporate Taxes (09-0020), A Proposed Statewide Ballot Measure'                                                                                                                                      union
select 2009, 1316063, ''   , 'PROPOSITION 13'                                                                                                                                                                                      union
select 2011, 1323006, '28' , 'Limits Legislators'' Terms in Office'                                                                                                                                                                union
select 2011, 1323006, '28' , 'Limits on Legislators'' Terms in Office'                                                                                                                                                             union
select 2011, 1323006, '28' , 'Limits on Legislators'' Terms in Office. Initiative Constitutional Amendment.'                                                                                                                       union
select 2011, 1323006, '28' , 'Proposition 28 - Limits on Legislators'' Terms in Office'                                                                                                                                            union
select 2011, 1324462, '29' , 'Imposes Additional Tax on Cigarettes for Cancer Research'                                                                                                                                            union
select 2011, 1324462, '29' , 'Prop. 29 - Imposes Additional Taxes on Cigarettes'                                                                                                                                                   union
select 2011, 1324462, '29' , 'Proposition 29 - Imposes Additional Tax on Cigarettes for Cancer Research'                                                                                                                           union
select 2011, 1324462, '29' , 'Tobacco Tax for Cancer Research'                                                                                                                                                                     union
select 2011, 1346100, '30' , 'CA Proposition'                                                                                                                                                                                      union
select 2011, 1346100, '30' , 'CALIFORNIA STATE PROPOSITION'                                                                                                                                                                        union
select 2011, 1346100, '30' , 'Education/Public Safety Funding'                                                                                                                                                                     union
select 2011, 1346100, '30' , 'Prop. 30 - Temporary Taxes to Fund Education. Guaranteed Local Public Safety Funding.'                                                                                                               union
select 2011, 1346100, '30' , 'Proposition'                                                                                                                                                                                         union
select 2011, 1346100, '30' , 'Proposition 30'                                                                                                                                                                                      union
select 2011, 1346100, '30' , 'PROPOSITION 30 -TEMPORARY TAXES TO FUND EDUCATION.'                                                                                                                                                  union
select 2011, 1346100, '30' , 'Temp Taxes to Fund Ed.'                                                                                                                                                                              union
select 2011, 1346100, '30' , 'Temp Taxes to Fund Educ. Guranteed Local Pub. Sfty'                                                                                                                                                  union
select 2011, 1346100, '30' , 'Temp. Taxes to Fund Education'                                                                                                                                                                       union
select 2011, 1346100, '30' , 'Temporary Taxes to Fund Education'                                                                                                                                                                   union
select 2011, 1346100, '30' , 'Temporary Taxes to Fund Education, Guaranteed Local Public Safety Funding Initiative'                                                                                                                union
select 2011, 1346100, '30' , 'Temporary Taxes to Fund Education, Guaranteed Local Public Safety Funding, Initiative Constitutional Amendment'                                                                                      union
select 2011, 1346100, '30' , 'Temporary Taxes to Fund Education.  Guaranteed Local Public Safety Funding.  Initiative Constitutional Amendment.'                                                                                   union
select 2011, 1346100, '30' , 'Temporary Taxes to Fund Education. Guaranteed Local Public Safety Funding'                                                                                                                           union
select 2011, 1346100, '30' , 'Temporary Taxes to Fund Education. Guaranteed Local Public Safety Funding.'                                                                                                                          union
select 2011, 1346100, '30' , 'Temporary Taxes to Fund Education. Guaranteed Local Public Safety Funding. Initiative Constitutional Amendment'                                                                                      union
select 2011, 1346100, '30' , 'TEMPORARY TAXES TO FUND EDUCATION. GUARANTEED LOCAL PUBLIC SAFETY FUNDING. INITIATIVE CONSTITUTIONAL AMENDMENT, PROPOSITION'                                                                         union
select 2011, 1346100, '30' , 'Temporary Taxes to Fund Education. Guaranteed Local Public Safety Funding. Initiative Constitutional Amendment.'                                                                                     union
select 2011, 1346100, '30' , 'Temporary taxes to fund education. Guaranteed local public safety funding. Initiative constitutional amendment. Proposition.'                                                                        union
select 2011, 1346100, '30' , 'Temporary taxes to fund education. Guaranteed local public safety funding. Initiative constitutional. Prop.'                                                                                         union
select 2011, 1346100, '30' , 'Temporary Taxes to Fund Education. Guaranteed Local Public Safety Funding., Prop.'                                                                                                                   union
select 2011, 1346100, '30' , 'Temporary Taxes to Fund Education. Guaranteed Local Public Saftey Funding. Initiative Constitutional Amendment. Proposition'                                                                         union
select 2011, 1346100, '30' , 'Temporary Taxes to Fund Education. Local Public Sa'                                                                                                                                                  union
select 2011, 1346100, '30' , 'Temporary Taxes to Fund Education. Local Public Safety Funding.'                                                                                                                                     union
select 2011, 1346100, '30' , 'The Schools and Local Public Safety Protection Act'                                                                                                                                                  union
select 2011, 1346100, '30' , 'Yes on Prop 30'                                                                                                                                                                                      union
select 2011, 1346100, '30' , 'Yes on Proposition 30'                                                                                                                                                                               union
select 2011, 1343403, '31' , 'No on 31'                                                                                                                                                                                            union
select 2011, 1343403, '31' , 'PROP 31-STATE BUDGET. STATE AND LOCAL GOVERNMENT.'                                                                                                                                                   union
select 2011, 1343403, '31' , 'Prop. 31 - State Budget. State and Local Government'                                                                                                                                                 union
select 2011, 1343403, '31' , 'Proposition 31'                                                                                                                                                                                      union
select 2011, 1343403, '31' , 'Proposition 31 (F496)'                                                                                                                                                                               union
select 2011, 1343403, '31' , 'State Budget. State and Local Government'                                                                                                                                                            union
select 2011, 1343403, '31' , 'State Budget. State and Local Government. Initiative Constitutional Amendment and Statute.'                                                                                                          union
select 2011, 1343403, '31' , 'State Budget. State and Local Government. Initiative Constitutional Amendment and Statute. Proposition'                                                                                              union
select 2011, 1338955, '32' , 'Ban on corporate and union contributions to state and local candidates'                                                                                                                              union
select 2011, 1338955, '32' , 'No on 32'                                                                                                                                                                                            union
select 2011, 1338955, '32' , 'Paycheck Protection'                                                                                                                                                                                 union
select 2011, 1338955, '32' , 'Paycheck Protection Initiative'                                                                                                                                                                      union
select 2011, 1338955, '32' , 'Phohibits Political Contributions by Payroll Deductions. Prohibitions on Contributions to Candidates. Intiative Statute, Prop.'                                                                      union
select 2011, 1338955, '32' , 'Pol Contribs by Payroll Ded. Contribs to Candidate'                                                                                                                                                  union
select 2011, 1338955, '32' , 'Pol Contribs by Payroll Deduction.'                                                                                                                                                                  union
select 2011, 1338955, '32' , 'Pol Contribs by Payroll Deduction. Contrib to Candidates'                                                                                                                                            union
select 2011, 1338955, '32' , 'Pol Contribs by Payroll Deduction. Contributions to Candidates'                                                                                                                                      union
select 2011, 1338955, '32' , 'Political contirbutions by payroll deductions. Contributions to candidates. Initiative Statute. Proposition'                                                                                         union
select 2011, 1338955, '32' , 'Political Contribution by Payroll Deduction, Contributions to Candidates.'                                                                                                                           union
select 2011, 1338955, '32' , 'Political Contributions'                                                                                                                                                                             union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduct.  Contributions to Candidates.'                                                                                                                            union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction'                                                                                                                                                        union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction, Contributions to Candidates.'                                                                                                                          union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction.'                                                                                                                                                       union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction.  Contributions to Candidates.'                                                                                                                         union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction.  Contributions to Candidates.  Initiative Statue.'                                                                                                     union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction.  Contributions to Candidates.  Initiative Statute'                                                                                                     union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction.  Contributions to Candidates.  Initiative Statute.'                                                                                                    union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction.  Contributions to Candidates. Initiative Statute'                                                                                                      union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction. Contribution to Candidates. Initiative Statute'                                                                                                        union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction. Contributions to Candidates'                                                                                                                           union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction. Contributions to Candidates Initiative'                                                                                                                union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction. Contributions to Candidates. Initiative Stature'                                                                                                       union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction. Contributions to Candidates. Initiative Statute'                                                                                                       union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction. Contributions to Candidates. Initiative Statute.'                                                                                                      union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction. Contributions to Candidates. Initiative Statute. Proposition'                                                                                          union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction. Contributons to Candidates. Initiative Statue'                                                                                                         union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deductions'                                                                                                                                                       union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deductions, Contributions to Candidates, Initiative Statute'                                                                                                      union
select 2011, 1338955, '32' , 'Political contributions by payroll deductions. Contributions to candidates. Initiative Statute. Proposition'                                                                                         union
select 2011, 1338955, '32' , 'Prohibits contributions by payroll deduction'                                                                                                                                                        union
select 2011, 1338955, '32' , 'Prohibits Payroll Deduction for Political Contributions'                                                                                                                                             union
select 2011, 1338955, '32' , 'Prohibits Pol. Contrib. by Payroll Deductions'                                                                                                                                                       union
select 2011, 1338955, '32' , 'Prohibits Pol. Contrib. by Payroll Deductions,'                                                                                                                                                      union
select 2011, 1338955, '32' , 'Prohibits political contirbutions by payroll deductions. Prohibitions on contributions to candidates. Initiative Statute.'                                                                           union
select 2011, 1338955, '32' , 'Prohibits Political Contribuitons By Payroll Deductions, Prohibitions on Contributions to Candidates, Initiative Statute'                                                                            union
select 2011, 1338955, '32' , 'Prohibits Political Contributions by Payroll Deducation and Contributions to Candidates'                                                                                                             union
select 2011, 1338955, '32' , 'Prohibits Political Contributions by Payroll Deductions & Prohibitions on Contributions to Candidates initiative'                                                                                    union
select 2011, 1338955, '32' , 'Prohibits Political Contributions by Payroll Deductions. Prohibitions on Contributions to Candidates.'                                                                                               union
select 2011, 1338955, '32' , 'PROHIBITS POLITICAL CONTRIBUTIONS BY PAYROLL DEDUCTIONS. PROHIBITIONS ON CONTRIBUTIONS TO CANDIDATES. INITIATIVE STATUTE.'                                                                           union
select 2011, 1338955, '32' , 'Prohibits Political Contributions by Payroll Deductions. Prohibitions on Contributions to Candidates., Prop.'                                                                                        union
select 2011, 1338955, '32' , 'PROP 32 - PROHIBITS POLITICAL CONTRIBUTIONS BY PAY'                                                                                                                                                  union
select 2011, 1338955, '32' , 'Prop. 32 - Prohibits Political Contributions by Payroll Deductions. Prohibitions on Contributions to Candidates.'                                                                                    union
select 2011, 1338955, '32' , 'Proposition'                                                                                                                                                                                         union
select 2011, 1338955, '32' , 'Proposition 32'                                                                                                                                                                                      union
select 2011, 1338955, '32' , 'Stop Special Interest'                                                                                                                                                                               union
select 2011, 1338955, '32' , 'Stop Special Interest Money Now'                                                                                                                                                                     union
select 2011, 1338955, '32' , 'Stop the Special Exeptions Act'                                                                                                                                                                      union
select 2011, 1338955, '32' , 'The Special Exeptions Act'                                                                                                                                                                           union
select 2011, 1338955, '32' , ''                                                                                                                                                                                                    union
select 2011, 1340657, '33' , 'Auto Insurance Companies. Prices Based on Driver''s History of Insurance Coverage'                                                                                                                   union
select 2011, 1340657, '33' , 'Auto Insurance Companies. Prices Based on Driver''s History of Insurance Coverage. Initiative Statute.'                                                                                              union
select 2011, 1340657, '33' , 'Auto Insurance Companies. Prices Based on Driver''s History of Insurance Coverage. Initiative Statute. Proposition'                                                                                  union
select 2011, 1340657, '33' , 'Auto Insurance Discount Act'                                                                                                                                                                         union
select 2011, 1340657, '33' , 'Changes Law to Allow Insurance Companies to Set Prices Based on a Driver''s History of Continuous Coverage. Initiative Statute'                                                                      union
select 2011, 1340657, '33' , 'Changes Law to Allow Insurance Companies to Set Prices Based On Drivers History of Insurance Coverage. Initiatiive Statute'                                                                          union
select 2011, 1340657, '33' , 'Changing Laws to Allow Auto Insurance Companies to Set Prices'                                                                                                                                       union
select 2011, 1340657, '33' , 'PROP 33-CHANGES LAW TO ALLOW AUTO INSURANCE COMPAN'                                                                                                                                                  union
select 2011, 1340657, '33' , 'Prop. 33 - Changes Law to Allow Auto Insurance Companies to Set Prices Based on a Driver''s History of Insurance Coverage.'                                                                          union
select 2011, 1340657, '33' , 'Prop. 33 - Changes to Law to Allow Auto Insurance'                                                                                                                                                   union
select 2011, 1340657, '33' , 'Proposition 33'                                                                                                                                                                                      union
select 2011, 1340657, '33' , 'Yes on Prop 33'                                                                                                                                                                                      union
select 2011, 1342580, '34' , 'Death Penalty'                                                                                                                                                                                       union
select 2011, 1342580, '34' , 'Death Penalty Repeal'                                                                                                                                                                                union
select 2011, 1342580, '34' , 'Death Penalty Repeal, Initiative Statute'                                                                                                                                                            union
select 2011, 1342580, '34' , 'Death Penalty Repeal.'                                                                                                                                                                               union
select 2011, 1342580, '34' , 'DEATH PENALTY. INIATIVE STATUTE'                                                                                                                                                                     union
select 2011, 1342580, '34' , 'DEATH PENALTY. INITIATIVE STATUE'                                                                                                                                                                    union
select 2011, 1342580, '34' , 'Death Penalty. Initiative Statute.'                                                                                                                                                                  union
select 2011, 1342580, '34' , 'Prop. 34 - Death Penalty Repeal'                                                                                                                                                                     union
select 2011, 1342580, '34' , 'PROPOSITION 034 - DEATH PENALTY REPEAL. INITIATIVE'                                                                                                                                                  union
select 2011, 1342580, '34' , 'Proposition 34'                                                                                                                                                                                      union
select 2011, 1343414, '35' , 'Human Trafficking'                                                                                                                                                                                   union
select 2011, 1343414, '35' , 'Human Trafficking, Penalties, Sex Offender Registration, Initiative Statute'                                                                                                                         union
select 2011, 1343414, '35' , 'Human Trafficking. Penalties'                                                                                                                                                                        union
select 2011, 1343414, '35' , 'Human Trafficking. Penalties. Initiative Statute.'                                                                                                                                                   union
select 2011, 1343414, '35' , 'Penalties re Human Trafficking'                                                                                                                                                                      union
select 2011, 1343414, '35' , 'Prop 35'                                                                                                                                                                                             union
select 2011, 1343414, '35' , 'PROP 35-HUMAN TRAFFICKING. PENALTIES. SEX OFFENDER'                                                                                                                                                  union
select 2011, 1343414, '35' , 'Prop. 35 - Human Trafficking. Penalties. Sex Offender Registration.'                                                                                                                                 union
select 2011, 1343414, '35' , 'Proposition 35'                                                                                                                                                                                      union
select 2011, 1343487, '36' , 'PROP 36-THREE STRIKES LAW. SENTENCING FO'                                                                                                                                                            union
select 2011, 1343487, '36' , 'Prop. 36 - Three Strikes Law. Sentencing for Repea'                                                                                                                                                  union
select 2011, 1343487, '36' , 'Prop. 36 - Three Strikes Law. Sentencing for Repeat Felony Offenders.'                                                                                                                               union
select 2011, 1343487, '36' , 'PROPOSITION'                                                                                                                                                                                         union
select 2011, 1343487, '36' , 'Proposition 36'                                                                                                                                                                                      union
select 2011, 1343487, '36' , 'Proposition 36 - Three Strikes Law, Sentencing For Repeat Felony Offenders Initiative Statute.'                                                                                                      union
select 2011, 1343487, '36' , 'Three Strikes Law. Repeat Felony Offenders. Penalties'                                                                                                                                               union
select 2011, 1343487, '36' , 'Three Strikes Law. Repeat Felony Offenders. Penalties. Initiative Statute.'                                                                                                                          union
select 2011, 1343487, '36' , 'Three Strikes Law. Sentencing for Repeat Felony Offenders Initiative'                                                                                                                                union
select 2011, 1343487, '36' , 'Three Strikes Law. Sentencing for Repeat Felony Offenders, Proposition'                                                                                                                              union
select 2011, 1343487, '36' , 'Three Strikes Law. Sentencing for Repeat Felony Offenders, Proposition 36'                                                                                                                           union
select 2011, 1344799, '37' , 'CALIFORNIA RIGHT TO KNOW GENETICALLY ENGINEERED FOODS'                                                                                                                                               union
select 2011, 1344799, '37' , 'Genetically Engineered Foods, Mandatory Labeling Initiative'                                                                                                                                         union
select 2011, 1344799, '37' , 'Genetically Engineered Foods, Mandatory Labeling, Initiative Statute.'                                                                                                                               union
select 2011, 1344799, '37' , 'Genetically Engineered Foods. Labeling'                                                                                                                                                              union
select 2011, 1344799, '37' , 'GENETICALLY ENGINEERED FOODS. LABELING.'                                                                                                                                                             union
select 2011, 1344799, '37' , 'Genetically Engineered Foods. Labeling. Initiative Statute.'                                                                                                                                         union
select 2011, 1344799, '37' , 'Genetically Enginered Foods'                                                                                                                                                                         union
select 2011, 1344799, '37' , 'PROP 37-GENETICALLY ENGINEERED FOODS. MA'                                                                                                                                                            union
select 2011, 1344799, '37' , 'Prop. 37 - Genetically Engineered Foods. Mandatory'                                                                                                                                                  union
select 2011, 1344799, '37' , 'Prop. 37 - Genetically Engineered Foods. Mandatory Labeling.'                                                                                                                                        union
select 2011, 1344799, '37' , 'PROPOSITION'                                                                                                                                                                                         union
select 2011, 1344799, '37' , 'Proposition 37'                                                                                                                                                                                      union
select 2011, 1344799, '37' , 'The Californai Right To Know Genetically Engineered Food Act'                                                                                                                                        union
select 2011, 1345063, '38' , 'PROP38-TAX FOR EARLY EDUCATION AND EARL'                                                                                                                                                             union
select 2011, 1345063, '38' , 'Proposition 38'                                                                                                                                                                                      union
select 2011, 1345063, '38' , 'Tax for Early Education and Early Childhood Programs.'                                                                                                                                               union
select 2011, 1345063, '38' , 'Tax for Early Education and Early Childhood Programs., Prop.'                                                                                                                                        union
select 2011, 1345063, '38' , 'Tax to Fund Education and Early Childhood Programs'                                                                                                                                                  union
select 2011, 1345063, '38' , 'Tax to Fund Education and Early Childhood Programs. Initiative Statute.'                                                                                                                             union
select 2011, 1345063, '38' , 'Tax to Fund Education and Early Childhood Programs. Initiative Statute. Proposition'                                                                                                                 union
select 2011, 1345063, '38' , 'Yes on Prop 38'                                                                                                                                                                                      union
select 2011, 1343442, '39' , 'Calfornians For Clean Energy and Jobs, Sponsored by Enviornmental Organizations and Business for Clean Energy and Jobs'                                                                              union
select 2011, 1343442, '39' , 'PROP 39-TAX TREATMENT FOR MULTISTATE BUS'                                                                                                                                                            union
select 2011, 1343442, '39' , 'Prop. 39 - Tax Treatment for Multistate Businesses'                                                                                                                                                  union
select 2011, 1343442, '39' , 'Prop. 39 - Tax Treatment for Multistate Businesses. Clean Energy and Energy Efficiency Funding.'                                                                                                     union
select 2011, 1343442, '39' , 'Proposition'                                                                                                                                                                                         union
select 2011, 1343442, '39' , 'Tax Treatment for Multistate Businesses. Clean Energy and Energy Efficiency Funding'                                                                                                                 union
select 2011, 1343442, '39' , 'Tax Treatment for Multistate Businesses. Clean Energy and Energy Efficiency Funding. Initiative Statute.'                                                                                            union
select 2011, 1343442, '39' , 'Tax Treatment for Multistate Businesses. Clean Energy and Energy Efficiency Funding. Initiative Statute. Proposition'                                                                                union
select 2011, 1343442, '39' , 'Tax Treatment for Multistate Businesses. Clean Energy and Energy Efficiency Funding., Prop.'                                                                                                         union
select 2011, 1343442, '39' , 'Yes on 39'                                                                                                                                                                                           union
select 2011, 1341037, '40' , 'PROP 40-REDISTRICTING. STATE SENTATE DIS'                                                                                                                                                            union
select 2011, 1341037, '40' , 'Prop. 40 - Redistricting. State Senate Districts.'                                                                                                                                                   union
select 2011, 1341037, '40' , 'Proposition 40'                                                                                                                                                                                      union
select 2011, 1341037, '40' , 'Redistricting. State Senate Districts'                                                                                                                                                               union
select 2011, 1341037, '40' , 'Redistricting. State Senate Districts. Referendum.'                                                                                                                                                  union
select 2011, 1341037, '40' , 'Redistricting. State Senate Districts. Referendum. Proposition'                                                                                                                                      union
select 2011, 1341037, '40' , 'Yes on 40 - Hold Politicians Accountable'                                                                                                                                                            union
select 2011, 1338955, 'N/A', 'Ca;ifornians Against Special Interests'                                                                                                                                                              union
select 2011, 1338955, 'N/A', 'Californians Against Special Interests'                                                                                                                                                              union
select 2011, 1338955, 'NA' , 'Californians Against Special InNterests'                                                                                                                                                             union
select 2011, 1338955, 'NA' , 'Californians Against Special Interests'                                                                                                                                                              union
select 2011, 1338955, 'NA' , 'Stop Special Interest Money Now Act'                                                                                                                                                                 union
select 2011, 1338955, ''   , 'No on Proposition 32'                                                                                                                                                                                union
select 2011, 1343403, ''   , 'No on Propositon 31'                                                                                                                                                                                 union
select 2011, 1338955, ''   , 'No on Propositon 32'                                                                                                                                                                                 union
select 2011, 1338955, ''   , 'Prohibits Political Contribution by Payroll Deduction, Prohibitions on Contributions to Candidates (11-0010)'                                                                                        union
select 2011, 1338955, ''   , 'Prohibits Political Contributions by Payroll Deduction. Prohibitions on Contributions to Candidates. Initiative Statute (11-0010)'                                                                   union
select 2011, 1343403, ''   , 'Prop 31 - State Budget. State and Local Government Initiative Constitutional Amendment and Statute.'                                                                                                 union
select 2011, 1343414, ''   , 'Prop 35 - Human Trafficing. Penalties. Sex Offender Registration. Initiative Statute'                                                                                                                union
select 2011, 1341037, ''   , 'Prop 40 - Redistricting. State Senate Districts. Referendum'                                                                                                                                         union
select 2011, 1323006, ''   , 'Proposition 28'                                                                                                                                                                                      union
select 2011, 1346100, ''   , 'Proposition 30'                                                                                                                                                                                      union
select 2011, 1338955, ''   , 'PROPOSITION 32'                                                                                                                                                                                      union
select 2011, 1346100, ''   , 'Yes on Proposition 30'                                                                                                                                                                               union
select 2011, 1343414, ''   , 'Yes on Proposition 35'                                                                                                                                                                               union
select 2011, 1341037, ''   , 'Yes on Proposition 40'                                                                                                                                                                               union
select 2013, 1339806, '02' , 'State Budget. State Budget Stabilization.'                                                                                                                                                           union
select 2013, 1361585, '046', 'Drug & Alcohol Testing of Doctors.  Medical Negligence Lawsuits. Initiative Statute'                                                                                                                 union
select 2013, 1369617, '1'  , 'AB 1471 Water Quality  Supply & Infrastructure Improvement Act of 2014'                                                                                                                              union
select 2013, 1369617, '1'  , 'Funding for Water Quality, Supply, Treatment, and Strorage Projects.'                                                                                                                                union
select 2013, 1369617, '1'  , 'Proposition 1'                                                                                                                                                                                       union
select 2013, 1369617, '1'  , 'WATER BONDS'                                                                                                                                                                                         union
select 2013, 1369617, '1'  , 'Water Quality and Infrastructure improvement Act'                                                                                                                                                    union
select 2013, 1369617, '1'  , 'Water Quality, Supply & Infrastructure Improvement Act of 2014'                                                                                                                                      union
select 2013, 1369617, '1'  , 'Water Quality, Supply and Infrastructure Improvement Act of 2014'                                                                                                                                    union
select 2013, 1369617, '1'  , 'Water Quality/Supply/Infrastructure Act'                                                                                                                                                             union
select 2013, 1361585, '136', 'Yes on Prop 46'                                                                                                                                                                                      union
select 2013, 1339806, '2'  , 'Budget Stabilization Account'                                                                                                                                                                        union
select 2013, 1339806, '2'  , 'Rainy Day Budget Stabilization Fund Act'                                                                                                                                                             union
select 2013, 1339806, '2'  , 'STATE BUDGET'                                                                                                                                                                                        union
select 2013, 1339806, '2'  , 'State Budget. Budget Stabilization Account. Legislative Constitutional Amendment.'                                                                                                                   union
select 2013, 1339806, '2'  , 'State Reserve Policy'                                                                                                                                                                                union
select 2013, 1361706, '41' , 'Veterans Housing & Homeless Prevention Bond Act of 2014'                                                                                                                                             union
select 2013, 1361706, '41' , 'Veterans Housing and Homeless Prevention Bond Act of 2014'                                                                                                                                           union
select 2013, 1361705, '42' , 'Public Records. Open Meetings. State Reimbursement to Local Agencies'                                                                                                                                union
select 2013, 1343429, '45' , 'Healthcare Insurance, Rate Changes and Initiative Statue'                                                                                                                                            union
select 2013, 1343429, '45' , 'Healthcare Insurance. Rate Changes. Initiative Statute.'                                                                                                                                             union
select 2013, 1343429, '45' , 'Justify Rates'                                                                                                                                                                                       union
select 2013, 1343429, '45' , 'Public Notice Required for Insurance Company Rates Initiative'                                                                                                                                       union
select 2013, 1361585, '46' , 'Medical Malpractice Lawsuits Cap and Drug Testing of Doctors Initiative'                                                                                                                             union
select 2013, 1363898, '47' , 'California Safety Act'                                                                                                                                                                               union
select 2013, 1363898, '47' , 'Criminal Sentences, Misdeneanor Penalties Initiative Statute'                                                                                                                                        union
select 2013, 1363898, '47' , 'Criminal Sentences. Misdemeanor Penalties. Initiative Statute'                                                                                                                                       union
select 2013, 1363898, '47' , 'Criminal Sentences. Misdemeanor Penalties. Initiative Statute.'                                                                                                                                      union
select 2013, 1363898, '47' , 'CRIMINAL SENTENCING'                                                                                                                                                                                 union
select 2013, 1363898, '47' , 'Reduced Penalties for Some Crimes Initiative'                                                                                                                                                        union
select 2013, 1363898, '47' , 'Safe Neighorhoods and Schools.'                                                                                                                                                                      union
select 2013, 1363898, '47' , 'Yes on Prop 47'                                                                                                                                                                                      union
select 2013, 1359095, '48' , 'Indian Gaming Compacts'                                                                                                                                                                              union
select 2013, 1359095, '48' , 'Indian Gaming Compacts Referendum'                                                                                                                                                                   union
select 2013, 1359095, '48' , 'Indian Gaming Compacts. Refernedum.'                                                                                                                                                                 union
select 2013, 1343429, ''   , 'Approval of Healthcare Insurance Rate Changes. Initiative Statute. 11-0070'                                                                                                                          union
select 2013, 1363898, ''   , 'Criminal Sentences. Misdemeanor Penalties. Initiative Statute. Proposition 47'                                                                                                                       union
select 2013, 1369617, ''   , 'Proposition 1'                                                                                                                                                                                       union
select 2013, 1369617, ''   , 'PROPOSTION 1'                                                                                                                                                                                        union
select 2013, 1369617, ''   , 'Water Quality, Supply and Infrastructure Improvement Act of 2014, Proposition 1'                                                                                                                     union
select 2015, 1338955, '32' , 'Proposition 32 Political Contributions by Payroll Deduction'                                                                                                                                         union
-- new 2015-08-12:
select 2001, 1239148, '40' , 'CA Clean Water, Clean Air, Safe Neighborhood Parks & Coastal Protection Act'                                                                                                                         union
select 2001, 1238847, '44' , 'Insurance Fund'                                                                                                                                                                                      union
select 2001, 1225301, '34' , 'PROPOSITION 34 STATEWIDE'                                                                                                                                                                            union
select 2001, 1224425, '39' , 'PROPOSITION 39 STATEWIDE'                                                                                                                                                                            union
select 2001, 1239150, '41' , 'Voting Modernization Bond Act of 2002'                                                                                                                                                               union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction.  Contributions to Candidates.  Initative Statute'                                                                                                      union
select 2013, 1343429, '45' , 'Californias Against Higher Healthcare Costs'                                                                                                                                                         union
-- new 2015-08-14:
select 2001, 1239148, '40' , 'CA Clean Water, Clean Air, Safe Neighborhood Parks & Coastal Protection Act'                                                                                                                         union
select 2001, 1238847, '44' , 'Insurance Fund'                                                                                                                                                                                      union
select 2001, 1239150, '41' , 'Voting Modernization Bond Act of 2002'                                                                                                                                                               union
select 2003, 1265077, ''   , 'Proposition 59'                                                                                                                                                                                      union
select 2003, 1260927, ''   , 'Proposition 63'                                                                                                                                                                                      union
select 2003, 1256382, ''   , 'Shall Gray Davis be recalled from the Office of Governor'                                                                                                                                            union
select 2005, 1284381, '90' , 'Government Acquisition, Regulation of Private Property: Proposition 90'                                                                                                                              union
select 2005, 1276369, ''   , 'Prop 75'                                                                                                                                                                                             union
select 2005, 1283871, '85' , 'Waiting period & parental notification'                                                                                                                                                              union
select 2005, 1285554, '83' , 'Yes on Prop 83, Jessica''s Law'                                                                                                                                                                      union
select 2007, 1302602, '8'  , 'Elimination of Right of Same Sex Couples to Marry.  Initiative.  Constitutional Amendment.'                                                                                                          union
select 2007, 1299177, '93' , 'Limits on Legislators'' Terms in Office Initiative Constitutional Amendment'                                                                                                                         union
select 2007, 1303172, '5'  , 'Non-violent Drug Offenses.  Sentencing, Parole and Rehabilitation'                                                                                                                                   union
select 2007, 1310496, '1A' , 'SAFE, RELIABLE HIGH SPEED TRAIN BOND ACT'                                                                                                                                                            union
select 2007, 1310496, '1A' , 'SAFE, RELIABLE HIGH-SPEED TRAIN BOND ACT'                                                                                                                                                            union
select 2007, 1302575, '4'  , 'Waiting Period and Parental Notification Before Termination of Minor''s Pregnancy'                                                                                                                   union
select 2009, 1323274, '25' , 'Changes legislative vote requirement to pass budget from 2/3 to a simple majority. Retains 2/3 vote requirement for taxes.'                                                                          union
select 2009, 1323361, '21' , 'Proposition 21 - Establishes $18 Annual Vehicle License Surcharge to Help Fund State Parks and Wildlife Programs'                                                                                    union
select 2011, 1323006, '28' , 'Change in Term Limits'                                                                                                                                                                               union
select 2011, 1338955, '32' , 'Paycheck Protection Measure'                                                                                                                                                                         union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction Proposition'                                                                                                                                            union
select 2011, 1338955, '32' , 'Political Contributions by Payroll Deduction.  Contributions to Candidates.  Initative Statute'                                                                                                      union
select 2011, 1338955, '32' , 'Political Contributions By Payroll Deduction; Contributions To Candidates'                                                                                                                           union
select 2013, 1369617, '1'  , 'AB 1471 Water Quality, Supply & Infrastructure Improvement Act of 2014'                                                                                                                              union
select 2013, 1343429, '45' , 'Californias Against Higher Healthcare Costs'                                                                                                                                                         union
select 2013, 1361706, '41' , 'Veterans Housing and Homeless Prevention Act'                                                                                                                                                        union
select 2013, 1369617, '1'  , 'Water Quality, Supply, and Infrastructure Improvement Act of 2014.'                                                                                                                                  union
-- new 2015-09-03
select 2007, 1305462, ''   , 'Yes on Recall'                                                                                                                                                                                       
;

DROP TABLE IF EXISTS proposition_name_spellings_ignore;

CREATE TABLE proposition_name_spellings_ignore (
  ElectionCycle SMALLINT NOT NULL,
  TargetPropositionNumber VARCHAR(10) NOT NULL,
  TargetPropositionNameOriginal VARCHAR(250) NOT NULL,
  PRIMARY KEY (ElectionCycle, TargetPropositionNumber, TargetPropositionNameOriginal)
);

insert proposition_name_spellings_ignore (ElectionCycle, TargetPropositionNumber, TargetPropositionNameOriginal)
-- 2015-09-03
select 2001, ''   , 'L.A. CITY SECESSION'                                                                                                                                                                                 union
select 2001, ''   , 'L.A. SECESSION'                                                                                                                                                                                      union
select 2001, ''   , 'Measure V'                                                                                                                                                                                           union
select 2001, ''   , 'S.F. Valley And Hollywood Succession'                                                                                                                                                                union
select 2001, '0'  , 'Citizens for Better Communities'                                                                                                                                                                     union
select 2001, 'D'  , 'Proposed Formation For Carson Unified School District  Measure D'                                                                                                                                    union
select 2001, 'F&H', 'L.A. Secession'                                                                                                                                                                                      union
select 2001, 'GG' , 'No On GG - Initiative To Repeal Irvine''s Utility User''s Tax'                                                                                                                                         union
select 2001, 'I'  , 'City Attorney Consent - Measure I'                                                                                                                                                                   union
select 2001, 'K'  , 'Alliance For Neighborhood Schools'                                                                                                                                                                   union
select 2003, ''   , 'Measure J - Roseville Joint Union High School Bonds (County of Placer)'                                                                                                                              union
select 2003, ''   , 'Referendum - Save Our License'                                                                                                                                                                       union
select 2003, '04A', 'Inglewood Measure 04-A'                                                                                                                                                                              union
select 2003, '04A', 'Measure 04-A'                                                                                                                                                                                        union
select 2003, 'R'  , 'Safe, Healthy, Neighborhood Schools Measure'                                                                                                                                                         union
select 2005, ''   , 'NO ON PROPOSITION 75 AND 76'                                                                                                                                                                         union
select 2005, ''   , 'No On Propositions 75 and 76'                                                                                                                                                                        union
select 2005, ''   , 'Political Contributions and Expenditures by Corporations. Shareholder Consent Requirements'                                                                                                          union
select 2005, ''   , 'Prohibition on Govt. Employee Payroll Deductions for Political Purposes'                                                                                                                             union
select 2005, 'Mul', 'Prop 74,75,76'                                                                                                                                                                                       union
select 2007, ''   , 'Public Pension and Retirement Health Care Benefits'                                                                                                                                                  union
select 2007, 'Q'  , 'California for Safe and Healthy Neighborhood Schools'                                                                                                                                                union
select 2007, 'RR' , 'Friends to Improve Mt Sac'                                                                                                                                                                           union
select 2009, ''   , 'Sacramento Budget Measures 1A & 1B'                                                                                                                                                                  union
select 2009, 'D'  , 'Electronic Sign Proposal for Market Street between 5th and 7th Streets'                                                                                                                              union
select 2009, 'G'  , 'Proposition G Transbay Transit Center San Francisco County'                                                                                                                                          union
select 2011, ''   , 'Initiative #11-087: Requires Assessment of Most Commercial Property Every 3 yrs. Tax Redctn for Homeownrs, Rentrs, Businesses'                                                                       union
select 2011, ''   , 'No. 11-0078 ... Voting Requirement.  Polluter Fees.  Initiative Constitutional Amendment'                                                                                                            union
select 2011, ''   , 'No. 11-0079 ... Voting Requirement.  Polluter Fees.  Initiative Constitutional Amendment'                                                                                                            union
select 2011, ''   , 'Stop AB131 - Referendum to Overturn State Financial Aid for Undocumented Students'                                                                                                                   union
select 2011, '0'  , 'Yes on Measure O'                                                                                                                                                                                    union
select 2011, 'A'  , 'Proposition A'                                                                                                                                                                                       union
select 2011, 'AA' , 'CITY OF COMMERCE SALES TAX INCREASE'                                                                                                                                                                 union
select 2013, '49' , 'Corporations. Political Spending. Federal Constitutional Protections. Legislative Advisory Question.'                                                                                                union
select 2013, 'N/A', 'Opportunity PAC'                                                                                                                                                                                     
;

DROP TABLE IF EXISTS independent_expenditure_filings_new;

CREATE TABLE independent_expenditure_filings_new (
  ExpenditureFilingID BIGINT NOT NULL AUTO_INCREMENT,
  ExpenditureID BIGINT NULL,
  MatchCode TINYINT NULL,
  TransactionType VARCHAR(100) NOT NULL DEFAULT '',
  Form VARCHAR(10) NOT NULL DEFAULT '',
  Schedule VARCHAR(10) NOT NULL DEFAULT '',
  ElectionCycle SMALLINT NOT NULL DEFAULT 0,
  ElectionCvrOriginal VARCHAR(100) NOT NULL DEFAULT '',
  ElectionCvr DATE DEFAULT NULL,
  ElectionSmryOriginal VARCHAR(100) NOT NULL DEFAULT '',
  ElectionSmry DATE DEFAULT NULL,
  ElectionProp DATE DEFAULT NULL,
  Election DATE DEFAULT NULL,
  FilingID BIGINT NOT NULL,
  AmendID INTEGER NOT NULL,
  LineItem VARCHAR(5) NOT NULL DEFAULT '',
  RecType VARCHAR(5) NOT NULL DEFAULT '',
  TranID VARCHAR(32) NOT NULL DEFAULT '',
  ExpenditureCode VARCHAR(25) NOT NULL DEFAULT '',
  MemoRefNo VARCHAR(25) NOT NULL DEFAULT '',
  MemoCode VARCHAR(3) NOT NULL DEFAULT '',
  ExpenditureDscr VARCHAR(255) NOT NULL DEFAULT '',
  FilingDateStartOriginal VARCHAR(100) NOT NULL DEFAULT '',
  FilingDateStart DATE NULL,
  FilingDateEndOriginal VARCHAR(100) NOT NULL DEFAULT '',
  FilingDateEnd DATE NULL,
  ExpenditureDateOriginal VARCHAR(100) NOT NULL DEFAULT '',
  ExpenditureDate DATE NULL,
  DateStart DATE NULL,
  DateEnd DATE NULL,
  FiledDate DATETIME DEFAULT NULL,
  -- DateThru DATE DEFAULT NULL,
  AmountOriginal VARCHAR(50) NOT NULL DEFAULT '',
  AmountOriginal2 VARCHAR(50) NOT NULL DEFAULT '',
  AmountOriginal3 VARCHAR(50) NOT NULL DEFAULT '',
  Amount DOUBLE NOT NULL DEFAULT 0,
  ExpenderIDLegacy BIGINT NOT NULL DEFAULT 0,
  ExpenderID BIGINT NOT NULL DEFAULT 0,
  ExpenderName VARCHAR(250) NOT NULL,
  ExpenderCity VARCHAR(30) NOT NULL DEFAULT '',
  ExpenderState CHAR(2) NOT NULL DEFAULT '',
  ExpenderZipCode VARCHAR(10) NOT NULL DEFAULT '',
  ExpenderEntity VARCHAR(5) NOT NULL DEFAULT '',
  ExpenditureEntity VARCHAR(5) NOT NULL DEFAULT '',
  ExpenderCommitteeType VARCHAR(1) NOT NULL DEFAULT '',
  ExpenderPositionExpenditure VARCHAR(3) NOT NULL DEFAULT '',
  ExpenderPositionCvr VARCHAR(3) NOT NULL DEFAULT '',
  ExpenderPosition ENUM('S','O','U') NOT NULL DEFAULT 'U',
  TargetCandidateID BIGINT NOT NULL DEFAULT 0,
  TargetCandidateNameCvr VARCHAR(250) NOT NULL DEFAULT '',
  TargetCandidateNameExpenditure VARCHAR(250) NOT NULL DEFAULT '',
  TargetCandidateNamePreStandardization VARCHAR(250) NOT NULL DEFAULT '',
  TargetCandidateName VARCHAR(250) NOT NULL DEFAULT '',
  TargetCandidateOfficeCode VARCHAR(3) NOT NULL DEFAULT '',
  TargetCandidateOfficeCustom VARCHAR(50) NOT NULL DEFAULT '',
  TargetCandidateOfficeSoughtOrHeldOriginal VARCHAR(5) NOT NULL DEFAULT '',
  TargetCandidateOfficeSoughtOrHeld VARCHAR(1) NOT NULL DEFAULT '',
  TargetCandidateOffice VARCHAR(50) NOT NULL DEFAULT '',
  TargetCandidateDistrict VARCHAR(50) NOT NULL DEFAULT '',
  TargetCandidateJurisdictionCode VARCHAR(3) NOT NULL DEFAULT '',
  TargetCandidateJurisdictionCustom VARCHAR(50) NOT NULL DEFAULT '',
  TargetCandidateJurisdiction VARCHAR(50) NOT NULL DEFAULT '',
  TargetPropositionID BIGINT NOT NULL DEFAULT 0,
  -- TargetPropositionCycle SMALLINT NOT NULL DEFAULT 0,
  TargetPropositionNumber VARCHAR(10) NOT NULL DEFAULT '',
  TargetPropositionNameOriginal VARCHAR(250) NOT NULL DEFAULT '',
  TargetPropositionName VARCHAR(250) NOT NULL DEFAULT '',
  TargetPropositionJurisdictionOriginal VARCHAR(50) NOT NULL DEFAULT '',
  TargetPropositionJurisdiction VARCHAR(50) NOT NULL DEFAULT '',
  PayeeName VARCHAR(250) NOT NULL DEFAULT '',
  PayeeCity VARCHAR(30) NOT NULL DEFAULT '',
  PayeeState CHAR(2) NOT NULL DEFAULT '',
  PayeeZipCode VARCHAR(10) NOT NULL DEFAULT '',
  PayeeCommitteeIDOriginal VARCHAR(20) NOT NULL DEFAULT '',
  PayeeCommitteeID BIGINT NOT NULL DEFAULT 0,
  AgentName VARCHAR(250) NOT NULL DEFAULT '',
  OriginTable ENUM('expn','s496','smry') NOT NULL,
  Unitemized ENUM('Y','N') DEFAULT 'N',
  StateExpenditure ENUM('Y','N') DEFAULT 'N',
  LocalExpenditure ENUM('Y','N') DEFAULT 'N',
  CandidateExpenditure ENUM('Y','N') DEFAULT 'N',
  PropositionExpenditure ENUM('Y','N') DEFAULT 'N',
  BadElectionCycle ENUM('Y','N') DEFAULT 'N',
  HasAgent ENUM('Y','N') DEFAULT 'N',
  IsMemo ENUM('Y','N') DEFAULT 'N',
  NotIndependent ENUM('Y','N') DEFAULT 'N',
  Exclude ENUM('Y','N') DEFAULT 'N',
  -- NeedsCleanup ENUM('Y','N') DEFAULT 'N',
  PRIMARY KEY (ExpenditureFilingID),
  KEY ExpenditureID (ExpenditureID),
  KEY ElectionCycle (ElectionCycle),
  KEY FormSchedule (Form, Schedule),
  KEY OriginTable (OriginTable),
  KEY ExpenderID (ExpenderID),
  KEY DateStart (DateStart),
  KEY Amount (Amount),
  KEY TargetCandidateID (TargetCandidateID),
  KEY TargetCandidateName (TargetCandidateName(5)),
  KEY TargetPropositionID (TargetPropositionID),
  KEY TargetPropositionName (TargetPropositionName(5)),
  KEY TargetPropositionNameOriginal (TargetPropositionNameOriginal(5)),
  KEY TargetPropositionNumber (TargetPropositionNumber),
  KEY CandidateExpenditure (CandidateExpenditure),
  KEY PropositionExpenditure (PropositionExpenditure),
  KEY TargetPropositionJurisdiction (TargetPropositionJurisdiction(5)),
  KEY TargetCandidateJurisdiction (TargetCandidateJurisdiction(5))
);

DROP TABLE IF EXISTS ca_ie_search.independent_expenditures_new;

CREATE TABLE ca_ie_search.independent_expenditures_new (
  ExpenditureID BIGINT NOT NULL,
  -- ExpenditurePropositionID BIGINT NOT NULL, -- if the table contains separate records for each proposition an expenditure supports/opposes
  ElectionCycle SMALLINT NOT NULL DEFAULT 0,
  Election DATE DEFAULT NULL,
  ExpenditureDscr VARCHAR(255) NOT NULL DEFAULT '',
  DateStart DATE NULL,
  DateEnd DATE NULL,
  DateRange VARCHAR(25) NULL,
  Amount DOUBLE NOT NULL DEFAULT 0,
  ExpenderIDLegacy BIGINT NOT NULL DEFAULT 0,
  ExpenderID BIGINT NOT NULL DEFAULT 0,
  ExpenderName VARCHAR(250) NOT NULL,
  ExpenderCity VARCHAR(30) NOT NULL DEFAULT '',
  ExpenderState CHAR(2) NOT NULL DEFAULT '',
  ExpenderZipCode VARCHAR(10) NOT NULL DEFAULT '',
  ExpenderEntity VARCHAR(5) NOT NULL DEFAULT '',
  ExpenderCommitteeType VARCHAR(1) NOT NULL DEFAULT '',
  ExpenderPosition ENUM('S','O','U') NOT NULL DEFAULT 'U',
  TargetCandidateID BIGINT NOT NULL DEFAULT 0,
  TargetCandidateName VARCHAR(250) NOT NULL DEFAULT '',
  TargetCandidateOffice VARCHAR(50) NOT NULL DEFAULT '',
  TargetCandidateDistrict VARCHAR(50) NOT NULL DEFAULT '',
  TargetCandidateJurisdiction VARCHAR(50) NOT NULL DEFAULT '',
  TargetPropositionID BIGINT NOT NULL DEFAULT 0,
  -- TargetPropositionCycle SMALLINT NOT NULL DEFAULT 0,
  TargetPropositionName VARCHAR(250) NOT NULL DEFAULT '',
  -- TargetPropositionNumber VARCHAR(10) NOT NULL DEFAULT '',
  TargetPropositionJurisdiction VARCHAR(50) NOT NULL DEFAULT '',
  PayeeName VARCHAR(250) NOT NULL,
  PayeeCity VARCHAR(30) NOT NULL DEFAULT '',
  PayeeState CHAR(2) NOT NULL DEFAULT '',
  PayeeZipCode VARCHAR(10) NOT NULL DEFAULT '',
  PayeeCommitteeID BIGINT NOT NULL DEFAULT 0,
  Unitemized ENUM('Y','N') DEFAULT 'N',
  StateExpenditure ENUM('Y','N') DEFAULT 'N',
  LocalExpenditure ENUM('Y','N') DEFAULT 'N',
  CandidateExpenditure ENUM('Y','N') DEFAULT 'N',
  PropositionExpenditure ENUM('Y','N') DEFAULT 'N',
  PRIMARY KEY (ExpenditureID), -- or ExpenditurePropositionID
  KEY ElectionCycle (ElectionCycle),
  KEY Amount (Amount),
  KEY ExpenderName(ExpenderName(10)),
  KEY TargetCandidateName(TargetCandidateName(10))
) ENGINE=MyISAM
;