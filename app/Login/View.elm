module Login.View exposing (view)

import Html exposing (Html, div, input, button, text, form, h1)
import Html.Attributes exposing (placeholder, class, type', value, id)
import Html.Events exposing (onInput, onClick)
import Main.Model exposing (Model)
import Main.Messages exposing (Msg(..))


view : Model -> Html Msg
view model =
    div
        []
        [ h1
            [ class "jumbotron" ]
            [ text "Login" ]
        , form
            [ class "login-page" ]
            [ div
                [ class "form-group" ]
                [ input [ onInput UsernameInput, placeholder "Username", class "form-control", value model.username ] [] ]
            , div
                [ class "form-group" ]
                [ input [ onInput PasswordInput, placeholder "Password", class "form-control", type' "password", value model.password ] [] ]
            , input [ onClick Login, class "btn btn-primary pull-right", type' "submit", value "Login", id "login-submit" ] []
            ]
        ]
