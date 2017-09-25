{-# OPTIONS_GHC -fwarn-missing-signatures #-}
module Text.CaseConversion (
 toCase
,fromCase
,WordCase (..)
,toCamelCase
,toSnakeCase
,toSpinalCase
,fromCamelCase
,fromSnakeCase
,fromSpinalCase
,convertCase
) where

import Data.Char
import Data.List

data WordCase = Camel | Snake | Spinal

--toCase :: Camel = toCamelCase
toCase Camel = toCamelCase
toCase Snake = toSnakeCase
toCase Spinal = toSpinalCase

fromCase Camel = fromCamelCase
fromCase Snake = fromSnakeCase
fromCase Spinal = fromSpinalCase

toCamelCase (c:cs) = concat (c:map (\(c:cs)->toUpper c: map toLower cs) cs)
toSnakeCase = toCharacterCase '_'
toSpinalCase = toCharacterCase '-'

fromCamelCase :: [Char] -> [[Char]]
fromCamelCase = splitBy isUpper
fromSnakeCase = fromCharacterCase '_'
fromSpinalCase = fromCharacterCase '-'

toCharacterCase c cs = concat (intersperse [c] (map (map toLower) cs)) 
fromCharacterCase c cs = head' ++ map tail tail'
  where
  (head',tail') = splitAt 1 cs'
  cs' = splitBy (==c) cs

splitBy :: (b -> Bool) -> [b] -> [[b]]
splitBy p = groupBy (const (not . p))

convertCase :: WordCase -> WordCase -> [Char] -> [Char]
convertCase c1 c2 = toCase c2 . fromCase c1  
