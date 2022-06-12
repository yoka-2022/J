coclass 'jprint'
coinsert^:IFQT 'qtprinter'

PATHSEP=: '/'
PRINTERFONT=: (('Linux';'Darwin';'Android';'Win') i. <UNAME){:: 'Serif 12' ; '"Lucida Grande" 12' ; (IFQT{::'Serif 12';'"Droid Serif" 12') ; '"Courier New" 12'
P2UPFONT=: (('Linux';'Darwin';'Android';'Win') i. <UNAME){:: 'Serif 7.5 bold' ; '"Lucida Grande" 7.5 bold' ; (IFQT{::'Serif 7.5 bold';'"Droid Serif" 7.5 bold') ; '"Courier New" 7.5 bold'
PRINTOPT=: ''
DEFFONT=: (('Linux';'Darwin';'Android';'Win') i. <UNAME){:: 'Serif 10 bold' ; '"Lucida Grande" 10 bold' ; (IFQT{::'Serif 10 bold';'"Droid Serif" 10 bold') ; '"Courier New" 10 bold'
DEFFONT2=: (('Linux';'Darwin';'Android';'Win') i. <UNAME){:: 'Serif 7 bold' ; '"Lucida Grande" 7 bold' ; (IFQT{::'Serif 7 bold';'"Droid Serif" 7 bold') ; '"Courier New" 7 bold'
TOPM=: 0.4
BOTM=: 0.75
FOOTM=: 0.4
LEFTM=: 0.5
RIGHTM=: 0.5
TOPM2=: 0.015
BOTM2=: 0.03
LEFTM2=: 0.015
FOOTM2=: 0.015
SCALE=: 1 1
OFFSET=: 0 0
CF=: 1
CFFONT=: (('Linux';'Darwin';'Android';'Win') i. <UNAME){:: 'Monospace 12' ; 'Monaco 12' ; (IFQT{::'monospace 12';'"Droid Sans Mono" 12') ; '"Lucida Console" 12'
bufinit=: 3 : 0
PCMDS=: ''
PCMD=: i.0 2
)
buf=: 3 : 0
if. y -: 'page' do.
  PCMDS=: PCMDS,<PCMD
  PCMD=: i. 0 2
else.
  PCMD=: PCMD, y
end.
empty''
)
bufexe=: 3 : 0
for_d. y do.
  'f v'=. d
  f~v
end.
)
vfont=: 3 : 0
glzfont TFONT=: y
buf 'glzfont';TFONT
)
vlines=: 3 : 0
buf 'glzlines';<. , SCALE * OFFSET + _2]\y
)
vpage=: 3 : 0
buf 'page'
)
vpen=: 3 : 0
buf 'glzpen';y
)
vtext=: 3 : 0
buf 'glztext';unibox y
)
vtextcolor=: 3 : 0
if. #y do.
  clr=. 256 256 256 #: y
else.
  clr=. 0 0 0
end.
buf 'glzrgb';clr
buf 'glztextcolor';''
)
vtextxy=: 3 : 0
buf 'glztextxy';<. SCALE * OFFSET + y
)
printit=: 4 : 0
bufinit''
PRINTFILES=: ''
PRINTFILE=: ''
P2UP=: 0
PRINTOPT=: 0 pick x
select. 1 pick x
case. 'print' do.
  PRINTTXT=: y
  printform 0
case. 'print2' do.
  PRINTTXT=: y
  P2UP=: 1
  printform 0
case. 'printfile' do.
  getprintfiles y
  printform 1
case. 'printfile2' do.
  getprintfiles y
  P2UP=: 1
  printform 1
end.
)
printclose=: 3 : 0
if. #PRINTFILES do.
  PRINTFILE=: 0 pick PRINTFILES
  PRINTFILES=: }. PRINTFILES
else.
  codestroy''
end.
)
printform=: 3 : 0
prnfile=. y
if. 0 e. $opt=. P2UP printopts PRINTOPT do. 1 return. end.
'Ascii Cols Filename Fit Font Header Footer Orient Ruler Tab Printer Printfile'=: opt
opt=. ; dq each '';Printer;Printfile
if. Orient do.
  glzorientation 2=Orient
end.
SCALE=: (glzqwh 6)%(1440 * glzqwh 2)
if. prnfile do.
  glzstartdoc''
  getcf''
  dirty=. 0
  while. #PRINTFILES do.
    PRINTFILE=: 0 pick PRINTFILES
    PRINTFILES=: }. PRINTFILES
    if. 0= printinit1`printinit2@.(1=P2UP)'' do.
      while. #PCMDS do.
        if. dirty do. glznewpage'' end.
        bufexe 0 pick PCMDS
        PCMDS=: }. PCMDS
        dirty=. 1
      end.
    end.
  end.
  glzenddoc''
else.
  glzstartdoc''
  getcf''
  if. 0= printinit1`printinit2@.(1=P2UP)'' do.
    dirty=. 0
    while. #PCMDS do.
      if. dirty do. glznewpage'' end.
      bufexe 0 pick PCMDS
      PCMDS=: }. PCMDS
      dirty=. 1
    end.
  end.
  glzenddoc''
end.
codestroy''
)
place=: 3 : 0

'just xywh font foreclr dummy lspace txt'=. y

rws=. #txt
if. 0=rws do. return. end.

if. #font do.
  vfont font
end.

vtextcolor foreclr
'x y width height'=. xywh
lspace=. {.lspace,1

hite=. 20* lspace*{.glzqtextmetrics''

len=. <.height%hite
pos=. x,y

rws=. rws <. len
res=. (<x,y,width,height-hite*rws) , <len }. txt
txt=. len {. txt

while. #txt do.

  line=. ,0 pick txt
  txt=. }.txt

  if. 0=#line do.
    pos=. pos+0,hite
    continue.
  end.
  if. -. 1 e. , E.&line &> TAGS do.

    if. just=0 do.
      vtextxy rnd0 pos
      vtext line

    elseif. just=1 do.
      wid=. 20* {. glzqextent line
      vtextxy rnd0 pos+(width-wid),0
      vtext line

    elseif. just=2 do.
    elseif. just=3 do.
      wid=. 20* {. glzqextent line
      vtextxy rnd0 pos+-:(width-wid),0
      vtext line
    end.
  else.
    'num wid'=. width fitline line
    vfont TFONT
    if. just=0 do.
      placeline pos;line

    elseif. just=1 do.

      placeline (pos+(width-wid),0);line

    elseif. just=2 do.
      blk=. +/line=' '

      if. (1<blk) *. wid >: width*3r4 do.
        opt=. (width-wid),blk
        opt placeline pos;line
      else.
        placeline pos;line
      end.

    elseif. just=3 do.
      placeline (pos+-:(width-wid),0);line

    end.

  end.
  pos=. pos+0,hite

end.

vtextcolor''
res
)
placeline=: 3 : 0
0 0 placeline y
:
'pos txt'=. y
'pad blk'=. x

while. #txt do.
  b=. +./ E.&txt &> TAGS
  ndx=. b i. 1
  bit=. ndx{.txt
  if. blk do.
    num=. +/bit=' '
    space=. >.pad*num%blk
    pad=. pad-space
    blk=. blk-num
  else.
    space=. 0
  end.

  vtextxy rnd0 pos
  vtext bit
  pos=. pos + 2{. space + 20* {. glzqextent bit

  txt=. ndx}.txt
  if. 0=#txt do. break. end.

  'tag txt'=. taketag txt

  vfont TFONT changetag tag
  b=. +./ E.&txt &> TAGS

end.
)
printinit2=: 3 : 0

if. #PRINTFILE do.
  Filename=: PRINTFILE , ' ' , (pfsize PRINTFILE) ,' ' , pfstamp PRINTFILE
  PRINTTXT=: fread PRINTFILE
end.

fascii=. boxascii^:Ascii

vfont Font

HEADER=: > 0 printheader Header ; Filename

'wid len'=. <. 1440* glzqwh 2
'hite width'=. 20* 0 6 { glzqtextmetrics ''

inlen=. len * 1 - TOPM2 + BOTM2
rws=. <. inlen % hite * 1.2
leftm0=. wid * LEFTM2
leftm1=. leftm0 + -:wid
ftrow=. len * 1 - FOOTM2
irws=. (len * TOPM2) + inlen * (i.rws) % rws
n=. #HEADER
rws=. rws - n

Cols=: <. width %~ -: wid * 1 - 3*LEFTM2
RULE=. fascii > printruler Cols

LHDR=: rnd0 leftm0 ,. n {. irws
RHDR=: rnd0 leftm1 ,. n {. irws
LTXT=: rnd0 leftm0 ,. n }. irws
RTXT=: rnd0 leftm1 ,. n }. irws
LFTR=: rnd0 leftm0 , ftrow
RFTR=: rnd0 leftm1 , ftrow
LINE=: rnd0 , (-:wid) ,. len * (1 - TOPM2) , FOOTM2

PAGE=: 0
foot=: (((Cols - 30) {.!.' ' Footer) , tstamp '')&stamp

dat=. cleanup PRINTTXT
dat=. fascii dat
dat=. Tab xtab dat
dat=. FF cutopen dat
dat=. Cols fold each ucp each dat
dat=. ((4 * Ruler) - rws)&(<\) each dat
TRWS=: rws
TCLS=: Cols
TEXT=: > ;dat
if. Ruler do.
  TEXT=: RULE ,"2 TEXT
end.
print2pages''
0
)
print2pages=: 3 : 0
bufinit''
PAGE=: 0
cmd=. (vtext@[ vtextxy)"1
while. #TEXT do.
  mat=. TRWS, TCLS
  vfont TFONT
  vpen 5 0
  vlines LINE
  if. #HEADER do. HEADER cmd LHDR end.
  (mat {. {.TEXT) cmd LTXT
  TEXT=: }.TEXT
  PAGE=: >:PAGE
  (foot PAGE) cmd LFTR
  if. #TEXT do.
    if. #HEADER do. HEADER cmd LHDR end.
    (mat {. {.TEXT) cmd RTXT
    TEXT=: }.TEXT
    PAGE=: >:PAGE
    (foot PAGE) cmd RFTR
  end.
  vpage''
end.
)
printn=: 4 : 0
if. 0 e. $y do. return. end.
if. 2 <: #$y do. mat=. y
else. mat=. ];._2 y,LF -. _1{.y
end.
cat=. ,&,.&.|:
txt=. ''
rws=. 72
cls=. _2+<. 161 % x
mat=. '  ' ,"1 ~ cls{."1 mat
pad=. 10
while. #mat do.
  blk=. rws {. mat
  ndx=. 1 i:~ blk *./ .= ' '
  if. ndx>rws-pad do. blk=. ndx{.blk end.
  txt=. txt,<rws{.blk
  mat=. mat }.~ #blk
end.
txt=. _4 (cat each /)\ txt
txt=. _2 (}."1) each txt
prn=. ; (,&FF) on  }. on , on (LF&,.) each txt
font=. P2UPFONT_jprint_
('land;font ',font) print prn
)
printinit1=: 3 : 0
if. #PRINTFILE do.
  Filename=: PRINTFILE , ' ' , (pfsize PRINTFILE) ,' ' , pfstamp PRINTFILE
  PRINTTXT=: fread PRINTFILE
end.

txt=. cleanup PRINTTXT
if. 0 e. $txt do. 1 return. end.
fascii=. boxascii ^: Ascii
vfont Font

getprintpage''
'x y width height'=. getframe LEFTM , TOPM , (-RIGHTM) , -FOOTM

HEADER=: > width printheader Header ; Filename

hite=. 20* {.glzqtextmetrics ''

fb=. 1440 * BOTM - FOOTM
headhite=. hite * #HEADER
texthite=. height - fb + headhite
HEADBOX=: x , y , width , headhite
TEXTBOX=: x , (y + headhite) , width , texthite
FOOTBOX=: x , (y + height - fb), width , hite
txt=. fascii txt
txt=. Tab xtab txt
if. Fit do. txt=. topara txt end.
txt=. FF cutopen txt
TEXT=: width wraptext each txt
TEXTP=: ''
if. Ruler do.
  if. (2 = 3!:0 y) *. 1 < # $y do.
    cls=. {: $y
  else.
    cls=. >./ ; #&> each TEXT
  end.
  RULE=: fascii each printruler cls
  RULEBOX=: x , (y + headhite), width , 3 * hite
  TEXTBOX=: x , (y + headhite + 3 * hite) , width , texthite - 3 * hite
else.
  RULE=: RULEBOX=: ''
end.
LFTR=: (-.0 e. $Footer) # < ,: ,Footer
rfoot=: [: < [: ,: (tstamp '')&stamp
printpages''
0
)
printpages=: 3 : 0
bufinit''
PAGE=: 0
while. (#TEXT) + #TEXTP do.
  PAGE=: >: PAGE
  if. #TEXTP do.
    printpage''
  else.
    if. #TEXT do.
      TEXTP=: 0 pick TEXT
      TEXT=: }.TEXT
      printpage''
    end.
  end.
end.
0
)
printpage=: 3 : 0
vfont TFONT
place 0 ; HEADBOX ; '' ; '' ; '' ; 1 ; <HEADER
place 0 ; RULEBOX ; '' ; '' ; '' ; 1 ; <RULE
'pos p1'=. place 0 ; TEXTBOX ; '' ; '' ; '' ; 1 ; <TEXTP
place 0 ; FOOTBOX ; '' ; '' ; '' ; 1 ; <LFTR
place 1 ; FOOTBOX ; '' ; '' ; '' ; 1 ; <rfoot PAGE
vpage ''
TEXTP=: p1
)
pfsize=: 3 : 0
}. ;',' , each |. _3 <@|.\ |. ":fsize y
)
pfstamp=: 3 : 0
'y r'=. split fstamp y
y=. (":y) , ;_2&{.@('0'&,)@":&> r
n=. 'xxxx-xx-xx xx:xx:xx'
y (I. n = 'x') } n
)
printopts=: 4 : 0

std=. PRINTOPT
y=. std,((0<#std)#';'),y

if. x do.
  font=. P2UPFONT
else.
  font=. PRINTERFONT
end.

filename=: ''
printer=: ''
printfile=: ''
header=. ''
footer=. ''
cols=. 80
tab=. 4

def=. 0: = 4!:0@<

if. #y do.
  opts=. dltb each ';' cutopen y
  opts=. ((tolower@{. ; }.@}.)~ i.&' ')&> opts
  try. ({."1 opts)=. {:"1 opts
  catch.
    sminfo 'Print';'Error in print options' return.
  end.
end.

fit=. def 'fit'
ruler=. def 'ruler'

if. def 'ascii' do.
  ascii=. {. 1 ". ascii,' 1'
else.
  ascii=. 0
end.

if. 2 = 3!:0 cols do.
  cols=. {. 80 ". cols
end.

if. 2 = 3!:0 tab do.
  tab=. {. 4 ". tab
end.

if. P2UP do.
  orient=. 2
else.
  if. +./ def&> 'port' ; 'portrait' do.
    orient=. 1
  elseif. +./ def&> 'land' ; 'landscape' do.
    orient=. 2
  elseif. 1 do.
    orient=. 0
  end.
end.

if. def 'fontsize' do.
  defsize=. ". >1 { boxfont font
  font=. font changefont defsize ". fontsize
end.

ascii ; cols ; filename ; fit ; font ; header ; footer ; orient ; ruler ; tab ; printer ; printfile
)
printruler=: 3 : 0
j=. >.0.2 * len=. y
'a b c'=. 1 4 7 { , 9!:6 ''
r=. len #"1 ,. c , ' ' , a
i=. }.5 * i.j
r=. b (<0 2 ; 0 , i) } r
r=. '0' (<1 ; 0) } r
if. len > 5 do.
  r=. (3 ": ,.i) (<1 ; i -/ 2 1 0) } r
end.
<"1 r
)
printfilename=: 4 : 0
f=. y
f2=. ''
tag=. '...'
if. x printnofit f do.
  ndx=. (_21 }. f) i: ' '
  f2=. (ndx + 1) }. f
  f=. dltb ndx {. f
  while. x printnofit f do.
    f=. (3 * tag -: 3 {. f) }. f
    f=. (PATHSEP = {.f) }. f
    f=. tag , f }.~ f i. PATHSEP
  end.
end.
f ; f2
)
printnofit=: 4 : 0
if. x do. w=. {.x fitline y else. w=. Cols end.
w < #y
)
printheader=: 4 : 0
'hdr fnm'=. y
'fnm fnm2'=. x printfilename fnm
r=. ''
if. #hdr do. r=. hdr ; '' end.
r , (boxxopen fnm) , (boxxopen fnm2) , boxxopen (0 < #fnm) # ' '
)
qprinter=: 3 : 0
''
)
TAB=: 9 { a.
TAGS=: '<b>';'</b>';'<i>';'</i>'
TAGIDS=: ;:'bold nobold italic noitalic'
BLACK=: 0
WHITE=: <:2^24

deb=: #~ (+. 1: |. (> </\))@(' '&~:)
dlb=: }.~ =&' ' i. 0:
dltb=: #~ [: (+./\ *. +./\.) ' '&~:
dtb=: #~ [: +./\. ' '&~:
round=: [ * [: <. 0.5"_ + %~
rnd0=: <.@(0.5&+)
tolist=: }.@;@:(LF&,@,@":&.>)
boxascii=: 3 : 0
y=. ": y
to=. '+++++++++|-'
fm=. 9!:6 ''
(to,a.) {~ (fm,a.) i. y
)
unibox=: 3 : 0
fm=. (16+i.11) { a.
msk=. y e. fm
if. -. 1 e. msk do. utf8 y return. end.
to=. 4 u: 9484 9516 9488 9500 9532 9508 9492 9524 9496 9474 9472
y=. ucp y
msk=. y e. fm
un=. to {~ fm i. msk#y
utf8 un (I.msk) } y
)
boxfont=: 3 : 0
font=. ' ',y
b=. (font=' ') > ~:/\font='"'
a: -.~ b <;._1 font
)
changefont=: 4 : 0
font=. ' ',x
b=. (font=' ') > ~:/\font='"'
font=. a: -.~ b <;._1 font
opt=. y
if. 0=L. opt do. opt=. cutopen ":opt end.
opt=. a: -.~ (-.&' ' @ ":) each opt
num=. _1 ~: _1 ". &> opt
if. 1 e. num do.
  font=. ({.num#opt) 1} font
  opt=. (-.num)#opt
end.
ayes=. ;:'bold italic'
noes=. ;:'nobold noitalic'
font=. font , opt -. noes
font=. font -. (noes e. opt)#ayes
}: ; ,&' ' each ~. font
)
changetag=: 4 : 0
x changefont TAGIDS {~ TAGS i. boxopen y
)
cleanup=: 3 : 0
y=. flatten y
toJ ' ' (I. y e. 27{a.) } y
)
cutpara=: 3 : 0
txt=. topara y
txt=. txt,(LF ~: {:txt)#LF
b=. (}.b,0) < b=. txt=LF
b <;._2 txt
)
dq=: 3 : 0
y=. ": y
if. '"' ~: {. y do.
  '"',(y #~ >: y = '"'),'" '
else.
  y,' '
end.
)
emptymatrix=: ,:`empty @. (0:=#)
fitchars=: 4 : 0

fit=. *&CF @ *&20 @ {. @ glzqextent @ ({.&y)
max=. #y
avg=. 20* 5{ glzqtextmetrics''

try=. max <. >. x % avg
if. x > fit try do.
  while.
    (max > try) *. x >: fit >: try
  do. try=. >: try end.
else.
  while.
    (0 < try) *. x < fit try
  do. try=. <: try end.
end.
try, fit try
)
fitline=: 4 : 0
wid=. x
txt=. y
b=. +./ E.&txt &> TAGS
if. -. 1 e. b do.
  num=. wid fitwords txt
  if. 0={.num do.
    num=. wid fitchars txt
  end.
  return.
end.
tnum=. tlen=. 0

while. 1 do.
  ndx=. b i. 1

  if. ndx>0 do.
    'num len'=. wid fitwords ndx{.txt

    tnum=. tnum + num
    tlen=. tlen + len

    if. num<ndx do.
      if. 0=tnum do.
        wid fitchars txt
      else.
        tnum,tlen
      end.
      return.
    end.

    wid=. wid-len
    txt=. ndx}.txt

    if. (wid <: 0) +. 0 = #txt do. tnum,tlen return. end.
  end.

  'tag txt'=. taketag txt
  tnum=. tnum + #;tag

  TFONT=: TFONT changetag tag
  glzfont TFONT

  if. 0=#txt do. tnum,tlen return. end.

  b=. +./ E.&txt &> TAGS

end.
)
fitwords=: 4 : 0
ndx=. 0, I. (y=' '),1 1
fit=. *&CF @ *&20 @ {. @ glzqextent @ ({.&y) @ ({&ndx)
max=. _2+#ndx
avg=. 20* 5{ glzqtextmetrics''

try=. max <. 1 i.~ ndx >: x % avg

if. x > len=. fit try do.
  while.
    (max > try) *. x >: trylen=. fit >: try
  do. len=. trylen [ try=. >: try end.

else.
  while.
    (0 < try) *. x < len=. fit try
  do. try=. <: try end.
end.
(try{ndx) , len

)
flatten=: 3 : 0
dat=. ": y
if. 2 > #$dat do. return. end.
dat=. 1 1}. _1 _1}. ": <dat
}: (,|."1 [ 1,.-. *./\"1 |."1 dat=' ')#,dat,.LF
)
fold=: 4 : 0
dat=. toJ y
dat=. <;._2 dat,LF #~ LF ~: {: dat
dat=. ({.!.' '~ 1&>.@#) &.> dat
> ,&.> / (-x) (x&{.) \ &.> dat
)
getdevmode=: 3 : 0
''
)
getfile=: 3 : 0
try. {."1 getscripts_j_ y
catch. <^:(< -: {:@;~) y
end.
)
getframe=: 3 : 0
'px py pw ph j j wid hit'=. ,PRINTPAGE
'x y w h'=. 1440 * y
x=. 0 >. x - px
if. w <: 0 do. w=. wid + w - 0 >. x - px end.
w=. w <. pw - x
y=. 0 >. y - py
if. h <: 0 do. h=. hit + h - 0 >. y - py end.
h=. h <. ph - y
x,y,w,h
)
getpos=: 3 : 0
0 getpos y
:
'px py pw ph j j wid hit'=. ,PRINTPAGE
if. x=0 do.
  'x y'=. 1440 * y
  if. x >: 0 do.
    x=. pw <. 0 >. x - px
  else.
    x=. 0 >. wid + x - px
  end.
  if. y >: 0 do.
    y=. 0 >. ph - 0 >. y - py
  else.
    y=. ph - 0 >. hit + y - py
  end.
  x,y
else.
  'x y'=. y
  x=. px + x
  y=. py + ph - y + h
  1440 %~ x,y
end.
)
getprintfiles=: 3 : 0
y=. getfile y
for_f. y do.
  try. 1!:1 f
  catch.
    empty sminfo 'print' ; 'file not found: ' , >f return.
  end.
  PRINTFILES=: PRINTFILES,y
end.
empty ''
)
getprintpage=: 3 : 0
'w h'=. <. 1440 * glzqwh 2
'l t r b'=. <. 1440 * glzqmargins 2
PRINTPAGE=: (l,t,(w-l+r),(h-t+b)),:0 0,w,h
)
preview=: 3 : 0
glwindowext (<0;2 3){PRINTPAGE
wd'pshow'
glpaint ''
)
printers=: }: @ wdqprinters
removetag=: 3 : 0
r=. ''
while. 1 e. b=. +./ E.&y &> TAGS do.
  ndx=. b i. 1
  r=. r,ndx{.y
  y=. ndx}.y
  y=. (>:y i.'>')}.y
end.
r=. r,y
)

stamp=: 4 : 0
x,'  Page ',":y
)
taketag=: 3 : 0
tag=. ''
txt=. y
while. '<' = 1{.txt do.
  ind=. >:txt i.'>'
  tag=. tag,<ind {.txt
  txt=. ind }. txt
end.
tag;txt
)
topara=: 3 : 0
if. 0=#y do. '' return. end.
if. 1<#$y do. y return. end.
txt=. toJ y
b=. txt=LF
c=. b +. txt=' '
b=. b > (0,}:b) +. }.c,0
txt=. ' ' (b#i.#b) } txt
return.
b=. b *: 0,}:b=. txt=LF
txt=. b#txt
)
tstamp=: 3 : 0
y=. <.y,(0=#y)#6!:0 ''
'y m d h n s'=. 6{.y
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
f=. _2: {. '0'&,@":
t=. (2":d),(m{mth),(":y),;f&.>h,n,s
r=. 'xx xxx xxxx xx:xx:xx'
t (I. r='x') } r
)
xtabline=: 4 : 0
r=. y
while.
  i=. >: r i. TAB
  i <: #r
do.
  r=. ((x * >. i % x){.!.' ' }:i{.r) , i}.r
end.
)
xtab=: 4 : 0
if. -. TAB e. y do. y return. end.
y=. <;._2 y,(LF ~: {:y)#LF
b=. TAB e.&> y
tolist (x xtabline each b#y) (I. b)} y
)
wrappara=: 4 : 0
if. 0=#y do. <a: return. end.
r=. ''
txt=. y
while. #txt do.
  len=. {.x fitline txt
  line=. len{.txt
  txt=. len}.txt
  txt=. (' '=1{.txt)}.txt
  r=. r,<line
end.
<r
)
wraptext=: 4 : 0
if. 0 e. $y do. '' return. end.
if. 2=#$y do. ;/y return. end.
txt=. toJ y
if. -. LF e. txt do. >x wrappara txt return. end.
txt=. txt,(LF~:{:txt)#LF
txt=. ;x&wrappara ;._2 txt
)

getcf=: 3 : 0
glzfont CFFONT
CF=: 72% {. glzqextent 10#'m'
)
doprint=: 1 : 0
cocurrent conew 'jprint'
('';m) printit y
:
cocurrent conew 'jprint'
(x;m) printit y
)
print=: 'print' doprint
print2=: 'print2' doprint
printfile=: 'printfile' doprint
printfile2=: 'printfile2' doprint
