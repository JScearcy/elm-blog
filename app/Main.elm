module Main exposing (..)

import Navigation
import Main.View exposing (view)
import Main.Update exposing (subscriptions, update, initModel)
import Main.Messages exposing (Msg(..))
import Main.Model exposing (Model)
import Main.Routing exposing (Route(..), routeFromResult, parser)
import Utils.PostUtils exposing (Blog, getPosts)


main : Program Never
main =
    Navigation.program parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }


init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            routeFromResult result
    in
        initModel currentRoute ! [ getPosts GetPosts Error ]


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            routeFromResult result
    in
        { model | route = currentRoute } ! []
