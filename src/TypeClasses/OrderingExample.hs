module TypeClasses.OrderingExample where

import Prelude hiding (Ord(..), Ordering(..))
import Data.Word (Word8)

data Ordering = LT | EQ | GT

instance Show Ordering where
  show LT = "LT"
  show EQ = "EQ"
  show GT = "GT"

class Eq a => Ord a where
  mcompare :: a -> a -> Ordering
  mcompare a b
    | a == b = EQ
    | a <= b = LT
    | otherwise = GT

  (<) :: a -> a -> Bool
  a < b =
    case mcompare a b of
      LT -> True
      _ -> False

  (<=) :: a -> a -> Bool
  a <= b =
    case mcompare a b of
    GT -> False
    _  -> True

  (>) :: a -> a -> Bool
  a > b =
    case mcompare a b of
      GT -> True
      _  -> False 
      
  (>=) :: a -> a -> Bool
  a >= b =
    case mcompare a b of
      LT -> False 
      _  -> True      

  max :: a -> a -> a
  max a b =
    case mcompare a b of
      GT -> a
      _  -> b

  min :: a -> a -> a
  min a b =
    case mcompare a b of
      LT -> a
      _  -> b      

  {-# MINIMAL mcompare | (<=) #-}  
  
  
instance Ord Word8 where
  a <= b
    | a == b = True
    | a == 0 = True
    | b == 0 = False
    | otherwise = (a - 1) <= (b - 1)
  

            
        



