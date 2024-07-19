%NOT THE PROGRAM TO RUN

%________________________________________________________________

/*
 Date Started: 2023-12-18
 Date Finished: 2023-01-22
 Name: Arushi Phadte
 File Name: FPT Pacman Game.t
 Description of Program: Pac-Man Game with moving character and a tracked score that is used within a seperate menu file
 */

%classes
include "FPT Pacman Procs.t"

%variables
var font : int
font := Font.New ("serif:16:bold")
var scores : array 0 .. 100 of string
var rownum : int
var highscore : string

%proc to be called in the menu program to run the game
forward proc game

%entire game
body proc game

    %opening window
    var winID : int := Window.Open ("position:top;center,graphics:550;600")
    setscreen ("offscreenonly")

    fork gamemusic

    randpowerups

    %game loop
    for z : 1 .. 1000000000

	background
	arrowkeys

	%teleports pacman to the other side of the map if they are in a certain location
	if x >= 540 and y > 300 and y < 330 then
	    x := 20
	elsif x <= 10 and y > 300 and y < 330 then
	    x := 530
	end if

	%timer at the start if the match before the ghost can move
	if z > 0 and z <= 25 then
	    Font.Draw ("1", 230, 300, font, white)
	elsif z >= 26 and z <= 50 then
	    Font.Draw ("2", 230, 300, font, white)
	elsif z > 51 and z <= 75 then
	    Font.Draw ("3", 230, 300, font, white)
	end if

	%moves the ghosts after 100 loops
	if z > 100 then
	    ghostmovement (xPINK, yPINK, i)
	    ghostmovement (xBLUE, yBLUE, k)
	    ghostmovement (xORANGE, yORANGE, j)
	    ghostmovement (xRED, yRED, p)
	end if

	%draws the score on the screen after the ghosts leaves
	if z > 80 then
	    if multiplier <= 1 then
		Font.Draw ("Score : " + intstr (score), 230, 310, font, white)
	    else
		Font.Draw ("Score : " + intstr (score), 230, 310, font, 44)
	    end if
	end if

	%drawing the coins and the pacman and a coin hit each other, the program will remove the coin and count it for the score
	for e : 1 .. 12
	    if (x <= coinx1 (e) + 10 and x >= coinx1 (e) - 10 and y <= coiny1 (e) + 10 and y >= coiny1 (e) - 10) then
		coinx1 (e) := 1000
		coiny1 (e) := 1000
		scoremath
		coinscount := coinscount + 1
	    end if
	    drawfilloval (coinx1 (e), coiny1 (e), 2, 2, white)
	end for

	for r : 1 .. 12
	    if (x <= coinx2 (r) + 10 and x >= coinx2 (r) - 10 and y <= coiny2 (r) + 10 and y >= coiny2 (r) - 10) then
		coinx2 (r) := 1000
		coiny2 (r) := 1000
		coinscount := coinscount + 1
		scoremath
	    end if
	    drawfilloval (coinx2 (r), coiny2 (r), 2, 2, white)
	end for

	for w : 1 .. 13
	    if (x <= coinx3 (w) + 10 and x >= coinx3 (w) - 10 and y <= coiny3 (w) + 10 and y >= coiny3 (w) - 10) then
		coinx3 (w) := 1000
		coiny3 (w) := 1000
		scoremath
		coinscount := coinscount + 1
	    end if
	    drawfilloval (coinx3 (w), coiny3 (w), 2, 2, white)
	end for

	for q : 1 .. 13
	    drawfilloval (coinx4 (q), coiny4 (q), 2, 2, white)
	    if (x <= coinx4 (q) + 10 and x >= coinx4 (q) - 10 and y <= coiny4 (q) + 10 and y >= coiny4 (q) - 10) then
		coinx4 (q) := 1000
		coiny4 (q) := 1000
		scoremath
		coinscount := coinscount + 1
	    end if
	end for

	%ends game if all coins are collected
	if coinscount = 50 then
	    fork gamewonsound
	    exitstate := true
	    drawfillbox (0, 280, 800, 350, black)
	    %game won text
	    for t : 1 .. 9
		Font.Draw (gamewon (t), Xgameover, 300, gamedisplay, 68)
		Xgameover := Xgameover + 50
		View.Update
		delay (300)
	    end for
	end if

	%checks for collision of powerups
	powerup

	%drawing the characters
	%red ghost
	drawfilloval (xRED, yRED, 9, 9, 40)
	drawfilloval (xRED, yRED, 6, 6, 63)
	drawfilloval (xRED, yRED, 3, 3, white)
	%orange ghost
	drawfilloval (xORANGE, yORANGE, 9, 9, 41)
	drawfilloval (xORANGE, yORANGE, 6, 6, 42)
	drawfilloval (xORANGE, yORANGE, 3, 3, 67)
	%blue ghost
	drawfilloval (xBLUE, yBLUE, 9, 9, 53)
	drawfilloval (xBLUE, yBLUE, 6, 6, 52)
	drawfilloval (xBLUE, yBLUE, 3, 3, white)
	%pink ghost
	drawfilloval (xPINK, yPINK, 9, 9, 37)
	drawfilloval (xPINK, yPINK, 6, 6, 84)
	drawfilloval (xPINK, yPINK, 3, 3, white)
	%pacman character
	drawfilloval (x, y, 10, 10, 43)
	drawfilloval (x, y, 7, 7, 44)
	drawfilloval (x, y, 4, 4, white)

	%the game is over when a ghost and pacman touch
	gameovertouch (xPINK, yPINK)
	gameovertouch (xBLUE, yBLUE)
	gameovertouch (xORANGE, yORANGE)
	gameovertouch (xRED, yRED)

	%exit game if all coins are collected or if pacman has touched a ghost
	if exitstate = true then
	    exit
	end if

	%loops again
	View.Update
	delay (50)
	cls

    end for

    %resets gameover text for next game
    Xgameover := 60
    delay (1000)

    %displays the score, personal best, and high score with a sound and delay
    if strint (scores (rownum)) < score then
	scores (rownum) := intstr (score)
    end if
    drawfillbox (20, 20, 530, 580, black)
    Font.Draw ("SCORES", 130, 510, titles, white)
    View.Update
    Music.PlayFile ("mixkit-retro-game-notification-212.mp3")
    delay (500)
    Font.Draw ("Your Score: " + intstr (score), 40, 400, unique, white)
    View.Update
    Music.PlayFile ("mixkit-retro-game-notification-212.mp3")
    delay (500)
    Font.Draw ("Your Personal Best: " + (scores (rownum)), 40, 300, unique, white)
    View.Update
    Music.PlayFile ("mixkit-retro-game-notification-212.mp3")
    delay (500)
    if score > strint (highscore) then
	highscore := intstr (score)
	Font.Draw ("The NEW HIGH SCORE: " + (highscore), 40, 200, unique, brightblue)
    else
	Font.Draw ("The HIGH SCORE: " + (highscore), 40, 200, unique, white)
    end if
    View.Update
    Music.PlayFile ("mixkit-retro-game-notification-212.mp3")

end game
