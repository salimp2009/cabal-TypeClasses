--{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE StandaloneDeriving #-}
module TypeClasses.DerivingNullable where
import Prelude hiding (null)
import qualified Prelude (null) 
import Data.Kind (Type)

class Nullable a where
  isNullable :: a -> Bool
  null :: a
  
instance Nullable (Maybe a) where
  isNullable (Just _) = False
  isNullable Nothing  = True
  null = Nothing

instance Nullable [a] where
  isNullable  = Prelude.null
  null = []

newtype NullMaybe a = NullMaybe {getNull :: Maybe a} 
  deriving (Eq, Show)
  deriving (Nullable) via (Maybe a)

newtype NullList a = NullList {getNullList :: [a]}  
  deriving (Eq, Show)
  deriving (Nullable) via [a]

newtype Null (f::Type -> Type) (a::Type) = Null (f a) 
  deriving Show
