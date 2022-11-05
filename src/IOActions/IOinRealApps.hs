{-
  Examples of how laziness work in IO
  in Haskell
-}
module IOActions.IOinRealApps where

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
    