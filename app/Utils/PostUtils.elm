module Utils.PostUtils exposing (Blog, getPosts, encodeBlog, postsDecoder, encodeBlogId)

import Json.Decode as Json
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as JE
import Http
import Task


type alias Blog =
    { id : Int
    , title : String
    , body : String
    , img : String
    , url : String
    }


encodeBlog : { body : String, title : String, img : String } -> JE.Value
encodeBlog blog =
    JE.object
        [ ( "PostTitle", JE.string blog.title )
        , ( "PostBody", JE.string blog.body )
        , ( "ImgUrl", JE.string blog.img )
        ]


encodeBlogId : Blog -> JE.Value
encodeBlogId blog =
    JE.object
        [ ( "postId", JE.int blog.id )
        ]


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


getPosts : (List Blog -> msg) -> (Http.Error -> msg) -> Cmd msg
getPosts msg errMsg =
    Http.get postsDecoder "/CreatePost/Posts/"
        |> Task.perform errMsg msg


getPost : String -> (Blog -> msg) -> (Http.Error -> msg) -> Cmd msg
getPost url msg errMsg =
    Http.get postDecoder url
        |> Task.perform errMsg msg


postJson : Json.Decoder a -> String -> Http.Body -> Task.Task Http.Error a
postJson decoder url body =
    let
        request =
            { verb = "POST"
            , headers =
                [ ( "Content-Type", "application/x-www-form-urlencoded" )
                ]
            , url = url
            , body = body
            }
    in
        Http.fromJson decoder (Http.send Http.defaultSettings request)
