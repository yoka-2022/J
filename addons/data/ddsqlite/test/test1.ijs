cocurrent 'base'

wrds=. 'ddsrc ddtbl ddtblx ddcol ddcon dddis ddfch ddend ddsel ddcnm dderr'
wrds=. wrds, ' dddrv ddsql ddcnt ddtrn ddcom ddrbk ddbind ddfetch'
wrds=. wrds ,' dddata ddfet ddbtype ddcheck ddrow ddins ddparm ddsparm dddbms ddcolinfo ddttrn'
wrds=. wrds ,' dddriver ddconfig ddcoltype'
wrds=. wrds ,' userfn createdb exec sqlbad sqlok sqlres sqlresok'
wrds=. wrds , ' ', ;:^:_1 ('get'&,)&.> ;: ' DateTimeNull NumericNull UseErrRet UseDayNo UseUnicode CHALL'
wrds=. > ;: wrds
4!:55 wrds ,&.> <'_z_'
18!:55 <'jddsqlite'

load 'data/ddsqlite'

integerdate=: 0
UseDayNo=: 0

tdata_ddl=: 0 : 0
create table tdata (
NAME varchar(15) collate rtrim,
SEX varchar(1) collate rtrim,
DEPT varchar(4) collate rtrim,
DOB date,
DOH date,
SALARY float,
PHOTO blob );
)

tdata_ddl2=: 0 : 0
create table tdata (
NAME varchar(15) collate rtrim,
SEX varchar(1) collate rtrim,
DEPT varchar(4) collate rtrim,
DOB int,
DOH int,
SALARY float,
PHOTO blob );
)

tdata_data=: 0 : 0
begin transaction;
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Macdonald B', 'F', 'D101', '1959-06-01', '1978-05-01', 32591);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Genereaux S', 'F', 'D103', '1945-03-01', '1966-02-01', 95415);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Koebel R', 'M', 'D101', '1937-11-01', '1980-09-01', 63374);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Keller J', 'F', 'D101', '1951-05-01', '1974-04-01', 48898);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Twa L', 'F', 'D108', '1955-07-01', '1980-04-01', 49075);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Blamire J', 'F', 'D101', '1960-08-01', '1979-12-01', 46469);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Gordon E', 'F', 'D103', '1952-02-01', '1979-08-01', 29960);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Denny D', 'F', 'D101', '1949-08-01', '1980-04-01', 46939);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Newton R', 'M', 'D108', '1956-01-01', '1979-02-01', 73368);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Miller S', 'F', 'D103', '1965-01-01', '1983-03-01', 43418);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Dingee S', 'M', 'D103', '1964-10-01', '1983-09-01', 46877);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Bugg P', 'F', 'D101', '1920-11-01', '1958-04-01', 47165);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Lafrance R', 'F', 'D101', '1952-02-01', '1983-02-01', 47017);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Rogerson G', 'M', 'D101', '1957-12-01', '1983-02-01', 108777);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Brando D', 'F', 'D108', '1959-04-01', '1977-08-01', 44931);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Anctil J', 'M', 'D108', '1946-06-01', '1979-06-01', 60974);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Bauerlein J', 'F', 'D103', '1962-04-01', '1984-09-01', 33668);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('O''Keefe D', 'M', 'D101', '1939-03-01', '1967-10-01', 66377);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Beale D', 'F', 'D103', '1957-03-01', '1974-04-01', 48023);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Chesher D', 'F', 'D103', '1956-10-01', '1984-08-01', 35184);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Cahill G', 'M', 'D108', '1932-05-01', '1967-10-01', 81358);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Abbott K', 'M', 'D103', '1963-10-01', '1983-09-01', 50817);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('McKee M', 'F', 'D103', '1960-04-01', '1981-04-01', 43115);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Livingston P', 'F', 'D101', '1958-09-01', '1980-08-01', 50010);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Holliss D', 'F', 'D101', '1960-05-01', '1977-07-01', 46313);
commit;
)

tdata_data2=: 0 : 0
begin transaction;
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Macdonald B', 'F', 'D101', 19590601, 19780501, 32591);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Genereaux S', 'F', 'D103', 19450301, 19660201, 95415);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Koebel R', 'M', 'D101', 19371101, 19800901, 63374);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Keller J', 'F', 'D101', 19510501, 19740401, 48898);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Twa L', 'F', 'D108', 19550701, 19800401, 49075);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Blamire J', 'F', 'D101', 19600801, 19791201, 46469);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Gordon E', 'F', 'D103', 19520201, 19790801, 29960);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Denny D', 'F', 'D101', 19490801, 19800401, 46939);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Newton R', 'M', 'D108', 19560101, 19790201, 73368);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Miller S', 'F', 'D103', 19650101, 19830301, 43418);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Dingee S', 'M', 'D103', 19641001, 19830901, 46877);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Bugg P', 'F', 'D101', 19201101, 19580401, 47165);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Lafrance R', 'F', 'D101', 19520201, 19830201, 47017);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Rogerson G', 'M', 'D101', 19571201, 19830201, 108777);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Brando D', 'F', 'D108', 19590401, 19770801, 44931);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Anctil J', 'M', 'D108', 19460601, 19790601, 60974);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Bauerlein J', 'F', 'D103', 19620401, 19840901, 33668);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('O''Keefe D', 'M', 'D101', 19390301, 19671001, 66377);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Beale D', 'F', 'D103', 19570301, 19740401, 48023);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Chesher D', 'F', 'D103', 19561001, 19840801, 35184);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Cahill G', 'M', 'D108', 19320501, 19671001, 81358);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Abbott K', 'M', 'D103', 19631001, 19830901, 50817);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('McKee M', 'F', 'D103', 19600401, 19810401, 43115);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Livingston P', 'F', 'D101', 19580901, 19800801, 50010);
insert into tdata (NAME, SEX, DEPT, DOB, DOH, SALARY) values ('Holliss D', 'F', 'D101', 19600501, 19770701, 46313);
commit;
)

NB. =========================================================
testdb=: 3 : 0
NB. setzlocale_jddsqlite_ ''
db=. '' conew 'jddsqlite'

ddconfig__db 'errret';0;'dayno';UseDayNo;'unicode';1

smoutput '>> dddriver'
smoutput dddriver__db''

smoutput '>> dddrv'
smoutput dddrv__db''

smoutput '>> ddsrc'
smoutput ddsrc__db''

smoutput '>> delete old database'
f=. jpath '~temp/jdata.sqlite'
1!:55 ::0: <f
assert. 0=#1!:0 f

smoutput '>> create empty database'
'' 1!:2 <f
assert. 1=#1!:0 f

smoutput '>> open database'
if. sqlresok__db rc=. ddcon__db 'database=',f,';nocreate=0' do.
  ch=. sqlres__db rc
  smoutput '>> create metadata and fill sample data'
  smoutput ch exec__db~ integerdate{::tdata_ddl;tdata_ddl2
  smoutput ch exec__db~ integerdate{::tdata_data;tdata_data2

  smoutput '>> dddbm'
  smoutput dddbms__db ch
  smoutput '>> ddtblx'
  smoutput ddtblx__db ch

  smoutput '>> ddtbl'
  if. sqlresok__db rc=. ddtbl__db ch do.
    sh=. sqlres__db rc
    smoutput '>> ddcnm'
    smoutput ddcnm__db sh
    smoutput '>> ddfet'
    smoutput ddfet__db sh,_1
  end.
  smoutput '>> ddcol'
  smoutput 'tdata' ddcol__db ch
  smoutput '>> ddsel 5 rows'
  if. sqlresok__db rc=. ch ddsel__db~ 'select * from tdata' do.
    sh=. sqlres__db rc
    smoutput '>> ddcolinfo'
    smoutput ddcolinfo__db sh
    smoutput '>> ddcnm'
    ddcnm__db sh
    smoutput '>> ddfet'
    smoutput ddfet__db sh,5
    smoutput '>> ddend'
    ddend__db sh
  end.
  smoutput '>> ddfch'
  if. sqlresok__db rc=. ch ddsel__db~ 'select * from tdata' do.
    sh=. sqlres__db rc
    smoutput ddfch__db sh,_1
    ddend__db sh
  end.
  smoutput '>> ddfch__db raw format'
  if. sqlresok__db rc=. ch ddsel__db~ 'select * from tdata' do.
    sh=. sqlres__db rc
    smoutput r=. _2&ddfch__db sh,_1
    ddend__db sh
  end.
  smoutput '>> ddttrn'
  smoutput ddttrn__db ch
  smoutput '>> ddtrn'
  ddtrn__db ch
  smoutput '>> ddttrn'
  smoutput ddttrn__db ch
  smoutput '>> update inside transaction'
  if. -.sqlresok__db rc=. ch ddsql__db~ 'update tdata set SALARY=SALARY + 100' do.
    smoutput dderr__db''
  else.
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
  end.
  smoutput '>> value changed in transaction'
  if. sqlresok__db rc=. ch ddsel__db~ 'select * from tdata' do.
    sh=. sqlres__db rc
    smoutput ddfet__db sh,3
    ddend__db sh
  else.
    smoutput dderr__db''
  end.
  smoutput '>> abort transaction'
  ddrbk__db ch
  smoutput '>> ddttrn'
  smoutput ddttrn__db ch

  smoutput '>> value restored'
  if. sqlresok__db rc=. ch ddsel__db~ 'select * from tdata' do.
    sh=. sqlres__db rc
    smoutput ddfet__db sh,3
    ddend__db sh
  else.
    smoutput dderr__db''
  end.

  smoutput '>> ddtrn'
  ddtrn__db ch
  smoutput '>> ddttrn'
  smoutput ddttrn__db ch
  smoutput '>> update inside transaction'
  ch ddsql__db~ 'update tdata set SALARY=SALARY + 1'
  smoutput '>> commit transaction'
  ddcom__db ch
  smoutput '>> ddttrn'
  smoutput ddttrn__db ch
  if. sqlresok__db rc=. ch ddsel__db~ 'select * from tdata' do.
    sh=. sqlres__db rc
    smoutput ddfet__db sh,3
    ddend__db sh
  end.
  smoutput '>> dderr'
  ch ddsql__db~ 'update NOTABLE set status=status + 1'
  smoutput dderr__db''

  smoutput '>> ddins'
  len=. has_sqlite3_extversion_jddsqlite_{1e4 1e6
  if. integerdate do.
    data=. ((len, 5)$'A''BCDEF');((len, 1)$'MF');((len, 4)$'E101E201');((len, 1)$19910213);((len, 1)$20081203);(,. 1+i.len)
  else.
    if. UseDayNo do.
      data=. ((len,5)$'A''BCDEF');((len,1)$'MF');((len,4)$'E101E201');(len$todayno 1991 2 13);(len$DateTimeNull__db,todayno 2008 12 3);(,.len$NumericNull__db,len)
    else.
      data=. ((len,5)$'A''BCDEF');((len,1)$'MF');((len,4)$'E101E201');((len,10)$'1991-02-13');((len,10)$'2008-12-03');(,.len$NumericNull__db,len)
    end.
  end.
  smoutput '>> begin insert ', (":len), ' rows'
  if. sqlresok__db rc=. ch ddins__db~ 'select NAME, SEX, DEPT, DOB, DOH, SALARY from tdata';data do.
    smoutput '>> finish insert ', (":len), ' rows'
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
    if. sqlresok__db rc=. ch ddsel__db~ 'select count(*) from tdata where DOH is null or DOH=', integerdate{::'''2008-12-03''';'20081203' do.
      sh=. sqlres__db rc
      smoutput ddfet__db sh,_1
      ddend__db sh
    else.
      smoutput dderr__db''
    end.
    if. sqlresok__db rc=. ch ddsel__db~ 'select * from tdata where DOH is null or DOH=', integerdate{::'''2008-12-03''';'20081203' do.
      sh=. sqlres__db rc
      smoutput ddfet__db sh,5
      ddend__db sh
    else.
      smoutput dderr__db''
    end.
    if. sqlresok__db rc=. ch ddsel__db~ 'select * from tdata where DOH is null or DOH=', integerdate{::'''2008-12-03''';'20081203' do.
      sh=. sqlres__db rc
      smoutput ddfch__db sh,5
      ddend__db sh
    else.
      smoutput dderr__db''
    end.
  else.
    smoutput dderr__db''
  end.

  smoutput '>> bulk insert with ddparm'
  ch ddsql__db~ 'delete from tdata where DOH=', integerdate{::'''2008-12-03''';'20081203'
  smoutput '>> begin insert ', (":len), ' rows'
  sql=. 'insert into tdata(NAME, SEX, DEPT, DOB, DOH, SALARY) values (?,?,?,?,?,?)'
  if. _1~: rc=. ch ddparm__db~ sql;((3#SQL_VARCHAR),(2#integerdate{::SQL_TYPE_DATE,SQL_INTEGER),SQL_DOUBLE);data do.
    smoutput '>> finish insert ', (":len), ' rows'
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
    if. sqlresok__db rc=. ch ddsel__db~ 'select count(*) from tdata where DOH=', integerdate{::'''2008-12-03''';'20081203' do.
      sh=. sqlres__db rc
      smoutput ddfet__db sh,_1
      ddend__db sh
    else.
      smoutput dderr__db''
    end.
  else.
    smoutput dderr__db''
  end.

  smoutput '>> bulk insert with ddsparm'
  ch ddsql__db~ 'delete from tdata where DOH=', integerdate{::'''2008-12-03''';'20081203'
  smoutput '>> begin insert ', (":len), ' rows'
  sql=. 'insert into tdata(NAME, SEX, DEPT, DOB, DOH, SALARY) values (?,?,?,?,?,?)'
  if. _1~: rc=. ch ddsparm__db~ sql;data do.
    smoutput '>> finish insert ', (":len), ' rows'
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
    if. sqlresok__db rc=. ch ddsel__db~ 'select count(*) from tdata where DOH=', integerdate{::'''2008-12-03''';'20081203' do.
      sh=. sqlres__db rc
      smoutput ddfet__db sh,_1
      ddend__db sh
    else.
      smoutput dderr__db''
    end.
  else.
    smoutput dderr__db''
  end.

  smoutput '>> update with ddsparm'
  if. sqlresok__db rc=. ch ddsparm__db~ 'update tdata set PHOTO=? where NAME=?';(>'photo1';'photo2';'photo3');< (>'Abbott K';'Nobody';'Denny D') do.
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
    if. sqlresok__db rc=. ch ddsel__db~ 'select * from tdata where photo is not null' do.
      sh=. sqlres__db rc
      smoutput ddfet__db sh,_1
    else.
      smoutput dderr__db''
    end.
  else.
    smoutput dderr__db''
  end.

  smoutput '>> ddsparm box'
  if. sqlresok__db rc=. ch ddsparm__db~ 'update tdata set PHOTO=? where NAME=?';('photo4';'photo5';'photo6');< ('Blamire J';'somebody';'Gordon E') do.
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
    if. sqlresok__db rc=. ch ddsel__db~ 'select * from tdata where photo is not null' do.
      sh=. sqlres__db rc
      smoutput ddfet__db sh,_1
      ddend__db sh
    else.
      smoutput dderr__db''
    end.
  else.
    smoutput dderr__db''
  end.

  smoutput '>> ddsparm long binary'
  photo1=. a.{~ ?1e5#256
  photo2=. a.{~ ?5e6#256
  if. sqlresok__db rc=. ch ddsparm__db~ 'update tdata set PHOTO=? where NAME=?';(photo1;photo2);< (>'Abbott K';'Denny D') do.
    smoutput '>> ddcnt'
    smoutput ddcnt__db ch
    if. sqlresok__db rc=. ch ddsel__db~ 'select NAME,PHOTO from tdata where NAME in (''Abbott K'',''Denny D'') order by NAME' do.
      sh=. sqlres__db rc
      photo=. 1{"1 a=. sqlres__db ddfet__db sh,_1
      ddend__db sh
      smoutput 'photo # ',": #&> photo
      if. photo -: photo1;photo2 do.
        smoutput 'long binary test ok'
      else.
        smoutput 'long binary test failed'
      end.
    else.
      smoutput dderr__db''
    end.
  else.
    smoutput dderr__db''
  end.

  smoutput '>> dddis'
  dddis__db ch

  smoutput '>> finish'
else.
  smoutput '>> cannot open ',f
end.
destroy__db''
EMPTY
)

testdb''
