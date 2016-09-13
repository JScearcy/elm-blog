import Html exposing (Html, text, section, div, p, a)
import Html.Attributes exposing (class, href, style)
import Html.App as App



main : Program Never
main =
    App.program 
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }


-- model
type alias Model =
    { blogs: List Blog
    }

type alias Blog =
    { title: String
    , url: String    
    , img: String    
    }

init : ( Model, Cmd Msg )
init =
    Model [ { title = "Blog1", url = "http://localhost:5000", img = "https://i.imgur.com/aha9awt.png" }
          , { title = "Blog2", url = "http://localhost:5000", img = "https://i.imgur.com/aha9awt.png" }
          , { title = "Blog3", url = "http://localhost:5000", img = "https://i.imgur.com/aha9awt.png" }
          , { title = "Blog4", url = "http://localhost:5000", img = "https://i.imgur.com/aha9awt.png" } 
          ]
          ! []


-- update
type Msg 
    = Create

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Create ->
            model ! []


-- subscriptions
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- view


view : Model -> Html Msg
view model =
    section [ class "row" ]
        <| List.map blogViewHelper model.blogs

blogViewHelper : Blog -> Html Msg
blogViewHelper blog =
    a [ href blog.url, class "col-md-3 col-sm-2 blog-container", style [("background-image", blog.img) ] ] 
        [ div [  ] 
            [ p [] [ text blog.title ] ]
        ]
