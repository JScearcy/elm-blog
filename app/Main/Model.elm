module Main.Model exposing (..)

import Main.Routing
import Utils.PostUtils exposing (Blog)
import CreatePost.Model


type alias Model =
    { blogs : List Blog
    , createPage : CreatePost.Model.Model
    , route : Main.Routing.Route
    , routeHistory : List Main.Routing.Route
    , loggedIn : Bool
    , username : String
    , password : String
    , token : Maybe String
    }
