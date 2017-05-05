import Data.Char
import Data.List
import System.IO
import System.Random
import Board

convertStringToInt :: String -> Int
convertStringToInt [x] = ((ord x) - (ord '0'))

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

play board = do
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
		-- let newBoard = hitBoard cx cy board
		-- play newBoard
		if (isHit cx cy board) 
		then do
			putStrLn ("Error: Invalid shot.")
			play board
		else do
			let newBoard = hitBoard cx cy board
			play newBoard
		
execute board = do
	board <- placeShips 5 board
	board <- placeShips 4 board
	board <- placeShips 3 board
	board <- placeShips 2 board
	board <- placeShips 2 board
	play board