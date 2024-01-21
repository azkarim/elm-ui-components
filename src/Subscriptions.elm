module Subscriptions exposing (subscriptions)

import Components.Subscriptions as Components
import Msg exposing (Msg(..))
import Preview.Subscriptions as Preview
import State exposing (State)


subscriptions : State -> Sub Msg
subscriptions state =
    mapMsg ComponentsMsg (Components.subscriptions state.components)
        ++ mapMsg PreviewMsg (Preview.subscriptions state.preview)
        |> Sub.batch


mapMsg : (a -> msg) -> List (Sub a) -> List (Sub msg)
mapMsg toMsg =
    List.map (Sub.map toMsg)
