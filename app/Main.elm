module Main exposing (..)

import Navigation
import Main.View exposing (view)
import Main.Update exposing (Flags, subscriptions, update, initModel)
import Main.Messages exposing (Msg(..))
import Main.Model exposing (Model)
import Main.Routing exposing (Route(..), pathParser)
import Utils.PostUtils exposing (Blog, getPosts)


main : Program Flags Model Msg
main =
    Navigation.programWithFlags UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Flags -> Navigation.Location -> ( Model, Cmd Msg )
init flags location =
    let
        currentRoute =
            pathParser location

        model =
            initModel flags currentRoute

        cmds =
            if List.length model.blogs <= 0 then
                [ getPosts GetPosts Error ]
            else
                []
    in
        model ! cmds
