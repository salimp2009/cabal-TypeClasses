{-# LANGUAGE ExplicitForAll #-}
{-# LANGUAGE KindSignatures #-}
module TypeClasses.HigherKindedTypes where

import Data.Kind
import qualified Data.List.NonEmpty as NonEmpty

toCSV :: forall (t:: Type -> Type) (a::Type)
       . (Foldable t, Show a) 
      => t a -> String 
toCSV = 
  let 
    addField :: Show a => String -> a -> String
    addField s a = s <> "," <> show a
    
    dropLeadingComma :: String -> String
    dropLeadingComma s =
      case s of 
        ',' : s' -> s'
        _        -> s
  in dropLeadingComma . foldl addField mempty

csvTest ::String
csvTest  =
  let 
    plainList = toCSV [1..3]  
    nonEmptyList = toCSV $ 1 NonEmpty.:| [2..4]
  in unlines [plainList, nonEmptyList] 