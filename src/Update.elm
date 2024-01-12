module Update exposing (update)

import Home.Update as Home
import Msg exposing (Msg(..))
import State exposing (State)


update : Msg -> State -> ( State, Cmd Msg )
update msg state =
    case msg of
        HomeMsg homeMsg ->
            Home.update homeMsg state.home
                |> (\( m, _ ) -> ( { state | home = m }, Cmd.none ))

        OnUrlRequest ->
            ( state, Cmd.none )

        OnUrlChange ->
            ( state, Cmd.none )
