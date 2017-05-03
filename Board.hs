
{--  PART 1 --}

{-- 1.1 --}
mkBoard n = replicate n (replicate n 0)  

isGameOver bd = length intact == 0 where
    intact = [p | p <- all , p > 0] where
    all = concat bd

{-- 1.2 --}
isShipPlaceable :: Int -> Int -> Int -> Bool -> [[Int]] -> Bool
isShipPlaceable 0 x y dir board = True
isShipPlaceable n x y dir board 
    |(coord == 0)&&(dir == False)&&((n+y) < 11) = isShipPlaceable (n-1) x (y+1) dir board
    |(coord == 0)&&(dir == True)&&((n+x) < 11) = isShipPlaceable (n-1) (x+1) y dir board
    |otherwise = False
        where coord = board !!x !!y

placeShip :: Int -> Int -> Int -> Bool -> [[Int]] -> [[Int]] 
placeShip n x y dir board 
    | (dir == True) = desconc (length board) (take (index-1) concatBoard ++ replicate n n ++ drop (index-1+n) concatBoard)
	| otherwise = desconc (length board) (take (index-1) concatBoard ++ replaceCell n n ((length board)-1) (drop (index-1) concatBoard)) where 
	    index = ((y-1) * length board)+x
	    concatBoard = concat board
replaceCell 0 ship len list = list
replaceCell n ship len (h:t) = [ship] ++ take (len) t ++ replaceCell (n-1) ship len (drop len t)

desconc :: Int -> [Int] -> [[Int]]
desconc n [] = []
desconc n list = take n list : desconc n (drop n list)

{-- 1.3 --}
isHit x y board
    |shot < 0 = True
    |otherwise = False
    where shot = board !!x !!y
		  
hitBoard :: Int -> Int -> [[Int]] -> [[Int]]
hitBoard x y board
    |(shot > 1) = desconc (length board) (take (index-1) concatBoard ++ [-shot] ++ drop (index) concatBoard)
    |(shot == 0) = desconc (length board) (take (index-1) concatBoard ++ [-1] ++ drop (index) concatBoard)
    | otherwise = [] where 
        index = ((y-1) * length board)+x 
        concatBoard = concat board
        shot = board !!x !!y
		
{-- 1.4 --}
