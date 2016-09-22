port module Utils.Ports exposing (..)


port postBlog : String -> Cmd a


port postBlogResponse : (() -> msg) -> Sub msg
