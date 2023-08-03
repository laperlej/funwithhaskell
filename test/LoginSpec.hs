{-# LANGUAGE OverloadedStrings #-}

module LoginSpec where

import Login

import Test.HUnit

testLogin :: Test
testLogin = TestCase (assertEqual "test" "a" "a")

tests :: Test
tests = TestList [TestLabel "testLogin" testLogin]
