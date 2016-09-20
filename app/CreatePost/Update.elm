module CreatePost.Update exposing (update, init, Msg(..), subscriptions)

import CreatePost.Model exposing (Model)
import Utils.PostUtils exposing (Blog, createBlog)
import Http


init : ( Model, Cmd Msg )
init =
    { body = "", title = "", img = "" } ! []


type Msg
    = BodyChange String
    | TitleChange String
    | ImgChange String
    | Post
    | CreateSuccess (List Blog)
    | CreateFail Http.Error


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
                blogPost =
                    Blog 0 model.title model.body model.img ""
            in
                model ! [ createBlog blogPost CreateSuccess CreateFail ]

        CreateSuccess blogs ->
            let
                _ =
                    Debug.log "Blogs" blogs
            in
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
