module State exposing (State, init)

import Home.Model as Home
import Route exposing (Route)


type alias State =
    { route : Route
    , home : Home.Model
    }


init : State
init =
    { route = Route.Home
    , home = Home.init
    }
