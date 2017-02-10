module Main.Routing exposing (..)

import Navigation
import UrlParser exposing (..)


type Route
    = SingleBlog Int
    | AllBlogs
    | Create
    | Login
    | NotFoundRoute


routeMatchers : Parser (Route -> a) a
routeMatchers =
    oneOf
        [ map SingleBlog (s "CreatePost" </> s "Post" </> int)
        , map Create (s "CreatePost")
        , map Login (s "Login")
        , map AllBlogs (s "")
        ]


pathParser : Navigation.Location -> Route
pathParser location =
    let
        currentPath =
            case parseHash routeMatchers location of
                Just route ->
                    route

                Nothing ->
                    AllBlogs
    in
        currentPath
