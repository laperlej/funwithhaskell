module User where

import           Data.Text                  (Text)

data User = User
    { username :: Text
    , password :: Text
    } deriving (Eq, Show, Read)
