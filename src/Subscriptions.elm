module Subscriptions exposing (subscriptions)

import Browser.Events as Events
import Home.Msg as Home
import Json.Decode as D
import Msg exposing (Msg(..))
import State exposing (State)


subscriptions : State -> Sub Msg
subscriptions { home } =
    if home.selectFruitState.isVisible then
        Events.onClick (D.succeed <| HomeMsg Home.TappedBody)

    else
        Sub.none
