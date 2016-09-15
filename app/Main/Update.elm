module Main.Update exposing (..)

import Http
import Utils.PostUtils exposing (Blog, getPosts)
import Main.Model exposing (Model)


type Msg
    = GetPosts (List Blog)
    | Error Http.Error


init : ( Model, Cmd Msg )
init =
    { blogs = [] } ! [ getPosts GetPosts Error ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetPosts blogsResponse ->
            { model | blogs = blogsResponse } ! []

        Error err ->
            let
                _ = 
                    Debug.log "Error" "error"
            in
                model ! []
                

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

