%MAIN PROGRAM TO RUN

%________________________________________________________________

/*
 Date Started: 2023-12-18
 Date Finished: 2023-01-22
 Name: Arushi Phadte
 File Name: FPT Pacman Menu.t
 Description of Program: Pac-Man Game with a username function, menu, help menu, music, and high scores
 */

/*
 Planning Process
 1. menu (buttons + text fields)
 2. game (collisions, eating, score)
 3. intro design (graphics)
 4. help
 5. extra additions
 - usernames
 - high scores
 - current date
 - music
 - Classes for the procedures
 */

/*
 Ideas from the Turing Website to use
 - getch,getchar,Input.KeyDown
 - Locate (x,y)
 - mousewhere (x,y,press)
 Resource that was used
 - Turing Tutorials - Collision Detection
 */

import GUI

%classes
include "FPT Pacman Game.t"

%variables
var winID : int
var newuser : boolean := false
var musicstate : int := 0
var stream, paststream, pbstream : int
var username : string
var usercheck : boolean := false
var numofusers : int
var pastusername : array 0 .. 100 of string
var nameTextField : int   % The Text Field IDs.
%fonts
var smallfont : int := Font.New ("mono:9")
var fontL : int := Font.New ("mono:110:bold")
var fontM : int := Font.New ("mono:70:bold")
var fontS : int := Font.New ("mono:40:bold")

%procedures for menu
forward proc INTRO
forward proc USERNAME
forward proc MENU
forward proc GAME
forward proc HELP
forward proc EXIT
forward proc MUSIC

%procedures for textfiles
forward proc textfilechecks
forward proc textfileinput

%checks the data in the text files when the program starts
body proc textfilechecks

    %gets the values of the usernames
    open : paststream, "usernames.txt", get
    for K : 0 .. 100
	get : paststream, pastusername (K)
	exit when eof (paststream)
    end for
    close : paststream

    %gets the values of the personal best scores
    open : pbstream, "personalbests.txt", get
    for H : 0 .. 100
	get : pbstream, scores (H)
	numofusers := H
	exit when eof (pbstream)
    end for
    close : pbstream

    %gets the high score of the program
    open : stream, "highscore.txt", get
    get : stream, highscore
    close : stream
end textfilechecks

%inputs the data before the program ends for the usernames, personal bests, and high score
body proc textfileinput
    open : paststream, "usernames.txt", put
    for L : 0 .. numofusers
	put : paststream, pastusername (L)
    end for
    close : paststream

    open : pbstream, "personalbests.txt", put
    for C : 0 .. numofusers
	put : pbstream, scores (C)
    end for
    close : pbstream

    open : stream, "highscore.txt", put
    put : stream, highscore
    close : stream
end textfileinput

%music proc when music button is pressed
body proc MUSIC
    musicstate := musicstate + 1
    if musicstate = 2 then
	musicstate := 0
    end if
    if musicstate = 1 then %music is on
	fork menumusic
    elsif musicstate = 0 then %music is off
	Music.PlayFileStop %stops music
    end if
end MUSIC

%intro screen after running program
body proc INTRO
    textfilechecks
    winID := Window.Open ("graphics:600;400")
    Text.ColorBack (black) %intro screen visuals
    cls
    %title
    Font.Draw ("P", 50, 260, fontL, white)
    Font.Draw ("A", 150, 280, fontM, white)
    Font.Draw ("C", 220, 290, fontS, white)
    Font.Draw ("-", 285, 290, fontS, white)
    Font.Draw ("M", 350, 290, fontS, white)
    Font.Draw ("A", 410, 280, fontM, white)
    Font.Draw ("N", 480, 260, fontL, white)
    %shapes
    drawfilloval (300, 180, 66, 66, 41)
    drawfilloval (300, 180, 56, 56, 42)
    drawfilloval (300, 180, 46, 46, 43)
    drawfilloval (300, 180, 38, 38, 44)
    drawfilloval (300, 180, 30, 30, 68)
    drawfilloval (300, 180, 22, 22, white)
    drawfilloval (430, 180, 9, 9, 40)
    drawfilloval (430, 180, 6, 6, 63)
    drawfilloval (430, 180, 3, 3, white)
    drawfilloval (530, 180, 9, 9, 41)
    drawfilloval (530, 180, 6, 6, 42)
    drawfilloval (530, 180, 3, 3, 67)
    drawfilloval (170, 180, 9, 9, 53)
    drawfilloval (170, 180, 6, 6, 52)
    drawfilloval (170, 180, 3, 3, white)
    drawfilloval (70, 180, 9, 9, 37)
    drawfilloval (70, 180, 6, 6, 84)
    drawfilloval (70, 180, 3, 3, white)
    var start : int := GUI.CreateButton (200, 50, 200, "Press to Start!", USERNAME)
    GUI.SetColor (start, 68)     %change the colour of the buttons
    loop
	exit when GUI.ProcessEvent
    end loop
end INTRO

%goes to this proc when you press enter on the username text field
procedure enter (y : string)
    username := GUI.GetText (nameTextField)
    %check if the username is a past username
    for D : 0 .. numofusers
	if username = pastusername (D) then     %name is found in the selected row
	    usercheck := true
	    drawfillbox (50, 25, 750, 90, 68)
	    Font.Draw ("Welcome Back " + username + "!", 270, 70, main, 41)
	    rownum := D     %number of the row that the usename was found in
	    exit
	end if
    end for

    if usercheck = false then %if the username has not been used before
	if username = "" then %name has to have some character
	    GUI.SetText (nameTextField, "")
	    drawfillbox (50, 25, 750, 90, 68)
	    Font.Draw ("Invalid Username.", 300, 70, main, 41)
	elsif index (Str.Lower (username), "fuck") >= 1 or index (Str.Lower (username), "shit") >= 1 or index (Str.Lower (username), "bitch") >= 1 then %no swear words
	    GUI.SetText (nameTextField, "")
	    drawfillbox (50, 25, 750, 90, 68)
	    Font.Draw ("No Swear Words.", 300, 70, main, 41)
	elsif index (username, " ") >= 1 then %no spaces
	    GUI.SetText (nameTextField, "")
	    drawfillbox (50, 25, 750, 90, 68)
	    Font.Draw ("No Spaces.", 300, 70, main, 41)
	elsif length (username) = 1 then %no single character inputs
	    GUI.SetText (nameTextField, "")
	    drawfillbox (50, 25, 750, 90, 68)
	    Font.Draw ("No Single Character.", 300, 70, main, 41)
	else %put the username into the array if it is allowed
	    pastusername (numofusers + 1) := username
	    drawfillbox (50, 25, 750, 90, 68)
	    Font.Draw ("Welcome " + username + "!", 300, 70, main, 41)
	    rownum := numofusers + 1
	    numofusers := numofusers + 1
	    usercheck := true

	    %putting a personal best of 0 for the new username
	    scores (rownum) := "0"
	end if
    end if
end enter

%gets the username
body proc USERNAME
    Window.Close (winID)
    winID := Window.Open ("graphics:800;200")
    %visuals
    colourback (black)
    cls
    drawfillbox (30, 15, 770, 185, 42)
    drawfillbox (40, 20, 760, 180, 43)
    drawfillbox (50, 25, 750, 175, 68)
    %displays text fields and labels
    nameTextField := GUI.CreateTextFieldFull (400, 120, 250, "", enter, GUI.INDENT, 0, 0)
    var namelabel : int := GUI.CreateLabelFull (370, 115, "Username : ", 0, 0, GUI.RIGHT, unique)
    Font.Draw ("CASE SENSITIVE", 220, 100, smallfont, black)

    %exits the username loop when a valid username has been entered
    loop
	exit when GUI.ProcessEvent
	exit when usercheck = true
    end loop

    delay (2500)
    MENU
end USERNAME

%proc for enter the main menu
body proc MENU
    Window.Close (winID)
    winID := Window.Open ("graphics:600;400")
    View.Set ("offscreenonly")
    Text.ColorBack (16)
    loop
	cls
	exit when GUI.ProcessEvent

	%draws the three buttons: exit, play game, and help
	var ext : int := GUI.CreateButton (60, 90, 120, "QUIT", EXIT)
	var game : int := GUI.CreateButton (60, 290, 120, "Play Game?", GAME)
	var help : int := GUI.CreateButton (60, 190, 120, "HELP", HELP)

	%draws the music button
	var music : int := GUI.CreateButton (10, 360, 20, "MUSIC", MUSIC)

	%music display state
	if musicstate = 1 then
	    Font.Draw ("ON", 87, 370, smallfont, white)
	elsif musicstate = 0 then
	    Font.Draw ("OFF", 87, 370, smallfont, white)
	end if

	%writes out the current date
	Font.Draw (Time.Date, 460, 20, smallfont, white)

	%if the mouse is on top of any of the buttons, a different visual is shown
	Mouse.Where (XX, YY, button)
	if XX >= 60 and XX <= 180 and YY >= 90 and YY <= 110 then

	    GUI.SetColor (ext, 56)     %change the colour of the buttons

	    %spotlight
	    var q : array 1 .. 4 of int := init (340, 400, 560, 320)
	    var w : array 1 .. 4 of int := init (0, 0, 400, 400)
	    drawfillpolygon (q, w, 4, 56)

	    %ghost
	    drawfilloval (420, 205, 70, 70, white)
	    drawfilloval (420, 205, 66, 66, 39)
	    drawfilloval (420, 205, 52, 52, 38)
	    drawfilloval (420, 205, 46, 46, 37)
	    drawfilloval (420, 205, 38, 38, 60)
	    drawfilloval (420, 205, 30, 30, 84)
	    drawfilloval (420, 205, 22, 22, white)

	    %tear
	    drawfilloval (450, 180, 6, 6, 53)
	    var B : array 1 .. 3 of int := init (444, 456, 450)
	    var H : array 1 .. 3 of int := init (180, 180, 200)
	    drawfillpolygon (B, H, 3, 53)

	    %star
	    drawfillstar (340, 340, 380, 300, white)

	elsif XX >= 60 and XX <= 180 and YY >= 190 and YY <= 210 then

	    GUI.SetColor (help, 60)     %change the colour of the buttons

	    %spotlight
	    var o : array 1 .. 4 of int := init (360, 400, 520, 280)
	    var u : array 1 .. 4 of int := init (0, 0, 400, 400)
	    drawfillpolygon (o, u, 4, 60)

	    %ghost
	    drawfilloval (420, 205, 70, 70, white)
	    drawfilloval (420, 205, 66, 66, 55)
	    drawfilloval (420, 205, 52, 52, 54)
	    drawfilloval (420, 205, 46, 46, 53)
	    drawfilloval (420, 205, 38, 38, 52)
	    drawfilloval (420, 205, 30, 30, 100)
	    drawfilloval (420, 205, 22, 22, white)

	    %stars
	    drawfillstar (270, 300, 320, 350, white)
	    drawfillstar (375, 130, 345, 100, white)

	elsif XX >= 60 and XX <= 180 and YY >= 290 and YY <= 310 then

	    GUI.SetColor (game, 55) %change the colour of the buttons

	    %spotlight
	    var o : array 1 .. 4 of int := init (390, 420, 480, 230)
	    var u : array 1 .. 4 of int := init (0, 0, 400, 400)
	    drawfillpolygon (o, u, 4, 55)

	    %pacman
	    drawfilloval (360, 180, 70, 70, white)
	    drawfilloval (360, 180, 66, 66, 41)
	    drawfilloval (360, 180, 56, 56, 42)
	    drawfilloval (360, 180, 46, 46, 43)
	    drawfilloval (360, 180, 38, 38, 44)
	    drawfilloval (360, 180, 30, 30, 68)
	    drawfilloval (360, 180, 22, 22, white)
	    var J : array 1 .. 3 of int := init (350, 450, 450)
	    var D : array 1 .. 3 of int := init (180, 210, 300,)
	    drawfillpolygon (J, D, 3, 55)
	    Draw.ThickLine (350, 180, 395, 235, 5, white)
	    Draw.ThickLine (350, 180, 423, 200, 5, white)

	    %apple
	    drawfilloval (460, 280, 34, 34, white)
	    Draw.ThickLine (460, 280 + 25, 455, 280 + 40, 9, white)
	    drawfilloval (475 + 5, 300 + 5, 28, 15, white)
	    drawfilloval (460, 280, 30, 30, 46)
	    Draw.ThickLine (460, 280 + 25, 455, 280 + 40, 4, 136)
	    drawfilloval (475 + 5, 300 + 5, 20, 10, 121)
	    drawfilloval (445, 290, 5, 8, white)
	    drawfilloval (443, 272, 4, 4, white)

	    %star
	    drawfillstar (450, 130, 500, 80, white)

	elsif XX >= 10 and XX <= 80 and YY >= 360 and YY <= 380 then %music button
	    GUI.SetColor (music, 46)
	end if
	View.Update
	delay (200)
    end loop
end MENU

%when the game button is pressed
body proc GAME
    Window.Close (winID)
    reset
    game
    delay (4000)
    MENU
end GAME

%help menu
body proc HELP
    Window.Close (winID)
    winID := Window.Open ("graphics:800;600")
    View.Set ("offscreenonly")
    helpmenu
    page := 1
    delay (1000)
    MENU
end HELP

%quit program
body proc EXIT
    cls
    delay (100)
    textfileinput
    GUI.Quit
    Music.PlayFileStop %stops music
    Window.Close (winID)
end EXIT

%starts the intro screen when program is ran
INTRO
