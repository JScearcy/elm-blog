module Main.Model exposing (..)

import Main.Routing
import Utils.PostUtils exposing (Blog)
import CreatePost.Model
import Login.Model


type alias Model =
    { blogs : List Blog
    , createPage : CreatePost.Model.Model
    , login : Login.Model.Model
    , route : Main.Routing.Route
    , loggedIn : Bool
    }
