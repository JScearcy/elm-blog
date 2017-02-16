module Utils.PostUtils exposing (RawBlog, Blog, getPosts, encodeBlog, postsDecoder, encodeBlogId, encodeUser, tokenStringDecoder, resultToMsg, rawBlogToBlog)

import Json.Decode as Json exposing (at)
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as JE
import Http


type alias Blog =
    { id : Int
    , title : String
    , body : String
    , img : String
    , url : String
    , updated : String
    }


type alias RawBlog =
    { postId : Int
    , postTitle : String
    , postBody : String
    , imgUrl : String
    , linkUrl : String
    , editDate : String
    }


rawBlogToBlog : RawBlog -> Blog
rawBlogToBlog raw =
    { id = raw.postId
    , title = raw.postTitle
    , body = raw.postBody
    , img = raw.imgUrl
    , url = raw.linkUrl
    , updated = raw.editDate
    }


encodeUser : { username : String, password : String } -> JE.Value
encodeUser user =
    JE.object
        [ ( "username", JE.string user.username )
        , ( "password", JE.string user.password )
        ]


encodeBlog : { body : String, title : String, img : String, token : Maybe String } -> JE.Value
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
        |> required "editDate" Json.string


tokenStringDecoder : Json.Decoder String
tokenStringDecoder =
    Json.at [ "access_token" ] Json.string


getPosts : (List Blog -> msg) -> (Http.Error -> msg) -> Cmd msg
getPosts msg errMsg =
    Http.get "/CreatePost/Posts/" postsDecoder
        |> Http.send (resultToMsg msg errMsg)


getPost : String -> (Blog -> msg) -> (Http.Error -> msg) -> Cmd msg
getPost url msg errMsg =
    Http.get url postDecoder
        |> Http.send (resultToMsg msg errMsg)


resultToMsg : (a -> msg) -> (Http.Error -> msg) -> Result Http.Error a -> msg
resultToMsg success error res =
    case res of
        Err a ->
            error a

        Ok a ->
            success a
