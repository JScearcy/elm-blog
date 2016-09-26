module Main.Routing exposing (..)

import Navigation
import UrlParser exposing (..)


type Route
    = SingleBlog Int
    | AllBlogs
    | Create
    | NotFoundRoute


routeMatchers : Parser (Route -> a) a
routeMatchers =
    oneOf
        [ format SingleBlog (s "#CreatePost" </> s "Post" </> int)
        , format Create (s "#CreatePost")
        , format AllBlogs (s "")
        ]


pathParser : Navigation.Location -> Result String Route
pathParser location =
    location.hash
        |> parse identity routeMatchers


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser pathParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute
