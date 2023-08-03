module Main where

import LoginSpec (tests)

import Test.HUnit
import qualified System.Exit as Exit

allTests :: Test
allTests = tests
 
main :: IO ()
main = do
    result <- runTestTT allTests
    if failures result > 0 then Exit.exitFailure else Exit.exitSuccess
