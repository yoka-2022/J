require 'socket'
coclass 'rserve'
coinsert 'jsocket'
ALPH0=: {.a.
DELIM=: '$'
EMPTY=: i.0 0
NULL=: 'NULL'
ax=: a.&i.
atoi=: 256 #. a. i. |.
av=: ({&a.)`] @. (2 = 3!:0)
info=: sminfo @ ('rserve'&;)
isboxed=: 0 < L.
ischar=: 2 = 3!:0
isinteger=: (-: <.) ::0:
ismatrix=: 2 = #@$
isopen=: 0 = L.
isnan=: 128!:5
isscalar=: 0 = #@$
rflip=: _2 |: |.@$ $ ,
round=: [ * [: <. 0.5 + %~
roundint=: <. @ +&0.5
roundup=: [ * [: >. %~
symsort=: ,~ '10' {~ '`'={.
toscalar=: {.^:((,1) -: $)
debugq=: 13!:17
debugss=: 13!:3
debugstack=: 13!:13
errormsg=: 3 : 0
if. y e. ERRNUM do.
  'Error code: ',(":y),' ',(ERRNUM i. y) pick ERRMSG
else.
  'Status code: ',":y
end.
)
fixscalar=: 3 : 0
if. isnan y do. y return. end.
if. (1=#y) *: 2 > #$y do. y return. end.
r=. > {. y
if. -. r -: y do. fixscalar r end.
)
fixxp=: 3 : 0
select. {. y
case. XP_VEC do.
  1 + i.-1{y
case. do.
  y
end.
)
prefixnames=: 4 : 0
if. (isopen y) >: ismatrix y do.
  ,:x;<y return.
end.
if. 0=#x do. y return. end.
nms=. {."1 y
if. 0 e. ischar &> nms do.
  ,:x;<y return.
end.
nms=. (<x) ,each DELIM ,each nms
nms,.{:"1 y
)
rhdrlen=: 3 : 0
if. 64 < 128 | ax {. y do.
  8,8 + atoi }. 8 {. y
else.
  4,4 + atoi }. 4 {. y
end.
)
rtyplen=: 4 : 0
typ=. x
len=. y
if. len < 2^24 do.
  (av typ),3 {. 2 ic len
else.
  av (typ + XT_LARGE),|.(7#256)#:len
end.
)
tag2sym=: 3 : 0
ndx=. >:+:i.<.-:#y
('`' ,each ndx { y) ndx} y
)
throw=: 3 : 0
msg=. y
if. ischar msg do. msg=. 1;msg end.
thrown=: msg
info 1 pick msg
throw.
)
wrapcmd=: 4 : 0
cmd=. 2 ic x
cnt=. #y
len=. 4 roundup cnt
cmd,(2 ic len),(8#ALPH0),y,(len-cnt)$ALPH0
)
wraplen=: 4 : '(x rtyplen #y),y'
NAR=: (162 7 0 0 0 0 240 127,:162 7 0 0 0 0 248 127) { a.
NAJ=: 2 fc __
CMD_login=: 1
CMD_voidEval=: 2
CMD_eval=: 3
CMD_shutdown=: 4
CMD_openFile=: 16
CMD_createFile=: 17
CMD_closeFile=: 18
CMD_readFile=: 19
CMD_writeFile=: 20
CMD_removeFile=: 21
CMD_setSEXP=: 32
CMD_assignSEXP=: 33
CMD_setBufferSize=: 129
DT_INT=: 1
DT_CHAR=: 2
DT_DOUBLE=: 3
DT_STRING=: 4
DT_BYTESTREAM=: 5
DT_SEXP=: 10
DT_ARRAY=: 11
DT_LARGE=: 64
j=. <;._2 (0 : 0)
0  nil = NULL
1  symbols
2  lists of dotted pairs
3  closures
4  environments
5  promises: [un]evaluated closure arguments
6  language constructs (special lists)
7  special forms
8  builtin non-special forms
9  "scalar" string type (internal only)*/
10 logical vectors
13 integer vectors
14 real variables
15 complex variables
16 string vectors
17 dot-dot-dot object
18 make "any" args work.
19 generic vectors
20 expressions vectors
21 byte code
22 external pointer
23 weak reference
24 raw bytes
99 Closure or Builtin or Special
)

INTNAM=: 3 }. each j
INTNUM=: 0 ". &> 2 {. each j
XP_VEC=: _2147483648
XT_NULL=: 0
XT_INT=: 1
XT_DOUBLE=: 2
XT_STR=: 3
XT_LANG=: 4
XT_SYM=: 5
XT_BOOL=: 6

XT_S4=: 7

XT_VECTOR=: 16
XT_LIST=: 17
XT_CLOS=: 18
XT_SYMNAME=: 19
XT_LIST_NOTAG=: 20
XT_LIST_TAG=: 21
XT_LANG_NOTAG=: 22
XT_LANG_TAG=: 23
XT_VECTOR_EXP=: 26
XT_VECTOR_STR=: 27

XT_ARRAY_INT=: 32
XT_ARRAY_DOUBLE=: 33
XT_ARRAY_STR=: 34
XT_ARRAY_BOOL_UA=: 35
XT_ARRAY_BOOL=: 36
XT_RAW=: 37
XT_ARRAY_CPLX=: 38

XT_UNKNOWN=: 48
XT_LARGE=: 64
XT_HAS_ATTR=: 128
j=. <;._2 (0 : 0)
65 auth. failed or auth. requested but no login came.
66 connection closed or broken packet killed it
67 unsupported/invalid command
68 some parameters are invalid
69 R-error occurred, usually followed by connection shutdown
70 I/O error
71 attempt to perform file Read/Write on closed file
72 access denied to command
73 unsupported command
74 unknown command
75 incoming packet is too big.
76 the requested object is too big
77 out of memory. the connection is usually closed after this
80 session is still busy
81 unable to detach session
)

ERRMSG=: 3 }. each j
ERRNUM=: 0 ". &> 2 {. each j
FORCETHROW=: 0
throwtext=: ''
throw=: 3 : 0
throwtext_rserve_=: y
if. FORCETHROW < debugq'' do.
  debugss ; (2 }. {."1 debugstack'') ,each <' *:*,'
  info y
else.
  smoutput y
  throw.
end.
)
sData=: <'`data'
sDim=: <'`dim'
sNames=: <'`names'
sRownames=: <'`row.names'
sexp2map=: 3 : 0
IfAtt=: 0
dat=. att2map y
if. -.IfAtt do. return. end.
ndx=. 1 i.~ 0 = # &> {."1 dat
dat /: symsort each {."1 dat
)
att2map=: 3 : 0
if. -. ismatrix y do.
  if. isopen y do.
    y
  else.
    att2map each y
  end.
  return.
end.

'att dat'=. att2map each ,y

if. -. ismatrix att do.
  if. 2 | #att do.
    throw 'Invalid attribute list - not in value;attribute pairs'
  end.
  att=. _2 |.\ att
end.
ndx=. ({."1 att) i. sDim
if. ndx<#att do.
  dim=. 1 pick ndx{att
  att=. (<<<ndx){att
  dat=. _2 |: (|. dim) $ dat
  if. 0=#att do. dat return. end.
end.
IfAtt=: 1
ndx=. ({."1 att) i. sNames
if. ndx = #att do.
  res=. ,:'`data';<dat
else.
  nms=. boxxopen 1 pick ndx { att
  att=. (<<<ndx) { att
  if. 1 = #nms do.
    dat=. boxxopen dat
  else.
    if. (#nms) ~: #dat do.
      throw 'Names do not match data' return.
    end.
    if. 0 = L. dat do.
      dat=. <"_1 dat
    end.
  end.
  res=. i.0 2
  res=. res,;nms prefixnames each dat
end.
ndx=. ({."1 att) i. sRownames
if. ndx < #att do.
  ind=. <ndx;1
  att=. (<fixxp >ind{att) ind}att
end.
att=. flatt att
res,att
)
flatt=: 3 : 0
msk=. 2 = #@$ &> {:"1 y
if. -. 1 e. msk do. y return. end.
((-.msk) # y),;flatt1"1 msk # y

)
flatt1=: 3 : 0
'nam mat'=. y
<nam prefixnames mat
)
rdclose=: disconnect
rdopen=: connect
rdcmd=: 3 : 0
send CMD_voidEval wrapcmd toRs ,y
rread 0
)
rdget=: 3 : 0
send CMD_eval wrapcmd toRs ,y
rread 2
)
rdgetexp=: 3 : 0
send CMD_eval wrapcmd toRs ,y
rread 1
)
rdgetraw=: 3 : 0
send CMD_eval wrapcmd toRs ,y
read ''
)
rdset=: 4 : 0
if. isopen x do.
  x=. deb x
  if. -. ' ' e. x do.
    x rdset1 y return.
  end.
  x=. <;._1 ' ',x
end.
if. -. (1=L.y) *. (1 >: #$y) *. (#x)=#y do.
  throw 'Names and values do not match for rdset'
end.
x rdset1 each y

)
rdset1=: 4 : 0

if. y -: NULL do.
  rdcmd x,'=',NULL return.
end.

t=. toRs x
s=. $y
if. 1 < #s do.
  y=. |:"2 y
  s=. |. 1 A. s
end.
send CMD_setSEXP wrapcmd t,toRx ,y
rread 0
if. 1 < #s do.
  s=. }. ; ',' ,each ": each s
  rdcmd 'dim(',x,')=c(',s,')'
end.
EMPTY
)
DEFPORT=: 6311
RSK=: 0
MAX=: 50000
WAIT=: 20000
SKACCEPT=: SKLISTEN=: ''
sd_accept=: 3 : '0 pick sd_check sdaccept y'
sd_bind=: 3 : 'sd_check sdbind y'
sd_reset=: 3 : 'sdcleanup $0'
sd_gethostbyname=: 3 : 'sd_check sdgethostbyname y'
sd_listen=: 3 : 'sd_check sdlisten y'
sd_recv=: 3 : '0 pick sd_check sdrecv y'
sd_select=: 3 : 'sd_check sdselect y'
sd_send=: 4 : 'sd_check x sdsend y'
sd_socket=: 3 : '0 pick sd_check sdsocket $0'
sd_connect=: 3 : 0
res=. sdconnect y
if. 0 pick res do.
  throw 'Unable to connect: ',sderror res
else.
  EMPTY
end.
)
gethostip=: 3 : 0
if. 3 = +/ '.' = y do.
  txt=. ' ' (bx '.' = y) } y
  if. 4 = # (0 ". txt) -. 0 do. 2;y return. end.
end.
sd_gethostbyname y
)
readsk=: 3 : 0
r=. read1 y
if. 8 > #r do. return. end.
len=. 16 + _2 ic 4 5 6 7 { r
while. len > #r do.
  txt=. read1 y
  if. 0=#txt do.
    throw 'read'
  else.
    r=. r, txt
  end.
end.
r
)
read1=: 3 : 0
if. y e. 0 pick sd_select y;'';'';WAIT do.
  sd_recv y,MAX
else.
  ''
end.
)
sd_check=: 3 : 0
if. 0 = 0 pick y do. }. y return. end.
throw 'socket ',sderror y
)
sendsk=: 4 : 0
dat=. x
whilst. #dat do.
  blk=. (MAX <. #dat) {. dat
  blk sd_send y,0
  dat=. MAX }. dat
end.
EMPTY
)
connect=: 3 : 0
if. RSK e. SOCKETS do. 1 return. end.
RSK_rserve_=: 0
'host port'=. 2 {. boxopen y
HOST=: host, (0=#host)#'localhost'
PORT=: {. port,DEFPORT
if. -. HOST -: 'localhost' do.
  HOSTIP=: 2;'127.0.0.1'
else.
  HOSTIP=: gethostip HOST
end.
RSK_rserve_=: sd_socket''
sd_connect RSK;HOSTIP,<PORT
res=. read1 RSK
if. -. 'RsrvQAP1' -: (, 0 8 +/ i.4) { res do.
  throw 'Rserve connect returns ',res
  0 return.
end.
att=. _4 [\ (12 }. res) -. '-',CRLF
if. #att do.
  throw 'Rserve connect returns: ',,res,.LF
  0 return.
end.
1
)
disconnect=: 3 : 0
if. RSK e. SOCKETS do.
  sdclose :: ] RSK
end.
RSK_jsocket_=: 0
)
read=: 3 : 'readsk RSK'
send=: 3 : 0
if. connect'' do.
  y sendsk RSK
end.
EMPTY
)
rread=: 3 : 0
res=. read''
if. 1 ~: ax 2 { res do.
  throw 'invalid response flag'
end.
rc=. _1 ic 2 {. res
if. rc = 1 do.
  if. y=0 do. EMPTY return. end.
  res=. 16 }. res
  if. 0 = #res do.
    throw 'no data'
  end.
  typ=. ax {. res
  res=. toJ res
  if. y=2 do.
    sexp2map res
  end.
else.
  throw errormsg ax 3 { res
end.
)
toJ=: 3 : 0
typ=. ax {. y
'hdr len'=. rhdrlen y
dat=. hdr }. len {. y
select. typ
case. DT_INT do.
  toscalar _2 ic dat
case. DT_STRING do.
  toscalar (dat i. ALPH0) {. dat
case. DT_BYTESTREAM do.
  toscalar dat
case. DT_SEXP do.
  toJX dat
case. do.
  throw 'unknown type: ',":typ
end.
)
toJX=: 3 : 0
typ=. ax {. y
if. typ >: 128 do.
  toJXatt y
else.
  fixscalar toJXval y
end.
)
toJXatt=: 3 : 0
typ=. av 128 | ax {. y
len=. 8 + _2 ic (5 6 7 { y), ALPH0
att=. 4 }. len {. y
dat=. len }. y
dat=. (typ,3 {.2 ic #dat),dat
,:toJX each att;dat
)
toJXlist=: 3 : 0
r=. ''
dat=. y
while.
  #dat do.
  'hdr len'=. rhdrlen dat
  r=. r, <toJX len {. dat
  dat=. len }. dat
end.
r
)
toJXval=: 3 : 0
typ=. ax {. y
dat=. 4 }. y
select. typ
case. XT_NULL do.
  NULL
case. XT_STR do.
  (dat i. ALPH0) {. dat
case. XT_LANG do.
  toJXlist dat
case. XT_SYM do.
  s: <toJXval dat
case. XT_BOOL do.
  ax {. dat
case. XT_S4 do.
  throw 'XT_S4 type not yet supported'
case. XT_VECTOR do.
  toJXlist dat
case. XT_LIST do.
  toJXlist dat
case. XT_CLOS do.
  toJX dat
case. XT_SYMNAME do.
  (dat i. ALPH0) {. dat
case. XT_LIST_NOTAG do.
  toJXlist dat
case. XT_LIST_TAG do.
  tag2sym toJXlist dat
case. XT_LANG_NOTAG do.
  toJXlist dat
case. XT_LANG_TAG do.
  tag2sym toJXlist dat
case. XT_VECTOR_EXP do.
  toJXlist dat
case. XT_VECTOR_STR do.
  toJXlist dat
case. XT_ARRAY_INT do.
  _2 ic dat
case. XT_ARRAY_DOUBLE do.
  _2 fc toNAJ dat
case. XT_ARRAY_STR do.
  (dat=ALPH0) <;._2 dat
case. XT_ARRAY_BOOL_UA do.
  ax dat
case. XT_ARRAY_BOOL do.
  (_2 ic 4 {.dat) $ ax 4 }. dat
case. XT_RAW do.
  len=. _2 ic 4 {. dat
  len {. 4 }. dat
case. XT_ARRAY_CPLX do.
  _2 j. /\ _2 fc toNAJ dat
case. XT_UNKNOWN do.
  typ=. (INTNUM i. {. _2 ic dat) pick INTNAM
  'Type unsupported by Rserve: ',typ
case. do.
  throw 'unknown extended type: ',":typ
end.
)
toNAJ=: 3 : 0
n=. NAR e.~ d=. _8 [\ y
if. -. 1 e. n do. y return. end.
,NAJ (I.n) } d
)
toRb=: 3 : 0
(DT_BYTESTREAM{a.),(3 {. 2 ic #y),y
)
toRi=: 3 : 0
(DT_INT{a.),(3 {. 2 ic len),2 ic y
)
toRs=: 3 : 0
dat=. y,ALPH0
len=. 4 roundup cnt=. #dat
(DT_STRING{a.),(3 {. 2 ic len),dat,(len-cnt)#ALPH0
)
toRx=: 3 : 'DT_SEXP wraplen toRx1 y'
toRx1=: 3 : 0
if. 1 < #$y do.
  throw 'data should be scalar or vector'
end.
if. L. y do.
  throw 'boxed not yet' return.
end.
typ=. 3!:0 y

typ=. typ + 3*1=typ
select. typ
case. 1 do.
  XT_ARRAY_BOOL wraplen ,(y{a.),"0 1[255 255 255{a.
case. 2 do.
  dat=. y,ALPH0
  len=. 4 roundup cnt=. #dat
  (XT_STR{a.), (3 {. 2 ic cnt), dat,(len-cnt)#ALPH0
case. 4 do.
  XT_ARRAY_INT wraplen 2 ic y
case. 8 do.
  XT_ARRAY_DOUBLE wraplen 2 fc y
case. 16 do.
  throw 'complex data not supported by Rserve'
case. do.
  throw 'datatype ',(":typ),' not supported by Rserve'
end.
)
cocurrent 'z'

Rclose=: rdclose_rserve_
Ropen=: rdopen_rserve_
Rcmd=: rdcmd_rserve_

Rget=: 3 : 0
rdget_rserve_ y
:
x Rmap_rbase_ rdget_rserve_ y
)

Rgetexp=: rdgetexp_rserve_
Rset=: rdset_rserve_
Rreset=: Ropen@Rclose

cocurrent 'base'
