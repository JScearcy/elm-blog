module Main exposing (..)

import Navigation
import Main.View exposing (view)
import Main.Update exposing (subscriptions, update, initModel)
import Main.Messages exposing (Msg(..))
import Main.Model exposing (Model)
import Main.Routing exposing (Route(..), pathParser)
import Utils.PostUtils exposing (Blog, getPosts)


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            pathParser location
    in
        initModel currentRoute ! [ getPosts GetPosts Error ]
