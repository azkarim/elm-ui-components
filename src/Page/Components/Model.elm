module Page.Components.Model exposing (Model, init)

import Page.Components.Data as Data
import Page.Components.Msg as Components
import UI.Accordion as Accordion
import UI.Drawer as Drawer
import UI.Select as Select
import UI.Tab as Tab


type alias Model =
    { drawer : Drawer.Config Components.Msg
    , selectFruitState : Select.State Data.FruitOption
    , userSettingsTab : Tab.State Data.UserSettingsTab
    , accordion : Maybe Int
    }


init : Model
init =
    Model initDrawer (Select.init Nothing) (Tab.init Data.Account) Accordion.init


initDrawer : Drawer.Config Components.Msg
initDrawer =
    { isDrawerVisible = Nothing
    , drawerHeight = 400
    , onTap = Components.ToggleDrawer
    }
