{-
  Examples of how laziness work in IO
  in Haskell
-}
module IOActions.IOinRealApps where
import Text.Printf

-- | no output because screamintoVoid
-- is not used
unevaluatedIO :: IO ()
unevaluatedIO = 
  let screamIntoVoid = putStrLn "quack" 
  in return ()

lazyIODemo :: IO ()  
lazyIODemo =  
  let
    sayHello :: IO ()
    sayHello = putStrLn "heylooo"

    raiseMathError :: IO Int
    raiseMathError = putStrLn "there is a math error"
                    >> return (1 `div` 0)
  in raiseMathError >> sayHello

makeAndReadFile :: Int -> IO String
makeAndReadFile filenum =
  let fname = printf "tmp/test/%d" filenum
  in writeFile fname fname  >> readFile fname

-- | this is supposes to give error "Too many files"
-- but on Windows it gives error "invalid file name after 2046"
unsafeIO :: IO ()
unsafeIO =
  let files =mapM makeAndReadFile [1..500] :: IO [String]
  in files >>= (putStrLn . show)

makeAndShow :: Int -> IO ()
makeAndShow num =
   makeAndReadFile num >>= putStrLn

-- | this is safe because we makeandwrite one file   
-- then read from file then show
-- prev version was creating all of them together
-- this version goes one by one
safeIO :: IO ()   
safeIO =
    mapM_ makeAndShow [1..10]  



-- >>>:t mapM  
-- mapM :: (Traversable t, Monad m) => (a -> m b) -> t a -> m (t b)

-- >>>:t mapM_
-- mapM_ :: (Foldable t, Monad m) => (a -> m b) -> t a -> m ()

-- >>>:t printf  
-- printf :: PrintfType r => String -> r

-- >>>:i PrintfType
-- type PrintfType :: * -> Constraint
-- class PrintfType t where
--   spr :: String -> [UPrintf] -> t
--   {-# MINIMAL spr #-}
--   	-- Defined in ‘Text.Printf’

-- >>>:i FilePath
-- type FilePath :: *
-- type FilePath = String
--   	-- Defined in ‘GHC.IO’
