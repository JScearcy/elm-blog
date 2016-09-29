port module Utils.Ports exposing (..)

import Json.Decode as JD


port postBlog : String -> Cmd a


port removeBlog : String -> Cmd a


port postBlogSuccess : (JD.Value -> msg) -> Sub msg
