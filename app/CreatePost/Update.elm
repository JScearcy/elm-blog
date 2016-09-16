module CreatePost.Update exposing (update, init, Msg(..), subscriptions)

import CreatePost.Model exposing (Model)


init : ( Model, Cmd Msg )
init =
    { body = "", title = "", img = "" } ! []


type Msg
    = BodyChange String
    | TitleChange String
    | ImgChange String
    | Post


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BodyChange text ->
            { model | body = text } ! []

        TitleChange title ->
            { model | title = title } ! []

        ImgChange imgUrl ->
            { model | img = imgUrl } ! []

        Post ->
            let
                _ =
                    Debug.log "model" model
            in
                model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
