module CreatePost.Messages exposing (Msg(..))

import Http
import Utils.PostUtils exposing (Blog)


type Msg
    = BodyChange String
    | TitleChange String
    | ImgChange String
    | Post
    | CreateSuccess (List Blog)
    | CreateFail Http.Error
