module CreatePost.View exposing (view)

import Html exposing (Html, div, textarea)
import Html.Attributes exposing (rows, class, id)
import Html.Events exposing (onInput)
import Markdown exposing (Options, defaultOptions, toHtmlWith)
import CreatePost.Update exposing (Msg(..))
import CreatePost.Model exposing (Model)


options : Options
options =
    { defaultOptions | defaultHighlighting = Just "elm" }


view : Model -> Html Msg
view { input } =
    div []
        [ textarea [ rows 15, class "post-input", id "post-area",  onInput TextChange ] []
        , toHtmlWith options [ class "preview" ] input
        ]
