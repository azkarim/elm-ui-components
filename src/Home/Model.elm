module Home.Model exposing (Model, init)

import Home.Drawer as Drawer
import Home.Msg as Home


type alias Model =
    { drawer : Drawer.Config Home.Msg
    }


init : Model
init =
    Model initDrawer


initDrawer : Drawer.Config Home.Msg
initDrawer =
    { isVisible = False
    , onTap = Home.ToggleDrawer
    }
