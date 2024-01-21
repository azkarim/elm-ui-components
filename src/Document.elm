module Document exposing (document)

import Browser exposing (Document)
import Components.View as Components
import Html
import Msg exposing (Msg(..))
import NotFound
import Preview.View as Preview
import Route
import State exposing (State)


document : State -> Browser.Document Msg
document ({ route } as state) =
    case route of
        Route.Components ->
            state.components
                |> Components.document
                |> mapMsg ComponentsMsg

        Route.Preview ->
            state.preview
                |> Preview.document
                |> mapMsg PreviewMsg

        Route.NotFound ->
            NotFound.document


mapMsg : (docMsg -> msg) -> Browser.Document docMsg -> Browser.Document msg
mapMsg tagMsg { title, body } =
    body
        |> List.map (Html.map tagMsg)
        |> Document title
