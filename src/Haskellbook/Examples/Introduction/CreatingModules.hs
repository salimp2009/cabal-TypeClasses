-- |
-- This module serves as an example of how you can create a
-- module. This comment will be placed at the top of the generated
-- documentation.

{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE RankNTypes #-}
module Haskellbook.Examples.Introduction.CreatingModules
    ( Name(..)
    , Salutation(Salutation, getSalutation)
    , GreetingMessage(..)
    -- , GreetingMessage(GreetingMessage)
    -- -- ^ this exports the constructor and all rec fields are accessible 
    , defaultMessage
    , formatMessage 
    , testMessage
    , excitingMessage
    ) where
    
excitingMessage :: String -> String
excitingMessage message =
    "Exciting Haskell news: " <> message <> " wahoo!!!"

newtype Name = Name {getName :: String} 
        deriving Show

newtype Salutation = Salutation {getSalutation :: String}
        deriving Show

{- 
  We can use a comment starting with a caret symbol (^) to add comments for
  specific fields in a record. If you prefer, you can also use the pipe comment
  notation, putting a comment before each record field:
-}        
data GreetingMessage = GreetingMessage
    { greetingSalutation :: Salutation  -- ^ A 'Salutation', like \"Hello\"
    , greetingTo :: Name                -- ^ 'Name' of the person that should be greeted
    , greetingFrom :: [Name]            -- ^ 'Name's of the people who are sending the greeting
    } 
    deriving Show

{- 
    also include
    more general code snippets in your documentation using the at-symbol (@)
    to mark the beginning and end of a code block
    surrounding something with double quotes (") tells haddock to treat it as a
    reference to a module. Surrounding something with single quotes (') makes
    it a reference to a function or type. We can insert literal quotes by escaping
    them with a backslash (\). Let’s take advantage of this ability to link to things
    by making the type cosntructor and field accessors in our example link to
    their definitions in the documentation
-}    

{- |
A default greeting message that isn't attributed to anyone:
@
'GreetingMessage'
    { 'greetingSalutation' = 'Salutation' \"Hello\"
    , 'greetingTo' = 'Name' \"Friend\"
    , 'greetingFrom' = []
    }
@
-}
defaultMessage :: GreetingMessage
defaultMessage = GreetingMessage
    { greetingSalutation = Salutation "Welcome"
    , greetingTo = Name "Friendos"    
    , greetingFrom = []
    }

{- |
A GreetingMessage contains all of the information needed to generate a
greeting using 'formatMessage'. You can get a default greeting without
attribution from 'defaultMessage'. This makes it convenient to use
record update syntax to construct a new greeting:

>>> formatMessage defaultMessage { greetingFrom = [ Name "A Haskeller"] }
"Welcome Friendos, from: A Haskeller"
-}
formatMessage :: GreetingMessage -> String
formatMessage  GreetingMessage{..} = greetingWithSuffix
    where
        basicGreeting = 
            getSalutation greetingSalutation <> " " <> getName greetingTo 
        greetingWithSuffix = case greetingFrom of
            []         -> basicGreeting <> "!"
            [friend]   -> basicGreeting <> ", from: " <> getName friend
            [friendA, friendB] 
                  -> basicGreeting <> ", from: " <> getName friendA <> "and " <> getName friendB
            friends -> basicGreeting <>", from your friends: " <> formatFriendList friends

formatFriendList :: [Name] -> String
formatFriendList friends = 
        case friends of
            []       -> ""
            [friend] -> "and " <> getName friend
            (friend : friends) ->  getName friend  <> ", " <> formatFriendList friends

-- countSenders :: GreetingMessage -> Int
-- countSenders GreetingMessage {..} = length greetingFrom  

{-|
A test message that you can use to see how messages are formatted.

>>> testMessage
"Welcome Friendos, from your friends: test example, example2, and example3"
-}
testMessage :: String
testMessage = 
    formatMessage $ defaultMessage {greetingFrom = [Name "test example", Name "example2", Name  "example3"]}