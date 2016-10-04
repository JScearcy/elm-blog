module Main.Messages exposing (..)

import Utils.PostUtils exposing (Blog)
import CreatePost.Messages
import Http
import Jwt exposing (JwtError)


type Msg
    = GetPosts (List Blog)
    | ShowBlog Int String
    | CreateBlog
    | RemoveBlog Blog
    | CreatePostMsg CreatePost.Messages.Msg
    | LoginRequest
    | DecodeError String
    | Error Http.Error
    | UsernameInput String
    | PasswordInput String
    | Login
    | LoginFail JwtError
    | LoginSuccess String
