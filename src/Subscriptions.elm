module Subscriptions exposing (subscriptions)

import Msg exposing (Msg)
import State exposing (State)


subscriptions : State -> Sub Msg
subscriptions _ =
    Sub.none
