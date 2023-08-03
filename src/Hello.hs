{-# LANGUAGE OverloadedStrings #-}

module Hello where

import           Servant
import           Data.Text                  (Text)

handleHello :: Servant.Handler Text
handleHello = return "Hello world"

