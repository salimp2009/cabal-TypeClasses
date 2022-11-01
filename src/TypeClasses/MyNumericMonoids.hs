{-
  Example for Deriving via strategy
-}
{-# LANGUAGE DerivingVia #-}
module TypeClasses.MyNumericMonoids where
import Data.Semigroup  

{- |
>>>mconcat $ map MySum [1..10]
MySum {getMysum = 55}

>>>mconcat $ map MyProduct [1..10]
MyProduct {getMyproduct = 3628800}
-}
newtype MySum = MySum {getMysum :: Int}
  deriving stock (Eq, Show)
  deriving (Semigroup, Monoid) via (Sum Int)

newtype MyProduct a = MyProduct {getMyproduct :: a}
  deriving stock (Eq, Show)
  deriving (Semigroup, Monoid) via (Product a)
