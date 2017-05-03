
{--  PART 1 --}

{-- 1.1 --}

{-- Creates a board of size n*n --}
mkBoard n = replicate n (replicate n 0)  

isGameOver bd = length intact == 0 where
    intact = [p | p <- all , p > 0] where
    all = concat bd

{-- 1.2 --}

{-- Checks if ship can be place --}
isShipPlaceable :: Int -> Int -> Int -> Bool -> [[Int]] -> Bool
isShipPlaceable 0 x y dir board = True {-- if no more ships to place then is placeble--}
isShipPlaceable n x y dir board 
    |(coord == 0)&&(dir == False)&&((n+y) < 11) = isShipPlaceable (n-1) x (y+1) dir board {-- moves to the horizontal --}
    |(coord == 0)&&(dir == True)&&((n+x) < 11) = isShipPlaceable (n-1) (x+1) y dir board  {-- moves to the vertical --}
    |otherwise = False  {-- if there is a number greater than '0' --}
        where coord = board !!x !!y

{-- Converts the list of list into a single list, then place the ship and desconatenate --}
placeShip :: Int -> Int -> Int -> Bool -> [[Int]] -> [[Int]] 
placeShip n x y dir board 
    | (dir == True) = desconc (length board) (take (index-1) concatBoard ++ replicate n n ++ drop (index-1+n) concatBoard)  {-- put the ship in horizontal dir --}
	| otherwise = desconc (length board) (take (index-1) concatBoard ++ replaceCell n n ((length board)-1) (drop (index-1) concatBoard)) where {-- put the ship in vertical dir --}
	    index = ((y-1) * length board)+x {-- tells the index of where to put the ship --}
	    concatBoard = concat board {-- put the list of list in a single list --}
replaceCell 0 ship len list = list {-- When there is no more tail --}
replaceCell n ship len (h:t) = [ship] ++ take (len) t ++ replaceCell (n-1) ship len (drop len t) {-- places the ship vertically --}

{-- converts a single list to a list of list --}
desconc :: Int -> [Int] -> [[Int]]
desconc n [] = []
desconc n list = take n list : desconc n (drop n list) 

{-- 1.3 --}
isHit x y board
    |shot < 0 = True {-- if the cell shooted has negative values then it was shooted--}
    |otherwise = False
    where shot = board !!x !!y
		  
hitBoard :: Int -> Int -> [[Int]] -> [[Int]]
hitBoard x y board
    |(shot > 1) = desconc (length board) (take (index-1) concatBoard ++ [-shot] ++ drop (index) concatBoard) {-- if hits a ship then changes to negative value --}
    |(shot == 0) = desconc (length board) (take (index-1) concatBoard ++ [-1] ++ drop (index) concatBoard) {-- if there is nothing then put a -1--}
    | otherwise = [] where  {-- if it is negative then do nothing--}
        index = ((y-1) * length board)+x 
        concatBoard = concat board
        shot = board !!x !!y
		
{-- 1.4 --}
boardToStr marker board = mapM_(putStrLn . marker) board

{-- Display the miss shoots, the places non shooted and ships hitted --}
sqToStr [] = []
sqToStr (h:t) = (displayShots h) ++ " " ++ sqToStr t
displayShots n = if n == -1 then id "O" else if n < -1 then id "X" else id "."

{-- Display the miss shoots, the places non shooted, ships hitted and the location of the ships--}
sqToStrCheat [] = []
sqToStrCheat (h:t) = (cheat h) ++ " " ++ sqToStrCheat t
cheat n = if n == 0 then id "." 
else if n == -1 then id "O" 
else if n < -1 then id "X" else show n

