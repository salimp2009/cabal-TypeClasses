{- |
 Examples for different derving strategies;
 stock deriving method only used to derivable;
   Eq for types that can be compared for equality
   Ord for types that have a total ordering
   Ix for types that support indexing into a range
   Show for types that can be converted into strings
   Read for types that can be parsed from strings
   Enum for types that can be converted to and from integers.
   Bounded for types with a finite upper and lower bounds
-}

{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
module TypeClasses.DerivingExamples where
import TypeClasses.HigherKindedSelector  
import Data.Kind (Type)

newtype Name = Name String
  deriving (Eq, Show, Ord)

data Cutomer = Customer
  { name :: Name
  , mail :: String
  , email:: String
  }
  deriving (Eq, Show, Ord)

newtype USD = USD { getMillis :: Integer} 
  deriving newtype (Eq, Show, Ord, Enum, Num, Real, Integral)

--deriving newtype instance Num USD  

newtype MyMaybe a =  MyMaybe (Maybe a) 
  deriving (Show)
  deriving (Semigroup, Monoid) via (Sel Maybe a)

-- instance Semigroup (MyMaybe a) where
--   (MyMaybe a) <> (MyMaybe b) = MyMaybe (pick a b)

-- instance Monoid (MyMaybe a) where
--   mempty = MyMaybe empty  

newtype Sel (f:: Type -> Type) (a::Type) = Sel (f a) 
  deriving (Show)

instance (Select f) => Semigroup (Sel f a) where
  Sel  a <> Sel b = Sel (pick a b)

instance (Select f) => Monoid (Sel f a) where
  mempty = Sel empty 

