NB. Copyright 2019, Jsoftware Inc.  All rights reserved.
coclass 'jd'

NB. Each folder which is handled by JD contains files:
NB. jdclass giving the class without the leading 'jd'
NB. (folder, database, table, column).
NB. state giving global state (optional).
NB. If no class is present, it is assumed to be a folder.

NB. Each class must contain the globals:
NB. CLASS        the name of the class
NB. CHILD        the class of contained objects
NB. STATE        global nouns to save to file
NB. open         called on Open
NB. testcreate   called like create with LOCALE as left argument;
NB.                fails if create would fail
NB. create       called (with arguments) on Create
NB. close        called on Close and Drop

NB. jd provides:
NB. NAME
NB. PATH
NB. PARENT       the locale of the parent object
NB. LOCALE       the locale of this object
NB. CHILDREN     the locales of children
NB. NAMES        the names of children
NB.
NB. Open         open a jd folder (locale must be child of current locale)
NB. Close        close a folder, but leave the data
NB. Create       create a child object
NB. Drop         remove a child object (by locale)
NB. readstate    read state from the filesystem
NB. writestate   write state to the filesystem
NB.

NB. jd is special because it cannot be instantiated.
NB. Thus it only contains a few of the globals.

PATH=:NAME=: ''
CHILDREN=: ".'CHILDREN'
NAMES=: ".'NAMES'

NB. =========================================================
NB. utilities
NB. y is the name of this locale
NB. assumes later steps will do writestate
Init=: 3 : 0
PATH=: termSEP PATH__PARENT, NAME =: >y
LOCALE=: coname''
CHILDREN=: NAMES=: ''
)

NewChild =: 3 : 0
loc =. cocreate ''
coinsert__loc CHILD
coinsert__loc PARENT__loc =: LOCALE
CHILDREN =: CHILDREN,loc
NAMES=: NAMES,<NAME__loc=:y
loc
)
RemoveChild =: 3 : 0
CHILDREN =: CHILDREN-.y
NAMES=: NAMES-.<NAME__y
)

colcheck=: 3 : 0
if. Tlen~:countdat__y'' do.
 if. -.fexist '/jdrepair',~dbpath DB do. jddamage 'Tlen wrong for col ',NAME__y,' in table ',NAME__PARENT__y end.
end.
)

getlocx=: 3 : 'c=. (NAMES i. <y){CHILDREN' NB. get col locale - do not map

NB. get locale and open table children and map column files
getloc=: 3 : 0
if. -.'/'e.,>y do.
 if. '.' e. y=.,>y do. 4 :'getloc__y x'/ LOCALE ,~ |.<;._1'.',y return. end.
 if. (,'^') -: y do. PARENT return. end.
end.
ind=. NAMES i. <y
if. (ind=#NAMES) do.
 if. 0=nc<'Tlen' do.
  i=. ({."1 TEMPCOLS)i.<NAME,'_',y
  if. i<#TEMPCOLS do. {:i{TEMPCOLS return. end.
 end.
 throw 'Not found: ',(2}.>CHILD),' ',,":y
end.
c=. ind{CHILDREN
if. 'jdtable'-:;CLASS__c do.
 NB. if. Tlen__c=__ do.
 if. openflag__c do.
  openflag__c=: 0
  openallchildren__c ''
  index__c=: getloc__c 'jdindex'
 end. 
elseif. 'jdcolumn'-:;CLASS__c do. NB. cols map as required
 if. _1=nc {.MAP__c,each <'__c' do. NB. assumed mapped if defined
   mapcolfile__c"0 MAP__c
   opentyp__c ''
   if. JDMT=MTRO_jmf_ do. mtmfixcount c end.
 end.
 colcheck c
end.
c
)

NB. y is name
ischildfolder=: 3 : 0
f=. PATH,(;y),'/jdclass'
if. fexist f do. t=. 'jd',LF-.~jdfread f else. t=. 'jdfolder' end.
t-:;CHILD
)

openallchildren =: 3 : 0
for_name. dirsubdirs PATH do.
  Open^:ischildfolder name
end.
)

NB. unmap everything in path
unmappath=: 3 : 0
msk=. PATH ([ -: #@[ {. ])&.> 1 {"1 mappings_jmf_
jdunmap &> msk # {."1 mappings_jmf_
)

NB. =========================================================
NB. y is a name, which extends PATH.
Open=: 3 : 0
y=.,>y
if. NAMES e.~ <y do. getloc y return. end.
if. -.ischildfolder y do.
  msg =. 'n1 cannot be opened by c2 n2'
  throw msg rplc 'n1';y;'c2';CHILD,'n2';NAME
end.
loc =. NewChild y
Init__loc y
readstate__loc ''
open__loc ''
loc
)

NB. y is (NAME;dat) where dat will be passed to create
NB. x gives class of created object (default CHILD).
Create=: 3 : 0
'name dat' =. ({. (,<) }.) y =. boxopen y
if. ischildfolder name do.
  throw 'Create: ',name,' already exists as a child of ',NAME
end.
LOCALE testcreate__CHILD dat
dcreate PATH,name=.,name

NB. folder links locate cols on particular paths
if. 'column'-:2}.>CHILD do.
 links=. jdfread 'links.txt',~jdpath''
 if. -.links-:_1 do.
  links=. >bd2 each <;._2 links
  link=. jpath PATH,name
  a=. _3{.<;.2 PATH,name,'/'
  s=. <}:;1}.a
  i=. s i.~ {."1 links
  if. i<#links do.
   j=. ;{:i{links
   j=. j,'/'#~'/'~:{:j
   target=. jpath j,}:;a
   jdcreatefolder target
   if. IFWIN do.
    t=. '"',link,'" "',target,'"'
    t=. 'mklink /D /J ',hostpathsep t
    jddeletefolder link
    shell t NB. wndows does junction between folders
   else.
    n=. '"',target,'" "',link,'"'
    t=. 'ln -s ',n
    jddeletefolder link
    shell t
   end.
   6!:3^:(2~:ftypex link) 0.1 NB. sometimes required in windows so next test works
   'link failed' assert (2=ftypex) link
  end.
 end.
end.

(2}.>CHILD) jdfwrite PATH,name,'/jdclass'
loc =. NewChild name
Init__loc name
create__loc dat
loc
)

NB. STATE is written when changed  - it should not need to be written on close
validate_close_state=: 3 : 0
if. #STATE__y do.
 if. -.(3!:2 jdfread PATH__y,'jdstate')-:pack__y STATE__y do.
  echo 'close writestate bad: ',(;CLASS__y),' ',NAME__y
  echo 3!:2 jdfread PATH__y,'jdstate'
  echo STATE__y
  echo pack__y STATE__y
 end.
end.
)

NB. y is a locale, or an unboxed name.
Close=: 3 : 0
y =. getloc^:(0=L.) y
if. y -.@e. CHILDREN do.
  throw 'Close: ',NAME__y,' is not a child of ',NAME
end.
for_loc. CHILDREN__y do. Close__y loc end.
RemoveChild y
NB. validate_close_state y
close__y ''
codestroy__y ''
EMPTY
)

NB. same arguments as Close
Drop=: 3 : 0
if. 0=L.y do.
  if. (<y=.,y)-.@e.NAMES do.
    if. ischildfolder y do. jddeletefolder PATH,y end.
    return.
  end.
   y=. getlocx y NB. avoid unnecessary map and derived error
end.
path =. PATH__y
Close y
jddeletefolder path
EMPTY
)

readstate=: 3 : 0
if. #STATE do.
 cnts_readstate_jd_=: >:cnts_readstate_jd_
 pdef@:(3!:2)^:(_1&(-.@-:)) jdfread PATH,'jdstate'
end.
)

NB. state not written for RO db
writestate=: 3 : 0
if. (JDMT=MTRW_jmf_)*.#STATE do.
 cnts_writestate_jd_=: >:cnts_writestate_jd_
 (3!:1 pack STATE) jdfwrite PATH,'jdstate'
end.
)

cutcoldefs=: a: -.~ [: (<@deb;._2~ e.&(',',LF)) ,&LF
cutsp=: i.&' ' ({.;dlb@}.) ]

duplicate_assert=: 3 : 0
EDUPLICATE assert 0=#FECOL_jd_=: ;{.(1<+/y =/ y)#y
)

notjd_assert=: 3 : 0
ENOTJD assert 0=#FECOL_jd_=: ;{.y#~bjdn y
)

unknown_assert=: 3 : 0
EUNKNOWN assert 0=#FECOL_jd_=: ;{.y
)

missing_assert=: 3 : 0
EMISSING assert 0=#FECOL_jd_=: ;{.y
)

