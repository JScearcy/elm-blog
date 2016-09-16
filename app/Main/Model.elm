module Main.Model exposing (..)

import Main.Routing
import Utils.PostUtils exposing (Blog)


type alias Model =
    { blogs : List Blog
    , route : Main.Routing.Route
    }
