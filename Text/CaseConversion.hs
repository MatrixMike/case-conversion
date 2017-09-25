{-# OPTIONS_GHC -fwarn-missing-signatures #-}

module Text.CaseConversion
  ( toCase
  , fromCase
  , WordCase(..)
  , toCamelCase
  , toSnakeCase
  , toSpinalCase
  , fromCamelCase
  , fromSnakeCase
  , fromSpinalCase
  , convertCase
  ) where

import Data.Char
import Data.List

data WordCase
  = Camel
  | Snake
  | Spinal

toCase :: WordCase -> [[Char]] -> [Char]
toCase Camel = toCamelCase
toCase Snake = toSnakeCase
toCase Spinal = toSpinalCase

fromCase :: WordCase -> String -> [String]
fromCase Camel = fromCamelCase
fromCase Snake = fromSnakeCase
fromCase Spinal = fromSpinalCase

toCamelCase :: [[Char]] -> [Char]
toCamelCase (c:cs) = concat (c : map (\(c:cs) -> toUpper c : map toLower cs) cs)

toSnakeCase :: [[Char]] -> [Char]
toSnakeCase = toCharacterCase '_'

toSpinalCase :: [[Char]] -> [Char]
toSpinalCase = toCharacterCase '-'

--fromCamelCase :: [Char] -> [[Char]]
fromCamelCase :: String -> [String]
fromCamelCase = splitBy isUpper

fromSnakeCase :: [Char] -> [[Char]]
fromSnakeCase = fromCharacterCase '_'

fromSpinalCase :: [Char] -> [[Char]]
fromSpinalCase = fromCharacterCase '-'

toCharacterCase :: Char -> [[Char]] -> [Char]
toCharacterCase c cs = intercalate [c] (map (map toLower) cs)

--fromCharacterCase c cs = concat (intersperse [c] (map (map toLower) cs))
fromCharacterCase :: Eq p => p -> [p] -> [[p]]
fromCharacterCase c cs = head' ++ map tail tail'
  where
    (head', tail') = splitAt 1 cs'
    cs' = splitBy (== c) cs

splitBy :: (b -> Bool) -> [b] -> [[b]]
splitBy p = groupBy (const (not . p))

convertCase :: WordCase -> WordCase -> String -> String
convertCase c1 c2 = toCase c2 . fromCase c1

{-  in cabal repl
:browse
:info toCamelCase
 (toCamelCase (fromSnakeCase "hello_my_very_good_world"))
 -}
 
