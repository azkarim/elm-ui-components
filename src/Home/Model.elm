module Home.Model exposing (Model, init)

import Home.Data as Data
import Home.Msg as Home
import UI.Drawer as Drawer
import UI.Select as Select
import UI.Tab as Tab


type alias Model =
    { drawer : Drawer.Config Home.Msg
    , selectFruitState : Select.State Data.Option
    , userSettingsTab : Tab.State Data.UserSettingsTab
    }


init : Model
init =
    Model initDrawer Select.init (Tab.init Data.Account)


initDrawer : Drawer.Config Home.Msg
initDrawer =
    { isDrawerVisible = Nothing
    , drawerHeight = 400
    , onTap = Home.ToggleDrawer
    }
