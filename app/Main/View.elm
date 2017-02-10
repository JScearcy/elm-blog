module Main.View exposing (view)

import Html exposing (a, div, text, section, article, button, h1, ul, li, hr, footer, p, Html)
import Html.Attributes exposing (class, href, style, type_, id, property)
import Html.Events exposing (onClick)
import Main.Model exposing (Model)
import Main.Messages exposing (Msg(..))
import Main.Routing exposing (Route(..))
import Utils.PostUtils exposing (Blog)
import Markdown exposing (Options, defaultOptions, toHtmlWith)
import CreatePost.View
import Login.View
import Json.Encode


view : Model -> Html Msg
view model =
    article
        []
        [ div
            [ class "navbar navbar-inverse navbar-fixed-top" ]
            [ div
                [ class "container" ]
                [ div
                    [ class "navbar-header" ]
                    [ button
                        [ type_ "button", class "navbar-toggle" ]
                        []
                    , a [ class "navbar-brand nav-button", href "#" ] [ text "Jacob Scearcy" ]
                    ]
                , div
                    [ class "navbar-collapse collapse" ]
                    [ ul
                        [ class "nav navbar-nav" ]
                        [ li [] [ a [ id "home-btn", class "nav-button", href "#", onClick (RouteRequest "#") ] [ text "Home" ] ]
                        , li [] [ a [ id "login-btn", class "nav-button", href "#Login", onClick (RouteRequest "#Login") ] [ text "Login" ] ]
                        ]
                    ]
                ]
            ]
        , div
            [ class "container body-content" ]
            [ page model
            , hr [] []
            , footer [ property "innerHTML" (Json.Encode.string "&copy; 2017 - Jacob Scearcy") ] []
            ]
        ]


page : Model -> Html Msg
page model =
    case model.route of
        SingleBlog id ->
            section [ class "row row-centered" ]
                [ blogPage id model
                ]

        AllBlogs ->
            section [ class "row row-centered" ]
                [ createButtonRender model.token
                , div [] <| List.map blogsViewHelper model.blogs
                ]

        Create ->
            CreatePost.View.view model.createPage
                |> Html.map CreatePostMsg

        Main.Routing.Login ->
            Login.View.view model

        NotFoundRoute ->
            notFoundView


createButtonRender : Maybe String -> Html Msg
createButtonRender token =
    case token of
        Just token ->
            button [ onClick CreateBlog, class "pull-right submit-button" ] [ text "Create" ]

        Nothing ->
            div [] []


blogsViewHelper : Blog -> Html Msg
blogsViewHelper { img, title, url, id, updated } =
    let
        date =
            String.split "T" updated
                |> List.head
                |> Maybe.withDefault ""
    in
        div [ class "col-md-3 col-sm-2 col-centered blog-container", style [ imageHelper img ], onClick <| ShowBlog id <| "#" ++ url ]
            [ div [ class "blog-header" ]
                [ text (title ++ " " ++ date) ]
            ]


imageHelper : String -> ( String, String )
imageHelper url =
    ( "background-image", "url(" ++ url ++ ")" )


options : Options
options =
    { defaultOptions | defaultHighlighting = Just "elm" }


blogPage : Int -> Model -> Html Msg
blogPage id model =
    let
        currentBlog =
            blogFinder id model.blogs

        removeButton =
            case model.token of
                Just token ->
                    button [ onClick (RemoveBlog currentBlog) ] [ text "Remove" ]

                Nothing ->
                    div [] []
    in
        div []
            [ removeButton
            , h1 [] [ text currentBlog.title ]
            , div [ class "preview" ] [ toHtmlWith options [ class "preview" ] currentBlog.body ]
            ]


blogFinder : Int -> List Blog -> Blog
blogFinder id blogs =
    List.filter (\blog -> blog.id == id) blogs
        |> List.head
        |> maybeBlogResolve


maybeBlogResolve : Maybe Blog -> Blog
maybeBlogResolve maybeBlog =
    case maybeBlog of
        Just blog ->
            blog

        Nothing ->
            { id = 0, title = "Not Found", body = "", img = "", url = "", updated = "" }


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
