module IOActions.MappingIO where
import System.Environment (getArgs)
import Text.Read (readMaybe)

sumArgs :: [String] -> Maybe Int
sumArgs strArgs= do
  intArgs <- mapM (readMaybe @Int) strArgs
  return (sum intArgs)
  
-- >>>:t getArgs
-- getArgs :: IO [String]
 
processArgs :: IO ()
processArgs = 
  getArgs >>= print . sumArgs