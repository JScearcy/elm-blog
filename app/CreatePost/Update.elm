module CreatePost.Update exposing (update, init, Msg(..), subscriptions)

import CreatePost.Model exposing (Model)


init : ( Model, Cmd Msg )
init =
    { input = "" } ! []


type Msg
    = TextChange String
    | Post


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TextChange text ->
            { model | input = text } ! []

        Post ->
            let
                _ =
                    Debug.log "model" model
            in
                model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
