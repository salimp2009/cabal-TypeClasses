{-# LANGUAGE LambdaCase #-}
module IOActions.IOBasics where

import System.IO

copyFile :: FilePath -> FilePath -> IO ()
copyFile src dst =  -- undefined
   readFile src `andThen` writeFile dst

andThen :: IO String -> (String -> IO ()) -> IO ()
andThen = (>>=)

-- readCopy :: FilePath -> FilePath -> IO ()
-- readCopy src dst =
--   openFile src ReadMode `andThen`
--   hGetContents `andThen`
--   \contents -> 
--     openFile dst WriteMode `andThen`
--     flip hPutStr contents

noPassword :: FilePath -> IO String
noPassword =
  \case 
    "etc/passwd" -> newIO "hey it is a secret!!"
    fname -> readFile fname
  where
    newIO :: a -> IO a
    newIO = return 
{-
λ >>showFile "etc/passwd"
hey it is a secret!!
-}
showFile :: FilePath -> IO ()
showFile path = noPassword path `andThen` putStrLn    

{-
>>> return "45" >>= ioRead
45
-}
ioRead :: String -> IO Int
ioRead numString = return (read @Int numString)        

{-
>>>return "45" >>= ioRead >>= ioShow >>= ioRead
45
-}
ioShow :: Show a => a -> IO String
ioShow = return . show
