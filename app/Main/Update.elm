module Main.Update exposing (..)

import Json.Decode as JD
import Json.Encode as JE
import Utils.PostUtils exposing (Blog, getPosts, postsDecoder, encodeBlogId)
import Utils.Ports exposing (postBlogSuccess, removeBlog)
import Main.Model exposing (Model)
import Main.Routing exposing (Route)
import Main.Messages exposing (Msg(..))
import Navigation
import CreatePost.Update
import CreatePost.Messages


initModel : Route -> Model
initModel route =
    { blogs = [], createPage = CreatePost.Update.init |> fst, route = route, loggedIn = False }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetPosts blogsResponse ->
            { model | blogs = blogsResponse } ! []

        ShowBlog id url ->
            model ! [ Navigation.newUrl url ]

        CreateBlog ->
            model ! [ Navigation.newUrl "#CreatePost" ]

        CreatePostMsg msg ->
            let
                ( createModel, newMsg ) =
                    CreatePost.Update.update msg model.createPage
            in
                { model | createPage = createModel } ! [ Cmd.map CreatePostMsg newMsg ]

        RemoveBlog currentBlog ->
            let
                body =
                    encodeBlogId currentBlog
                        |> JE.encode 0
            in
                model ! [ removeBlog body ]

        DecodeError err ->
            let
                _ =
                    Debug.log "Error" err
            in
                model ! []

        Error err ->
            let
                _ =
                    Debug.log "Error" "error"
            in
                model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    combinePostBlogSuccesses [ Just createPostMessage, Just GetPosts ]
        |> Sub.batch


createPostMessage : List Blog -> Msg
createPostMessage =
    CreatePost.Messages.CreateSuccess >> CreatePostMsg


combinePostBlogSuccesses : List (Maybe (List Blog -> Msg)) -> List (Sub Msg)
combinePostBlogSuccesses msgs =
    List.map (decodePostResponse >> postBlogSuccess) msgs


decodePostResponse : Maybe (List Blog -> Msg) -> JD.Value -> Msg
decodePostResponse msg json =
    case JD.decodeValue postsDecoder json of
        Err err ->
            DecodeError err

        Ok blogs ->
            case msg of
                Nothing ->
                    GetPosts blogs

                Just msg ->
                    msg blogs
