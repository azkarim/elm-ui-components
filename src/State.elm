module State exposing (State, init)

import Page.Components.Model as Components
import Page.Preview.Init as Preview
import Page.Preview.Model as Preview
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
