NB. multimedia lab viewer - video processes (even when closed) remain until jqt has exited. 
coerase <'qtvideo' 
coclass 'qtvideo'

NB. === initializing verb must be run at the beginning of each video lab
init =: 3 : 0
'WM HM'=: _300 + 2 3 { ". wd 'qscreen' NB. establish screen width and height with 300 px allowance    
'SS MS LS'=:  ": each VM=: WM>400 800 1600
VM=:<: 2<.+/VM NB. sets viewmode to default or smaller if required
'WM HM'=:>VM {400 225;800 450;1600 900 NB. set medium size as default
i. 0 0
)

NB. === verb used to show video if new or resized - y argument is code for video
display=: 3 : 0
 multimedia_close ''  NB. close previous video forms in case a previous video lab was running
 VIDEO=:y  NB. used in reset to rerun display
 wd MULTIMEDIA NB. opens new video form at the beginning of each section
 wd 'setp wh ',":80 60 + WM , HM
 wd 'set s visible ',SS,';set m visible ',MS,';set l visible ',LS,';'
 wd 'set mm html <iframe width="',(":WM) ,'" height="',(":HM) ,'" src="https://www.youtube.com/embed/',VIDEO,'?feature=oembed;rel=0&amp;"></iframe> ;set mm visible;set mm minwh ',(":WM , HM),' ;'
 wd 'set ',(VM{'sml'),' value 1;'
 wd 'pshow;'
)

NB. === form description
MULTIMEDIA=: 0 : 0
pc multimedia ptop;pmove 0 0 _1 _1;
bin h;
bin vs;
cc SI static;cn "Size";set _ tooltip "Available Display Sizes";
maxwh 20 20;cc s radiobutton;cn "";set s visible;set _ tooltip "Extra small screen size - 400 X 225";set _ wh 20 20;
maxwh 20 20;cc m radiobutton group;cn "";set m visible;set _ tooltip "Medium screen size - 800 X 450";set _ wh 20 20;
maxwh 20 20;cc l radiobutton group;cn "";set l visible;set _ tooltip "Large screen size - 1600 X 900";set _ wh 20 20;
bin sz;
cc mm webview;set mm sizepolicy expanding;
bin z;
)

NB. === button controls
multimedia_s_button=: 3 : 'display VIDEO[VM=:0[''WM HM''=:400 225'
multimedia_m_button=: 3 : 'display VIDEO[VM=:1[''WM HM''=:800 450'
multimedia_l_button=: 3 : 'display VIDEO[VM=:2[''WM HM''=:1600 900'


NB. === close button inserts dummy html to stop media audio
multimedia_close=: 3 : 'if. wdisparent ''multimedia'' do.  wd ''psel multimedia;set mm html <div></div> ;pclose;'' end.' NB. Select video form, stop and close  
