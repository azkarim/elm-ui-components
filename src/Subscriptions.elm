module Subscriptions exposing (subscriptions)

import Browser.Events as Events
import Components.Msg as Components
import Json.Decode as D
import Msg exposing (Msg(..))
import State exposing (State)


subscriptions : State -> Sub Msg
subscriptions { components } =
    if components.selectFruitState.isVisible then
        Events.onClick (D.succeed <| ComponentsMsg Components.TappedBody)

    else
        Sub.none
