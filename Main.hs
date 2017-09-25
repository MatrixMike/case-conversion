{-# OPTIONS_GHC -fwarn-missing-signatures #-}

module Main where
import Text.CaseConversion

main :: IO()
main = interact (unlines . map  (toCase Snake . fromCase Camel)  . lines ) 

