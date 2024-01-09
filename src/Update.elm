module Update exposing (update)

import Msg exposing (Msg)
import State exposing (State)


update : Msg -> State -> ( State, Cmd Msg )
update _ _ =
    ( State.init, Cmd.none )
