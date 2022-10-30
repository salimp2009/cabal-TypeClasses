module ModuleDemo where
import qualified Haskellbook.Examples as Examples

georgesEmailAddress :: Maybe String
georgesEmailAddress =
  case Examples.lookupUser "george" of
    Nothing -> Nothing
    Just unauthenticatedGeorge ->
      case Examples.authenticate unauthenticatedGeorge "secret" of
        Nothing     -> Nothing
        Just george -> 
          Just $ Examples.getUserEmailAddress george

friendlyEmail :: String -> String          
friendlyEmail emailAddress = 
  Examples.formatMessage Examples.GreetingMessage
    { Examples.greetingSalutation = Examples.Salutation "you got mail: "
    , Examples.greetingTo = Examples.Name emailAddress
    , Examples.greetingFrom = [Examples.Name "Haskell mailing.list"]
    }

-- | use case;
-- >>>demoEmail georgesEmailAddress 
-- "you got mail:  gbird2015@example.com, from: Haskell mailing.list"
demoEmail :: Maybe String -> String
demoEmail =
  maybe "unknow user!" friendlyEmail      

