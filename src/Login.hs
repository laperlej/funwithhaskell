{-# LANGUAGE OverloadedStrings #-}

module Login where

import           Control.Monad.IO.Class
import           Crypto.BCrypt as BC
import         Data.ByteString.Char8
import           Data.Text                  (Text)
import qualified Data.Text                  as T
import           Servant

type Hash = ByteString

handlePassword :: Text -> Servant.Handler String
handlePassword plainText = do
    hash <- liftIO $ hash plainText
    case hash of
        Nothing -> throwError err500 { errBody = "Error hashing password" }
        Just h -> return $ T.unpack $ T.pack $ show h

hash :: Text -> IO (Maybe Hash)
hash plainText = do
    let p = Data.ByteString.Char8.pack . T.unpack
    hashPasswordUsingPolicy slowerBcryptHashingPolicy (asBytes plainText)

validatePassword :: Text -> Hash -> Servant.Handler Bool
validatePassword plainText hash = do
    return $ BC.validatePassword hash (asBytes plainText)

asBytes :: Text -> ByteString
asBytes = Data.ByteString.Char8.pack . T.unpack

