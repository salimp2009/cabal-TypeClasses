module Haskellbook.Examples 
  ( module UserInfo 
  , module CreatingModules
  , SortedList.SortedList(getSorted)
  , SortedList.makeSortedList
  , SortedList.minimum
  )
  where

import Haskellbook.Examples.UserInfo as UserInfo
import Haskellbook.Examples.Introduction.CreatingModules
  as CreatingModules hiding (testMessage)

import qualified Haskellbook.Examples.SortedList as SortedList   

-- ^^  since we’ve used a qualified import we can’t directly export
-- the entire module. When you use a qualified import of a module 
-- we need to explicitly list everything from that module 
-- that we want to export in the export list: