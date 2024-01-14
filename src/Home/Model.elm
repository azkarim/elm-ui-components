module Home.Model exposing (Model, init)

import Home.Data as Data
import Home.Msg as Home
import UI.Drawer as Drawer
import UI.Select as Select


type alias Model =
    { drawer : Drawer.Config Home.Msg
    , selectFruitState : Select.State Data.Option
    }


init : Model
init =
    Model initDrawer Select.init


initDrawer : Drawer.Config Home.Msg
initDrawer =
    { isDrawerVisible = Nothing
    , drawerHeight = 400
    , onTap = Home.ToggleDrawer
    }
