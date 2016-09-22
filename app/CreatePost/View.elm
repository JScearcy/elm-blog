module CreatePost.View exposing (view)

import Html exposing (Html, div, textarea, button, text, input)
import Html.Attributes exposing (rows, class, id, placeholder, value)
import Html.Events exposing (onInput, onClick)
import Markdown exposing (Options, defaultOptions, toHtmlWith)
import CreatePost.Messages exposing (Msg(..))
import CreatePost.Model exposing (Model)


options : Options
options =
    { defaultOptions | defaultHighlighting = Just "elm" }


view : Model -> Html Msg
view { title, img, body } =
    div []
        [ button [ class "submit-button", onClick Post ] [ text "Post" ]
        , div [ class "create-post-content" ]
            [ input [ onInput TitleChange, placeholder "Title", value title ] []
            , input [ onInput ImgChange, placeholder "Image Url", value img ] []
            , textarea [ rows 15, class "post-input", id "post-area", onInput BodyChange, value body ] []
            ]
        , div [ class "create-post-content" ]
            [ toHtmlWith options [ class "preview" ] body
            ]
        ]
