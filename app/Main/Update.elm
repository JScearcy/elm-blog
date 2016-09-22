module Main.Update exposing (..)

import Http
import Utils.PostUtils exposing (Blog, getPosts)
import Utils.Ports exposing (postBlogResponse)
import Main.Model exposing (Model)
import Main.Routing exposing (Route)
import Navigation
import CreatePost.Update exposing (init)
import CreatePost.Messages


type Msg
    = GetPosts (List Blog)
    | ShowBlog Int String
    | CreateBlog
    | CreatePostMsg CreatePost.Messages.Msg
    | Error Http.Error


initModel : Route -> Model
initModel route =
    { blogs = [], createPage = init |> fst, route = route }


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

        Error err ->
            let
                _ =
                    Debug.log "Error" "error"
            in
                model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ postBlogResponse (\() -> CreatePostMsg <| CreatePost.Messages.CreateSuccess [])
        ]
