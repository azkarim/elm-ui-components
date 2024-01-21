module State exposing (State, init)

import Components.Model as Components
import Preview.Model as Preview
import Route exposing (Route)


type alias State =
    { route : Route
    , components : Components.Model
    , preview : Preview.Model
    }


init : State
init =
    { route = Route.NotFound
    , components = Components.init
    , preview = Preview.init
    }
