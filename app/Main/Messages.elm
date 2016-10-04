module Main.Messages exposing (..)

import Utils.PostUtils exposing (Blog)
import CreatePost.Messages
import Login.Messages
import Http


type Msg
    = GetPosts (List Blog)
    | ShowBlog Int String
    | CreateBlog
    | RemoveBlog Blog
    | CreatePostMsg CreatePost.Messages.Msg
    | LoginMsg Login.Messages.Msg
    | LoginRequest
    | DecodeError String
    | Error Http.Error
