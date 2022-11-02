module IOActions.IOBasics where

type MFilePath = String

copyFile :: MFilePath -> MFilePath -> IO ()
copyFile src dst = undefined
   --  (readFile src) processFile (writeFile dst)

  where
    readFile :: FilePath -> IO String
    readFile file   = undefined

    processFile   x  = undefined
  
    writeFile :: String -> IO ()
    writeFile dest  = undefined
