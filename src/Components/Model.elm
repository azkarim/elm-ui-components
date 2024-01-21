module Components.Model exposing (Model, init)

import Components.Data as Data
import Components.Msg as Components
import UI.Drawer as Drawer
import UI.Select as Select
import UI.Tab as Tab


type alias Model =
    { drawer : Drawer.Config Components.Msg
    , selectFruitState : Select.State Data.Option
    , userSettingsTab : Tab.State Data.UserSettingsTab
    }


init : Model
init =
    Model initDrawer Select.init (Tab.init Data.Account)


initDrawer : Drawer.Config Components.Msg
initDrawer =
    { isDrawerVisible = Nothing
    , drawerHeight = 400
    , onTap = Components.ToggleDrawer
    }
