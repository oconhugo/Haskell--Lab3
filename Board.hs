{-
	Author: Ana Garcia & Cristian Ayub
	Professor: Dr. Yoonsik Cheon
	TA: Sheikh Naim
	Assignment: Project #3 - Functional Programmin Using Haskell
	Objective: To understand the concepts of
		functional programming and have a taste of it by writing a small
		Haskell program.
	Last updated: 05/04/2017
-}

module Board where

{-
	Creates a board of size n*n
-}
type Row = [Int]
type Board = [Row]
mkboard :: Int -> [Row]
mkboard n = take n (repeat(take n(repeat 0)))

{-
	Checks all the board and determines if the game is over
-}
isGameOver bd = length intact == 0 where
	intact = [p | p <- all , p > 0] where
	all = concat bd -- or all = [p | row <- bd , p <- row]
	
{-
	Checks if a ship of length n can be placed at (x,y) in a board
	and a specific position (dir)
-}
isShipPlaceable :: Int -> Int -> Int -> Bool -> [Row] -> Bool
isShipPlaceable 0 x y dir board = True
isShipPlaceable n x y dir board 
    |(coord == 0)&&(dir == False)&&((n+y) < 11) = isShipPlaceable (n-1) x (y+1) dir board
    |(coord == 0)&&(dir == True)&&((n+x) < 11) = isShipPlaceable (n-1) (x+1) y dir board
    |otherwise = False
        where coord = board !!x !!y

{-
	Places a ship of size n on (x,y) with a specific direction (dir) in the board
-}
placeShip :: Int -> Int -> Int -> Bool -> [Row] -> [Row] 
placeShip n x y dir board 
    | (dir == True) = deconcat (length board) (take (index - 1) concatBoard ++ replicate n n ++ drop ((index - 1) + n) concatBoard)
	| (dir == False) = deconcat (length board) (take (index - 1) concatBoard ++ replaceCell n n ((length board) - 1) (drop (index-1) concatBoard)) where 
	    index = (y * length board) + (x+1)
	    concatBoard = concat board 
replaceCell 0 ship len list = list
replaceCell n ship len (h:t) = [ship] ++ take (len) t ++ replaceCell (n-1) ship len (drop len t)

deconcat :: Int -> [Int] -> [Row]
deconcat n [] = []
deconcat n list = take n list : deconcat n (drop n list)

{-
	Checks whether a place (x,y) has been hit on a board
-}
isHit x y board
    |shot < 0 = True
    |otherwise = False
    where shot = board !!y !!x

{-
	Hit the square at the position (x,y) of the given board, where x
    and y are 1-based column and row indices. A new board is
    returned.
-}   
hitBoard :: Int -> Int -> [Row] -> [Row]
hitBoard x y board
    | shot > 0 = deconcat (length board) (take (index-1) concatBoard ++ [-shot] ++ drop (index) concatBoard) -- if the shot is a hit then (x,y) value becomes negative
    | shot == 0 = deconcat (length board) (take (index-1) concatBoard ++ [-1] ++ drop (index) concatBoard) -- if the shot is a miss then (x,y) becomes a -1
    | otherwise = [[]] where  -- if the shot was already made do nothing
        index = (y * length board) + (x+1)
        concatBoard = concat board
        shot = board !!y !!x
		

{-
	Draws a board "board" depending of the marker chosen
-}
boardToStr marker board = mapM_(putStrLn . marker) board

--Marker 1: Only shows the hits already made
sqToStr [] = []
sqToStr (h:t) = (showShots h) ++ " " ++ sqToStr t
showShots n = if n == -1 then id "O" 				-- If (x,y) was a miss = O
	else if n < -1 then id "X" 						-- If (x,y) was a hit = X
	else id "."										-- If (x,y) can be hit = .

--Marker 2: Shows all the hits already made along with the ship positioning
sqToStrCheat [] = []
sqToStrCheat (h:t) = (showCheatShots h) ++ " " ++ sqToStrCheat t
showCheatShots n = if n == 0 then id "." 			-- If (x,y) can be hit = .
	else if n == -1 then id "O" 					-- If (x,y) was a miss = O
	else if n < -1 then id "X" 						-- If (x,y) was a hit = X
	else show n										-- If (x,y) has a ship which can be hit = n (size of such a ship)



	
	
{-
LEGEND: 
0: empty
2..n: ship
-n..-2: hit
-1: miss
-}