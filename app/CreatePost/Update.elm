module CreatePost.Update exposing (update, init, subscriptions)

import CreatePost.Model exposing (Model)
import Utils.PostUtils exposing (Blog, encodeBlog)
import Utils.Ports exposing (postBlog, postBlogSuccess)
import Json.Encode as JE
import Http
import CreatePost.Messages exposing (Msg(..))


init : ( Model, Cmd Msg )
init =
    { body = "", title = "", img = "", token = Nothing } ! []


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
                body =
                    encodeBlog model
                        |> JE.encode 0
            in
                model ! [ postBlog body ]

        CreateSuccess blogs ->
            fst init ! []

        CreateFail err ->
            let
                _ =
                    Debug.log "Error" err
            in
                model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
