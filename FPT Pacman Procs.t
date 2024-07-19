%NOT THE PROGRAM TO RUN

%________________________________________________________________

/*
 Date Started: 2023-12-18
 Date Finished: 2023-01-22
 Name: Arushi Phadte
 File Name: FPT Pacman Procs.t
 Description of Program: Pac-Man Game's procs to be called in a seperate program
 */

%game
forward proc background
forward proc scoremath
forward proc ghostmovement (var Xvalue, Yvalue, num : int)
forward proc arrowkeys
forward proc gameovertouch (var XVALUE, YVALUE : int)
forward proc powerup
forward proc randpowerups
forward proc timemultiplier
forward proc helpmenu
forward proc reset
forward proc backforward
forward proc pagecheck

%music
process gameoversound
    Music.PlayFile ("mixkit-arcade-retro-game-over-213.mp3")
end gameoversound

process gamewonsound
    Music.PlayFile ("mixkit-retro-game-notification-212.mp3")
end gamewonsound

process gamemusic
    Music.PlayFile ("mixkit-deep-urban-623.mp3")
end gamemusic

process menumusic
    Music.PlayFile ("mixkit-getting-ready-46.mp3")
end menumusic


%variables for coordinates and counters
var x, y, i, k, j, p, number, blank, xPINK, yPINK, xBLUE, yBLUE, xORANGE, yORANGE, xRED, yRED, X, Y, X2, Y2, coinscount, starttime, currenttime : int
var score : int
score := 0
var page : int := 1
var multiplier : int
var exitstate : boolean
var pageexit : boolean := false
var XX, YY, button : int

%coin x and y variables
var coiny1 : array 1 .. 12 of int := init (100, 140, 180, 220, 260, 300, 340, 380, 420, 460, 500, 540)
var coinx1 : array 1 .. 12 of int := init (420, 420, 420, 420, 420, 420, 420, 420, 420, 420, 420, 420)

var coiny2 : array 1 .. 12 of int := init (100, 140, 180, 220, 260, 300, 340, 380, 420, 460, 500, 540)
var coinx2 : array 1 .. 12 of int := init (130, 130, 130, 130, 130, 130, 130, 130, 130, 130, 130, 130)

var coiny3 : array 1 .. 13 of int := init (475, 475, 475, 475, 475, 475, 475, 475, 475, 475, 475, 475, 475)
var coinx3 : array 1 .. 13 of int := init (40, 80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480, 520)

var coiny4 : array 1 .. 13 of int := init (40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40)
var coinx4 : array 1 .. 13 of int := init (40, 80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480, 520)

%resets the variables at the start of each game
body proc reset
    %multiplier for powerups
    multiplier := 1

    %boolean to exit the game loop
    exitstate := false

    %arrays for the x and y values of the coins in each line
    number := 100
    for T : 1 .. 12
	coiny1 (T) := number
	coinx1 (T) := 420
	coiny2 (T) := number
	coinx2 (T) := 130
	number := number + 40
    end for
    number := 40
    for S : 1 .. 13
	coiny3 (S) := 475
	coinx3 (S) := number
	coiny4 (S) := 40
	coinx4 (S) := number
	number := number + 40
    end for

    %setting the value for variables
    x := 275
    y := 370
    xPINK := 275
    yPINK := 325
    xBLUE := 275
    yBLUE := 315
    xORANGE := 275
    yORANGE := 305
    xRED := 275
    yRED := 295
    i := 1
    k := 1
    j := 1
    p := 1
    blank := 1
    coinscount := 0
    score := 0
end reset

%variables for the menu fonts and game end variables
var titles, main, unique, gamedisplay : int
titles := Font.New ("sans serif:50:bold")
main := Font.New ("Palatino:18")
unique := Font.New ("Georgia:25:bold")
gamedisplay := Font.New ("Georgia:40:bold")
var gameoverword : array 1 .. 9 of string := init ("G", "A", "M", "E", " ", "O", "V", "E", "R")
var gamewon : array 1 .. 9 of string := init ("G", "A", "M", "E", " ", "W", "O", "N", "!")
var Xgameover : int := 60

%variable for getting the key and arrow inputs from the user
var chars : array char of boolean

%drawing the background of the game
body proc background

    %black background
    drawfillbox (0, 0, maxx, maxy, black)

    %outside walls
    Draw.ThickLine (210, 275, 340, 275, 15, blue)
    Draw.ThickLine (210, 350, 260, 350, 15, blue)
    Draw.ThickLine (290, 350, 340, 350, 15, blue)
    Draw.ThickLine (210, 350, 210, 275, 15, blue)
    Draw.ThickLine (340, 350, 340, 275, 15, blue)
    Draw.ThickLine (110, 300, 110, 220, 15, blue)
    Draw.ThickLine (0, 300, 110, 300, 15, blue)
    Draw.ThickLine (110, 220, 20, 220, 15, blue)
    Draw.ThickLine (110, 405, 110, 330, 15, blue)
    Draw.ThickLine (0, 330, 110, 330, 15, blue)
    Draw.ThickLine (110, 405, 20, 405, 15, blue)
    Draw.ThickLine (20, 405, 20, 580, 15, blue)
    Draw.ThickLine (20, 580, 530, 580, 15, blue)
    Draw.ThickLine (530, 405, 530, 580, 15, blue)
    Draw.ThickLine (440, 405, 530, 405, 15, blue)
    Draw.ThickLine (440, 405, 440, 330, 15, blue)
    Draw.ThickLine (440, 330, 600, 330, 15, blue)
    Draw.ThickLine (440, 300, 600, 300, 15, blue)
    Draw.ThickLine (440, 300, 440, 220, 15, blue)
    Draw.ThickLine (440, 220, 530, 220, 15, blue)
    Draw.ThickLine (530, 220, 530, 20, 15, blue)
    Draw.ThickLine (20, 220, 20, 20, 15, blue)
    Draw.ThickLine (20, 20, 530, 20, 15, blue)

    %inside boxes
    drawfillbox (50, 490, 110, 550, blue)
    drawfillbox (140, 490, 230, 550, blue)
    drawfillbox (50, 465, 110, 435, blue)
    drawfillbox (145, 330, 170, 460, blue)
    drawfillbox (145, 380, 230, 410, blue)
    drawfillbox (205, 440, 345, 465, blue)
    drawfillbox (260, 500, 290, 580, blue)
    drawfillbox (320, 490, 410, 550, blue)
    drawfillbox (435, 490, 490, 550, blue)
    drawfillbox (435, 465, 490, 435, blue)
    drawfillbox (205, 220, 345, 245, blue)
    drawfillbox (205, 110, 345, 135, blue)
    drawfillbox (260, 160, 290, 240, blue)
    drawfillbox (260, 50, 290, 130, blue)
    drawfillbox (260, 390, 290, 460, blue)
    drawfillbox (320, 380, 405, 410, blue)
    drawfillbox (380, 460, 405, 330, blue)
    drawfillbox (380, 295, 405, 220, blue)
    drawfillbox (145, 295, 170, 220, blue)
    drawfillbox (145, 135, 170, 55, blue)
    drawfillbox (380, 135, 405, 55, blue)
    drawfillbox (320, 55, 490, 80, blue)
    drawfillbox (60, 55, 230, 80, blue)
    drawfillbox (320, 165, 405, 190, blue)
    drawfillbox (145, 165, 230, 190, blue)
    drawfillbox (55, 165, 110, 190, blue)
    drawfillbox (440, 165, 500, 190, blue)
    drawfillbox (440, 190, 465, 110, blue)
    drawfillbox (85, 190, 110, 110, blue)
    drawfillbox (20, 110, 50, 140, blue)
    drawfillbox (495, 110, 525, 140, blue)
end background

%calculating the score after collecting a coin
body proc scoremath
    score := score + 1 * multiplier
end scoremath

%for moving the ghosts
body proc ghostmovement
    %follows one direction until they can't
    if num = 1 then
	if whatdotcolor (Xvalue, Yvalue + 13) = black then
	    Yvalue := Yvalue + 7
	else
	    randint (num, 1, 4)
	    if blank > 0 and blank < 5 then %makes sure that at the start of the game the ghosts get out of the gate
		randint (num, 2, 3)
		blank := blank + 1
	    end if
	end if
    elsif num = 2 then
	if whatdotcolor (Xvalue + 13, Yvalue) = black then
	    Xvalue := Xvalue + 7
	else
	    randint (num, 1, 4)
	end if
    elsif num = 3 then
	if whatdotcolor (Xvalue - 13, Yvalue) = black then
	    Xvalue := Xvalue - 7
	else
	    randint (num, 1, 4)
	end if
    elsif num = 4 then
	if whatdotcolor (Xvalue, Yvalue - 13) = black then
	    Yvalue := Yvalue - 7
	else
	    randint (num, 1, 4)
	end if
    end if
end ghostmovement

%moving the pacman using the arrow keys
body proc arrowkeys
    Input.KeyDown (chars)
    if chars (KEY_UP_ARROW) then
	if whatdotcolor (x, y + 13) = black then
	    y := y + 5
	end if
    end if
    if chars (KEY_RIGHT_ARROW) then
	if whatdotcolor (x + 13, y) = black then
	    x := x + 5
	end if
    end if
    if chars (KEY_LEFT_ARROW) then
	if whatdotcolor (x - 13, y) = black then
	    x := x - 5
	end if
    end if
    if chars (KEY_DOWN_ARROW) then
	if whatdotcolor (x, y - 13) = black then
	    y := y - 5
	end if
    end if
end arrowkeys

%check if pacman has hit a ghost and will exit the game when this is true
body proc gameovertouch
    if (x <= XVALUE + 13 and x >= XVALUE - 13 and y <= YVALUE + 13 and y >= YVALUE - 13) then %pink ghost
	fork gameoversound
	exitstate := true
	drawfillbox (0, 280, 800, 350, black)
	for t : 1 .. 9
	    Font.Draw (gameoverword (t), Xgameover, 300, gamedisplay, 68)
	    Xgameover := Xgameover + 50
	    View.Update
	    delay (300)
	end for
    end if
end gameovertouch

%check if pacman has touched a powerup and will change the multiplier, start the timer, and remove the powerup from the screen
body proc powerup
    if (x <= X + 10 and x >= X - 10 and y <= Y + 10 and y >= Y - 10) then %pink ghost
	multiplier := 2 %coins are worth double
	starttime := Time.Elapsed %tracks the time that the power up has been active for
	X := 1000 %removes the x and y values of the coin
	Y := 1000
	timemultiplier
    end if
    if (x <= X2 + 10 and x >= X2 - 10 and y <= Y2 + 10 and y >= Y2 - 10) then     %pink ghost
	multiplier := 2
	starttime := Time.Elapsed
	X2 := 1000
	Y2 := 1000
	timemultiplier
    end if

    %will check the timer if the multiplier is still active and if ten seconds has passed
    if multiplier = 2 then
	timemultiplier
    end if

    %draws the powerups in the randomize locations
    drawfilloval (X, Y, 6, 6, 46)
    Draw.ThickLine (X, Y + 4, X, Y + 9, 4, 136)
    drawfilloval (X + 5, Y + 5, 5, 3, 121)

    drawfilloval (X2, Y2, 6, 6, 46)
    Draw.ThickLine (X2, Y2 + 4, X2, Y2 + 9, 4, 136)
    drawfilloval (X2 + 5, Y2 + 5, 5, 3, 121)
end powerup

%randomizes the locations of the powerups to 6 different locations at the start
body proc randpowerups
    randint (X, 1, 6)
    if X = 1 then
	X := 80
	Y := 425
	X2 := 305
	Y2 := 150
    elsif X = 2 then
	X := 305
	Y := 150
	X2 := 480
	Y2 := 150
    elsif X = 3 then
	X := 480
	Y := 150
	X2 := 185
	Y2 := 315
    elsif X = 4 then
	X := 185
	Y := 315
	X2 := 360
	Y2 := 430
    elsif X = 5 then
	X := 360
	Y := 430
	X2 := 465
	Y2 := 420
    elsif X = 6 then
	X := 465
	Y := 420
	X2 := 80
	Y2 := 425
    end if
end randpowerups

%checks the timer of the multiplier to turn the multiplier off after 10 seconds
body proc timemultiplier
    currenttime := Time.Elapsed
    if currenttime - starttime >= 10000 then
	multiplier := 1
    end if
end timemultiplier

%help menu
body proc helpmenu
    Text.ColorBack (black)
    cls
    loop
	%help menu text to show the controls
	Font.Draw ("How To Play", 200, 480, titles, 38)
	Draw.ThickLine (190, 470, 610, 470, 3, 38)
	Font.Draw ("Use your arrow keys to move up, down, left and right!", 120, 440, main, white)
	Font.Draw ("Test it out now!", 450, 340, main, white)
	Font.Draw ("The buttons should light up", 450, 300, main, white)
	Font.Draw ("PINK!", 510, 230, titles, 38)
	Font.Draw ("<                                  >", 50, 60, titles, white)
	Font.Draw ("MENU", 40, 30, main, white)
	Font.Draw ("NEXT", 720, 30, main, white)

	%add the ability to press the arrow keys and have the boxes change colour
	Input.KeyDown (chars)
	if chars (KEY_UP_ARROW) then
	    drawfillbox (200, 255, 300, 305, 38)
	else
	    drawfillbox (200, 255, 300, 305, 28)
	end if

	if chars (KEY_LEFT_ARROW) then
	    drawfillbox (95, 200, 195, 250, 38)
	else
	    drawfillbox (95, 200, 195, 250, 28)
	end if

	if chars (KEY_RIGHT_ARROW) then
	    drawfillbox (305, 200, 405, 250, 38)
	else
	    drawfillbox (305, 200, 405, 250, 28)
	end if

	if chars (KEY_DOWN_ARROW) then
	    drawfillbox (200, 200, 300, 250, 38)
	else
	    drawfillbox (200, 200, 300, 250, 28)
	end if

	%words on the keys
	Font.Draw ("DOWN", 215, 220, main, white)
	Font.Draw ("RIGHT", 110, 220, main, white)
	Font.Draw ("LEFT", 324, 220, main, white)
	Font.Draw ("UP", 235, 275, main, white)
	backforward
	View.Update
	exit when page not= 1
    end loop
    loop
	pagecheck
	exit when page = 0 or page = 3
    end loop
end helpmenu

%changes the page once the user click on the arrow
body proc backforward
    delay (100)
    Mouse.Where (XX, YY, button)
    %back
    if XX >= 5 and XX <= 120 and YY >= 5 and YY <= 120 and button = 1 then
	page := page - 1
    end if
    %forward
    if XX >= 700 and XX <= 800 and YY >= 5 and YY <= 120 and button = 1 then
	page := page + 1
    end if
end backforward

%diplays a different page of the help menu depending on page value
body proc pagecheck
    if page = 1 then
	delay (200)
	Text.ColorBack (black)
	cls
	loop
	    Font.Draw ("How To Play", 200, 480, titles, 38)
	    Draw.ThickLine (190, 470, 610, 470, 3, 38)
	    Font.Draw ("Use your arrow keys to move up, down, left and right!", 120, 440, main, white)
	    Font.Draw ("Test it out now!", 450, 340, main, white)
	    Font.Draw ("The buttons should light up", 450, 300, main, white)
	    Font.Draw ("PINK!", 510, 230, titles, 38)
	    Font.Draw ("<                                  >", 50, 60, titles, white)
	    Font.Draw ("MENU", 40, 30, main, white)
	    Font.Draw ("NEXT", 720, 30, main, white)
	    %add the ability to press the arrow keys and have the boxes change colour
	    Input.KeyDown (chars)
	    if chars (KEY_UP_ARROW) then
		drawfillbox (200, 255, 300, 305, 38)
	    else
		drawfillbox (200, 255, 300, 305, 28)
	    end if

	    if chars (KEY_LEFT_ARROW) then
		drawfillbox (95, 200, 195, 250, 38)
	    else
		drawfillbox (95, 200, 195, 250, 28)
	    end if

	    if chars (KEY_RIGHT_ARROW) then
		drawfillbox (305, 200, 405, 250, 38)
	    else
		drawfillbox (305, 200, 405, 250, 28)
	    end if

	    if chars (KEY_DOWN_ARROW) then
		drawfillbox (200, 200, 300, 250, 38)
	    else
		drawfillbox (200, 200, 300, 250, 28)
	    end if

	    Font.Draw ("DOWN", 215, 220, main, white)
	    Font.Draw ("RIGHT", 110, 220, main, white)
	    Font.Draw ("LEFT", 324, 220, main, white)
	    Font.Draw ("UP", 235, 275, main, white)

	    View.Update
	    backforward
	    exit when page not= 1
	end loop
    elsif page = 2 then
	delay (200)
	Text.ColorBack (black)
	cls
	loop
	    %visuals and text
	    Font.Draw ("The Rules", 240, 480, titles, 38)
	    Draw.ThickLine (190, 470, 610, 470, 3, 38)
	    Font.Draw ("Get the highest score you can!", 240, 440, main, white)
	    Font.Draw ("Collect coins and use 10 second", 420, 360, main, white)
	    Font.Draw ("powerups to double points.", 420, 335, main, white)
	    Font.Draw ("Avoid the pink, orange, red and", 420, 300, main, white)
	    Font.Draw ("blue ghosts and stay alive!", 420, 275, main, white)
	    Font.Draw ("The game will end when you hit", 420, 240, main, white)
	    Font.Draw ("a ghost or when all coins have ", 420, 215, main, white)
	    Font.Draw ("been collected.", 420, 190, main, white)
	    Font.Draw ("The game starts after 3 seconds.", 420, 160, main, white)
	    Font.Draw ("<                                  >", 50, 60, titles, white)
	    Font.Draw ("BACK", 40, 30, main, white)
	    Font.Draw ("MENU", 720, 30, main, white)
	    Font.Draw ("Power UP!", 50, 330, unique, 68)
	    Font.Draw ("The GHOSTS!", 50, 180, unique, 68)
	    %apple
	    drawfilloval (300, 340, 34, 34, 46)
	    Draw.ThickLine (300, 340 + 25, 295, 340 + 40, 9, 136)
	    drawfilloval (315 + 5, 360 + 5, 20, 10, 121)

	    %ghosts
	    drawfilloval (250, 250, 9, 9, 40)
	    drawfilloval (250, 250, 6, 6, 63)
	    drawfilloval (250, 250, 3, 3, white)
	    drawfilloval (190, 250, 9, 9, 41)
	    drawfilloval (190, 250, 6, 6, 42)
	    drawfilloval (190, 250, 3, 3, 67)
	    drawfilloval (130, 250, 9, 9, 53)
	    drawfilloval (130, 250, 6, 6, 52)
	    drawfilloval (130, 250, 3, 3, white)
	    drawfilloval (70, 250, 9, 9, 37)
	    drawfilloval (70, 250, 6, 6, 84)
	    drawfilloval (70, 250, 3, 3, white)

	    View.Update
	    backforward
	    exit when page not= 2
	end loop
    end if
end pagecheck
