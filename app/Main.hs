{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE TypeOperators     #-}
module Main (main) where

import         Hello
import         User
import         Login

import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant
import           Data.Text                  (Text)
import System.Exit
import System.Posix.Signals
import Control.Concurrent
import qualified Control.Exception as E

server :: Server MyAPI
server = hello :<|> user :<|> password
    where
        hello = handleHello
        user = handleUser
        password = handlePassword

type MyAPI  = Get '[PlainText] Text
            :<|> "user" :> Capture "name" Text :> Capture "age" Int :> Get '[JSON] User
            :<|> "password" :> Capture "plaintext" Text :> Get '[JSON] String

myAPI :: Proxy MyAPI
myAPI = Proxy

app :: Application
app = serve myAPI server

main :: IO ()
main = do
    tid <- myThreadId
    _ <- installHandler keyboardSignal (Catch (E.throwTo tid ExitSuccess)) Nothing
    threadDelay 10000000
    Prelude.putStrLn "Starting server on port 8080"
    run 8080 app
