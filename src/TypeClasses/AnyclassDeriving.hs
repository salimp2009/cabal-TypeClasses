{-# LANGUAGE DefaultSignatures #-}
--{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DerivingStrategies #-}
module TypeClasses.AnyclassDeriving where

class Redact a where
  redact :: a -> String
  default redact :: Show a => a -> String
  redact = show

newtype UserNameN = UserNameN String 
  deriving Show

instance Redact UserNameN where
  redact (UserNameN user) = "UserName :" <> user

newtype AdminUser =  AdminUser UserNameN 
  deriving stock (Show)
  deriving newtype Redact