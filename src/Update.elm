module Update exposing (update)

import Msg exposing (Msg(..))
import Page.Components.Update as Components
import Page.Preview.Update as Preview
import State exposing (State)


update : Msg -> State -> ( State, Cmd Msg )
update msg state =
    case msg of
        ComponentsMsg componentsMsg ->
            Components.update componentsMsg state.components
                |> (\( m, _ ) -> ( { state | components = m }, Cmd.none ))

        PreviewMsg previewMsg ->
            Preview.update previewMsg state.preview
                |> (\( m, _ ) -> ( { state | preview = m }, Cmd.none ))

        OnUrlRequest ->
            ( state, Cmd.none )

        OnUrlChange ->
            ( state, Cmd.none )
