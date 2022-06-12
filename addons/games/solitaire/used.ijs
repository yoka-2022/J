NB. J Solitaire
NB. This is the used script for J Solitaire.
NB. This script creates a form to allow the user to choose an old game

NB. Creating the form
USED=: 0 : 0
pc used nosize owner;pn "Winning Games";
bin v;
cc ccstatic static;cn "The list below are games which have been won. Please select a game from the list if you would like to play a game that can be won.";
bin h;
cc ccstatic static;cn "Winner's Name";
cc s2 static right;cn "Wins | Losses";
bin z;
minwh 312 370;cc name listbox;
bin h;
cc no button;cn "Cancel";
cc play button;cn "Play The Game!";
bin zz;
pas 6 6;pcenter;
rem form end;
)

NB. Running the Form and setting the listbox
used_run=: 3 : 0
wd USED
NB. initialize form here
NameList=: ''
GameList=: ''
if. fexist PATHRECORD do.
  FILE=. ''
  FILE=. }. 'b' fread PATHRECORD
  for_a. i. # FILE do.
    WINS=. 0 { ".(- <:(#> a{ FILE ) - ((> a { FILE) i: ';')) {. > a { FILE
    LOSES=. (1 { ".(- <:(#> a{ FILE ) - ((> a { FILE) i: ';')) {. > a { FILE) - WINS
    NameList=: NameList,' "', (18 {. (((> a { FILE) i: ':') {. > a { FILE)),'     ',(":WINS),' | ',(":LOSES),'"',LF
    GameList=: GameList, <(>:(> a { FILE) i: ':') }. (- (#> a{ FILE ) - ((> a { FILE) i: ';')) }. > a { FILE
  end.
  if. NameList -: '' do.
    wdinfo 'J Solitaire';'Sorry, there are no Old Games.'
    wd 'psel used'
    wd 'pclose'
    return.
  end.
  wd 'setfont name ',FIXFONT
  wd 'set name items ', ,NameList
else.
  wdinfo 'J Solitaire';'Sorry, there are no Old Games.'
  wd 'psel used'
  wd 'pclose'
  return.
end.
wd 'pshow;'
)

NB. Close the form
used_close=: 3 : 0
wd'pclose'
)

NB. Loads the selected game (if a game is selected) and updates the games stats
used_play_button=: 3 : 0
if. 1 <: # name do.
  deal ". > ((<;.2 NameList) i. < ' "',name,'"',LF ) { GameList
  b=. ((<;.2 NameList) i. < ' "',name,'"',LF )
  FILE=. }. 'b' fread PATHRECORD
  FILE=. (<((- (#> b{ FILE ) - ((> b { FILE) i: ';')) }. > b { FILE),';',": 0 1 + ".(- <:(#> b{ FILE ) - ((> b { FILE) i: ';')) {. > b { FILE) b } FILE
  FILE=. (0 { 'b' fread PATHRECORD), FILE
  FILE=. ;FILE, each <LF
  FILE fwrite PATHRECORD
  draw''
  wd 'psel used'
  wd 'pclose'
end.
)

NB. This verb is tied to the cancel button and closes the form without loading the game
used_no_button=: 3 : 0
wd 'psel used'
wd 'pclose'
)

NB. This triggers the play control when a game selection in the listbox is double-clicked
used_name_button=: 3 : 0
used_play_button''
)
