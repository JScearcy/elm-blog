module CreatePost exposing (..)

import Html.App as App
import CreatePost.Update exposing (update, init, Msg(..), subscriptions)
import CreatePost.View exposing (view)


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
