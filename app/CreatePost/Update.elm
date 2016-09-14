module CreatePost.Update exposing (update, init, Msg(..))

import CreatePost.Model exposing (Model)


init : ( Model, Cmd Msg )
init =
    { input = "" } ! []


type Msg
    = TextChange String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TextChange text ->
            { model | input = text } ! []
