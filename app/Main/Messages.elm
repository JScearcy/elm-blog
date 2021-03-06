module Main.Messages exposing (..)

import Utils.PostUtils exposing (Blog)
import CreatePost.Messages
import Http
import Jwt exposing (JwtError)
import Navigation


type Msg
    = GetPosts (List Blog)
    | ShowBlog Int String
    | CreateBlog
    | RemoveBlog Blog
    | CreatePostMsg CreatePost.Messages.Msg
    | RouteRequest String
    | DecodeError String
    | Error Http.Error
    | UsernameInput String
    | PasswordInput String
    | Login
    | LoginFail JwtError
    | LoginSuccess String
    | UrlChange Navigation.Location
