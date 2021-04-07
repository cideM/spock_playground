{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Control.Monad.Trans
import Data.IORef
import qualified Data.Text as T
import Web.Spock
import Web.Spock.Config

data MySession = EmptySession

data MyAppState = DummyAppState (IORef Int)

main :: IO ()
main =
  do
    ref <- newIORef 0
    spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ref)
    runSpock 8080 (spock spockCfg app)

app :: SpockM () MySession MyAppState ()
app =
  do
    get root $
      text "Hello World!"
    get ("hello" <//> var) $ \(name :: Int) ->
      do
        (DummyAppState ref) <- getState
        visitorNumber <- liftIO $ atomicModifyIORef' ref $ \i -> (i + 1, i + 1)
        text ("Hello " <> T.pack (show name) <> ", you are visitor number " <> T.pack (show visitorNumber))
