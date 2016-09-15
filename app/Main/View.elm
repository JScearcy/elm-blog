module Main.View exposing (view)

import Html exposing (a, div, text, section, Html)
import Html.Attributes exposing (class, href, style)
import Main.Model exposing (Model)
import Main.Update exposing (Msg)
import Utils.PostUtils exposing (Blog)

view : Model -> Html Msg
view model =
    section [ class "row row-centered" ] <|
        List.map blogViewHelper model.blogs


blogViewHelper : Blog -> Html Msg
blogViewHelper { img, title, url } =
    a [ href url, class "col-md-3 col-sm-2 col-centered blog-container", style [ imageHelper img ] ]
        [ div [ class "blog-header" ]
            [ text title ]
        ]


imageHelper : String -> ( String, String )
imageHelper url =
    ( "background-image", "url(" ++ url ++ ")" )