module Home.View exposing (document)

import Browser exposing (Document)
import Home.Model as Home
import Home.Msg as Home
import Html.Styled exposing (Html, div, text, toUnstyled)


view : Home.Model -> Html Home.Msg
view _ =
    div [] [ text "Let's get started!" ]


document : Home.Model -> Document Home.Msg
document model =
    { title = "Home"
    , body = [ view model |> toUnstyled ]
    }
