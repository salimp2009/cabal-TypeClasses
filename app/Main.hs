module Main where 

import IOActions.MappingIO ( processArgs )
import TypeClasses.Motivation
import IOActions.IOinRealApps

main :: IO ()
main = do
  processArgs
  print $ uniqueElems (==) [1, 1, 2, 3, 1, 4]
  -- unsafeIO
  safeIO