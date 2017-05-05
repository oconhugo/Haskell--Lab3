import Data.Char
import Data.List
import System.IO
import System.Random
import Board


convertStringToInt :: String -> Int
convertStringToInt [x] = ((ord x) - (ord '0'))

-- placeShips :: [Int] -> [[Int]] -> IO [[Int]]
placeShips h board = do 
	x <- randomRIO (0,9) :: IO Int
	y <- randomRIO (0,9) :: IO Int
	dir <- randomRIO (0,1) :: IO Int
	if((dir::Int) == 1)
	then 
		if(isShipPlaceable h (x::Int) (y::Int) True board)
		then return ((placeShip h (x::Int) (y::Int) True board)::Board)
		else placeShips h board
	else
		if(isShipPlaceable h (x::Int) (y::Int) False board)
		then return ((placeShip h (x::Int) (y::Int) False board)::Board)
		else placeShips h board
		
-- getXY :: [Int] -> [Row] -> IO [Row]
-- getXY prompt board = do
       -- putStrLn ("Enter a positive value?")   
       -- line <- getLine
       -- let parsed = reads line :: [(Int, String)] in
         -- if length parsed == 0
         -- then getXY'
         -- else let (input, _) = head parsed in
           -- if (input > 0 && (length prompt) < 3)
           -- then getXY ([input] ++ prompt) board
           -- else if(input < 0) 
		   -- then getXY'
		   -- else 
		     -- if((isHit (prompt !!2) (prompt !!3) board))
			 -- then 
			    -- getXY [] board
			 -- else return (hitBoard (prompt !!1) (prompt !!2) board)
       -- where
         -- getXY' = do
           -- putStrLn "Invalid input!"
           -- getXY prompt board
		  
-- getCoordinate = do
       -- putStrLn "Enter a positive value?"
       -- line <- getLine
       -- let parsed = reads line :: [(Int, String)] in
         -- if length parsed == 0
         -- then getCoordAgain
         -- else let (x, _) = head parsed in
           -- if x > 0 
           -- then return x
           -- else getCoordinate
         -- where
           -- getCoordAgain = do
             -- putStrLn "Invalid input!"
             -- getCoordinate
		   
-- play board =
	-- if isGameOver board
	-- then board
	-- else
		-- do
			-- let cx = convertStringToInt x
			-- let cy = convertStringToInt y
			-- if (isHit cy cx board)
			-- then (play board)
			-- else (hitBoard cy cx board) where
				-- x = getCoordinate
				-- y = getCoordinate

play board = do
	board <- placeShips 5 board
	boardToStr sqToStrCheat board
	if isGameOver board
	then do return "Game Over"
	else do
		putStrLn ("Input X coordinate to shoot")
		coordX <- getLine
		let cx = convertStringToInt coordX
		putStrLn ("Input Y coordinate to shoot")
		coordY <- getLine
		let cy = convertStringToInt coordY
		let newBoard = hitBoard cx cy board
		play newBoard