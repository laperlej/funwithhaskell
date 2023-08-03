{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE TypeOperators     #-}

module Logout where

import           Data.Text                  (Text)
import           Servant
import User
import qualified Data.Text as T

handleLogout :: Servant.Handler Text
handleLogout = do
    return $ T.pack "Logged out"
 
    
