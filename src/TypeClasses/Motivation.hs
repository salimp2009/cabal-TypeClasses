-- |
-- Example to show why we need type class
-- for ad-hoc polymorphism via type classes
module TypeClasses.Motivation where

{- | use case;
>>> uniqueElems (==) [1, 1, 2, 3, 1, 4]
[1,2,3,4]

>>> uniqueElems (==) ["salitos", "didos", "salitos", "demiros"]
["salitos","didos","demiros"]
-}

uniqueElems :: (a -> a-> Bool) -> [a] -> [a]
uniqueElems _ [] = []
uniqueElems f (x : xs) =
  let 
    f' a b = not $ f a b
    xs' = filter (f' x) xs
  in x : uniqueElems f xs'  
  
