module Login.View exposing (view)

import Html exposing (Html, div, input, button, text)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput, onClick)
import Login.Model exposing (Model)
import Login.Messages exposing (Msg(..))


view : Model -> Html Msg
view model =
    div
        []
        [ input [ onInput UsernameInput, placeholder "Username" ] []
        , input [ onInput PasswordInput, placeholder "Password" ] []
        , button [ onClick Login ] [ text "Login" ]
        ]
