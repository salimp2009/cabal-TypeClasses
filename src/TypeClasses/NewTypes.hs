{- |
  One of the biggest reasons for using newtype wrappers is to provide typeclass
  instances for a type that you’re wrapping. There are two reasons that you
  might want to use a newtype to create typeclass instances rather than creating
  instances for the underlying type: to avoid orphan instances, and to support
  multiple different typeclass instances for an underlying type. 
-}
module TypeClasses.NewTypes where

newtype Product = Product { getProduct :: Int}

newtype Sum = Sum { getSum :: Int}

instance Semigroup Product where
  (Product a) <> (Product b) = Product (a * b)

instance Monoid Product where  
  mempty = Product 1

-- >>>:i Semigroup
-- type Semigroup :: * -> Constraint
-- class Semigroup a where
--   (<>) :: a -> a -> a
--   sconcat :: NonEmpty a -> a
--   stimes :: Integral b => b -> a -> a
--   {-# MINIMAL (<>) #-}
--   	-- Defined in ‘GHC.Base’