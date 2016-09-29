module Main.Messages exposing (..)

import Utils.PostUtils exposing (Blog)
import CreatePost.Messages
import Http


type Msg
    = GetPosts (List Blog)
    | ShowBlog Int String
    | CreateBlog
    | RemoveBlog Blog
    | CreatePostMsg CreatePost.Messages.Msg
    | DecodeError String
    | Error Http.Error
