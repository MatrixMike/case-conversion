{-# OPTIONS_GHC -fwarn-missing-signatures #-}

module Main where

import Text.CaseConversion

main :: IO ()
main = do
  putStrLn "starting -> please supply input... in CamelCase"
  interact (unlines . map (toCase Snake . fromCase Camel) . lines)
  putStrLn "finishing..."
