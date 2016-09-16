module CreatePost.View exposing (view)

import Html exposing (Html, div, textarea, button, text, input)
import Html.Attributes exposing (rows, class, id, placeholder)
import Html.Events exposing (onInput, onClick)
import Markdown exposing (Options, defaultOptions, toHtmlWith)
import CreatePost.Update exposing (Msg(..))
import CreatePost.Model exposing (Model)


options : Options
options =
    { defaultOptions | defaultHighlighting = Just "elm" }


view : Model -> Html Msg
view { body } =
    div []
        [ button [ class "submit-button", onClick Post ] [ text "Post" ]
        , div [ class "create-post-content" ]
            [ input [ onInput TitleChange, placeholder "Title" ] []
            , input [ onInput ImgChange, placeholder "Image Url" ] []
            , textarea [ rows 15, class "post-input", id "post-area", onInput BodyChange ] []
            ]
        , div [ class "create-post-content" ]
            [ toHtmlWith options [ class "preview" ] body
            ]
        ]
