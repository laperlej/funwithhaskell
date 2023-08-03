{-# LANGUAGE DeriveGeneric     #-}
module User where

import           Data.Text                  (Text)
import           Data.Aeson
import           GHC.Generics
import           Servant

data User = User
    { name :: Text
    , age  :: Int
    } deriving (Eq, Show, Read, Generic)
instance FromJSON User
instance ToJSON User

handleUser :: Text -> Int -> Servant.Handler User
handleUser name age = return (User name age)

