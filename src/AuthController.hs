{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE TypeOperators     #-}

module AuthController where

import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant
import           Data.Text                  (Text)
import Login 
import Logout 

controller :: Server AuthController
controller = login :<|> logout
    where
        login = handleLogin
        logout = handleLogout

type AuthController = "login" :> Capture "username" Text :> Capture "password" Text :> Get '[PlainText] Text
                 :<|> "logout" :> Get '[PlainText] Text
