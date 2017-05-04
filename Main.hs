import System.IO
import System.Random
import Board

-- main :: IO ()
-- main = do
	-- number <- randomRIO (1,10) :: IO Int
	-- number1 <- randomRIO (1,10) :: IO Int
	-- putStrLn ("Your random number X is: " ++ show number)
	-- putStrLn ("Your random number Y is: " ++ show number1)

-- x :: IO Int
-- y :: IO Int
-- placeShips :: [Int] -> [[Int]] -> IO [[Int]]
-- placeShips [] board = [[]]
-- placeShips (h:t) board
	-- | (isShipPlaceable h x y dir board) = placeShip h x y dir board : placeShips t x y dir board
	-- | otherwise = placeShips ships board where
        -- x <- randomRIO (0,9) :: IO Int
        -- y <- randomRIO (0,9) :: IO Int
        -- ships = h ++ t

-- placeShips :: [Int] -> [[Int]] -> IO [[Int]]
-- placeShips (h:t) board = do 
	-- x <- randomRIO (0,9) :: IO Int
	-- y <- randomRIO (0,9) :: IO Int
	-- -- d <- randomRIO (0,1) :: IO Int
	-- if (isShipPlaceable h x y dir board) 
	-- then placeShip h x y dir board 
	-- else if (isShipPlaceable 0 x y dir board) then return board
	-- -- else if (placeShips [] board) then return board
	-- else placeShips ships board where
		-- ships = [h] ++ t
		-- dir = False
		
-- getXY :: [Int] -> [Row] -> IO ()
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
		     -- if((isHit (prompt !!1) (prompt !!2) board))
			 -- then 
			    -- getXY [] board
			 -- else return (hitBoard (prompt !!1) (prompt !!2) board)
       -- where
         -- getXY' = do
           -- putStrLn "Invalid input!"
           -- getXY prompt board