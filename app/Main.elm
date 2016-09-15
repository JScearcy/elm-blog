module Main exposing (..)

import Html exposing (Html, text, section, div, p, a)
import Html.Attributes exposing (class, href, style)
import Html.App as App
import Json.Decode as Json
import Json.Decode.Pipeline exposing (..)
import Http
import Task


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- model


type alias Model =
    { blogs : List Blog
    }


type alias Blog =
    { id : Int
    , title : String
    , body : String
    , img : String
    , url : String
    }


init : ( Model, Cmd Msg )
init =
    { blogs = [] } ! [ getPosts ]



-- update


type Msg
    = Create
    | GetPosts (List Blog)
    | Error Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Create ->
            model ! []

        GetPosts blogsResponse ->
            { model | blogs = blogsResponse } ! []

        Error err ->
            let
                _ = 
                    Debug.log "Error" "error"
            in
                model ! []



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- view


view : Model -> Html Msg
view model =
    section [ class "row row-centered" ] <|
        List.map blogViewHelper model.blogs


blogViewHelper : Blog -> Html Msg
blogViewHelper { img, title, url } =
    a [ href url, class "col-md-3 col-sm-2 col-centered blog-container", style [ imageHelper img ] ]
        [ div [ class "blog-header" ]
            [ text title ]
        ]


imageHelper : String -> ( String, String )
imageHelper url =
    ( "background-image", "url(" ++ url ++ ")" )


postsDecoder : Json.Decoder (List Blog)
postsDecoder =
    Json.list postDecoder

postDecoder : Json.Decoder Blog
postDecoder =
    decode Blog
        |> required "postId" Json.int
        |> required "postTitle" Json.string
        |> required "postBody" Json.string
        |> required "imgUrl" Json.string
        |> required "linkUrl" Json.string

getPosts : Cmd Msg
getPosts =
    Http.get postsDecoder "/CreatePost/Posts/" 
        |> Task.perform Error GetPosts
