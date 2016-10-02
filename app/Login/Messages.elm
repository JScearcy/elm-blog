module Login.Messages exposing (Msg(..))


type Msg
    = UsernameInput String
    | PasswordInput String
    | Login
