{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Main (main) where

import Brick
import Brick.AttrMap
import Brick.Main
import Brick.Types
import Brick.Widgets.Core
import Graphics.Vty.Input.Events
import Graphics.Vty.Attributes

import Lens.Micro
import Lens.Micro.TH (makeLenses)
import Lens.Micro.Mtl (use, (.=))

import Network.HTTP.Req

buildInitialState :: IO TuiState
buildInitialState = do 
    pure TuiState { _text = ["Fetching..."] }

newtype TuiState = TuiState
    { _text :: [String]
    } deriving (Show, Eq)
makeLenses ''TuiState

theMap :: AttrMap
theMap = attrMap defAttr []

drawTui :: TuiState -> [Widget ()]
drawTui ts = [vBox $ map drawMsg $ _text ts]

drawMsg :: String -> Widget n
drawMsg = str

appEvent :: BrickEvent () e -> EventM () TuiState ()
appEvent e = do
    t <- use text
    text .= ["Yes", "No"]
    case e of
        VtyEvent vtye -> do
            case vtye of
                EvKey KEsc [] -> halt
                EvKey (KChar 'q') [] -> halt
                EvKey (KChar 'y') [] -> return ()
        _ -> return ()


tuiApp :: App TuiState e ()
tuiApp =
    App
        { appDraw = drawTui
        , appChooseCursor = neverShowCursor
        , appHandleEvent = appEvent
        , appStartEvent = return ()
        , appAttrMap = const theMap
        }

tui :: IO ()
tui = do
    initialState <- buildInitialState
    endState <- defaultMain tuiApp initialState
    print endState

main :: IO ()
main = tui
