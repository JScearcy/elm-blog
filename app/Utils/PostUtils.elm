module Utils.PostUtils exposing (Blog, getPosts)

import Json.Decode as Json
import Json.Decode.Pipeline exposing (decode, required)
import Http
import Task


type alias Blog =
    { id : Int
    , title : String
    , body : String
    , img : String
    , url : String
    }


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