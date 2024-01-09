module Document exposing (document)

import Browser exposing (Document)
import Home.View as Home
import Html
import Msg exposing (Msg(..))
import Route
import State exposing (State)


document : State -> Browser.Document Msg
document ({ route } as state) =
    case route of
        Route.Home ->
            state.home
                |> Home.document
                |> mapMsg HomeMsg


mapMsg : (docMsg -> msg) -> Browser.Document docMsg -> Browser.Document msg
mapMsg tagMsg { title, body } =
    body
        |> List.map (Html.map tagMsg)
        |> Document title
