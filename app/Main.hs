{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE TypeOperators     #-}

module Main (main) where

import         AuthController

import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant
import           Data.Text                  (Text)
import System.Exit
import System.Posix.Signals
import Control.Concurrent
import qualified Control.Exception as E


authController :: Proxy AuthController
authController = Proxy

app :: Application
app = serve authController controller

main :: IO ()
main = do
    -- install signal handler for Ctrl-C
    tid <- myThreadId
    _ <- installHandler keyboardSignal (Catch (E.throwTo tid ExitSuccess)) Nothing
    threadDelay 10000000
    Prelude.putStrLn "Starting server on port 8080"
    run 8080 app
