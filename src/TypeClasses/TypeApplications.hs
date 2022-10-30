{-
  Some examples of using type applications
  Interred types , Specified Types
-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
module TypeClasses.TypeApplications where

showLeftRight :: (Read a, Read b) => String -> Either a b
showLeftRight s 
  | length s > 5 = Left  (read s)
  | otherwise    = Right (read s)

adheresToReadShowContract :: forall a. (Read a, Show a) => a -> Bool
adheresToReadShowContract val =
  let a = show . read @a . show $ val  
      b = show val
  in a == b

{- | Specified types @w@, @b@
we can use Type Applications on those 
>>>convertViaInt @_  @Double 50  
50.0
>>>convertViaInt @_  @Int 50  
50
>>>convertViaInt @Int 50  
50
-}
convertViaInt :: forall w b. (Integral w, Num b) => w -> b
convertViaInt input = fromIntegral $ fromIntegral @_ @Int input 

{- | Inferred type @{a}@ ; we cannot use type application on @a@
we can only apply type application on @b@ which is the Specified Type
>>>convertViaInt2 @Double 50  
50.0

>>>convertViaInt2 @Int @Double 50  
Cannot apply expression of type `a0_akhT[tau:1] -> Int'
to a visible type argument `Double'
In the expression: convertViaInt2 @Int @Double 50

>>>convertViaInt2 @Int 50  
50
-}

-- due to false error on HLS on {a}
-- disabled it.
-- convertViaInt2 :: forall {a} b. (Integral a, Num b) => a -> b
-- convertViaInt2 input =
--   fromIntegral $ fromIntegral @_ @Int input

convertViaInt3 :: forall w b. (Integral w, Num b) => w -> b
convertViaInt3 input = fromIntegral $ fromIntegral input   
