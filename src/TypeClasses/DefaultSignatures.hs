{-|
  imagine  writing a logging library. One feature
  you might want to provide is giving users the ability to log some data that
  might need to be redacted. 
  e.g; we might want to log that a user provided a password, 
  but we don’t want to include the value of that password
  in our plain text log files
-}
{-# LANGUAGE DefaultSignatures #-}
module TypeClasses.DefaultSignatures where

class Redacted a where
  redacted :: a -> String
  default redacted :: Show a => a -> String
  redacted = show

newtype UserName = UserName String  

instance Show UserName where
  show (UserName name) = name

-- | since we provide @default redacted@
-- we do not need to provide for @UserName@ since 
-- provided a @Show@ instance for it
instance Redacted UserName 

newtype Password = Password String

instance Redacted Password where
  redacted _ ="<redacted>"

