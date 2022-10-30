
module Haskellbook.Examples.SortedList 
    ( SortedList(getSorted)
    , makeSortedList
    , minimum
    ) where
{- 
  Example for a Smart Constructor
  to avoid exporting internals of a module 
  as minimum as possible
  we only export SortedList field selector but not data constructor
  that way a user of this lib will have to makeSortedList
  to create that is for sure not empty and sorted
-}
import Data.List(sort)
import Prelude hiding (minimum)

newtype SortedList = SortedList { getSorted :: [Int] } deriving Show

-- | the problems here ;
-- empty list and list not being sorted
minimum :: SortedList -> Int
minimum (SortedList nums) = head nums

makeSortedList :: [Int] -> Maybe SortedList
makeSortedList [] = Nothing
makeSortedList numbers = Just $ SortedList (sort numbers)
