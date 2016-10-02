module Login.Update exposing (..)

import Login.Messages exposing (Msg(..))
import Login.Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UsernameInput username ->
            { model | username = username } ! []

        PasswordInput password ->
            { model | password = password } ! []

        Login ->
            model ! []
