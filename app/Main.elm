module Main exposing (..)

import Html.App as App
import Main.View exposing (view)
import Main.Update exposing (subscriptions, update, init, Msg)


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
