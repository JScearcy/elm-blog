module Main.Update exposing (..)

import Http
import Utils.PostUtils exposing (Blog, getPosts)
import Main.Model exposing (Model)
import Main.Routing exposing (Route)
import Navigation


type Msg
    = GetPosts (List Blog)
    | ShowBlog Int String
    | CreateBlog
    | Error Http.Error


initModel : Route -> Model
initModel route =
    { blogs = [], route = route }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetPosts blogsResponse ->
            { model | blogs = blogsResponse } ! []
        
        ShowBlog id url ->
            model ! [ Navigation.newUrl url ]
        
        CreateBlog ->
            model ! [ Navigation.newUrl "#CreatePost" ]

        Error err ->
            let
                _ = 
                    Debug.log "Error" "error"
            in
                model ! []
                

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none