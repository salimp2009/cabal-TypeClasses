{-# LANGUAGE RecordWildCards #-}

module Haskellbook.Examples.UserInfo 
    ( User
    , lookupUser
    , authenticate
    , getUserName
    , getUserScore
    , getUserEmailAddress
    ) where
{-
  Goal : building a small model of an API to use 
  to manage user profile information 
  for a social media application
-}

import Data.List (find)

data User isAuthenticated = User
  { userName :: String
  , userInternetPoints :: Int
  , userPassword :: String
  , userEmailAddress :: String
  }
  --deriving Show

users :: [User a]
users = [george, porter]
  where
  george = User
    { userName = "george"
    , userInternetPoints = 1000
    , userPassword = "secret"
    , userEmailAddress = "gbird2015@example.com"
    }
  porter = User
    { userName = "porter"
    , userInternetPoints = 500
    , userPassword = "hunter2"
    , userEmailAddress = "woofwoof@example.com"
    }

lookupUser :: String -> Maybe (User Unauthenticated )
lookupUser name =
    find (\user -> userName user == name) users

getUserName :: User isAuthenticated -> String
getUserName = userName

getUserScore :: User isAuthenticated -> Int
getUserScore = userInternetPoints

getUserEmailAddress :: User Authenticated -> String
getUserEmailAddress = userEmailAddress

{- | use case 

>>>(Just user) = lookupUser "george"

>>>(Just authUser) = authenticate user "secret"

>>> getUserEmailAddress  authUser 
"gbird2015@example.com"
-}
authenticate :: User Unauthenticated -> String -> Maybe (User Authenticated)
authenticate User{..}  password 
      | userPassword == password = Just User{..}
      | otherwise = Nothing

data Authenticated
data Unauthenticated  


    
