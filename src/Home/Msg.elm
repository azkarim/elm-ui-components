module Home.Msg exposing (Msg(..))

import Home.Data as Data exposing (Option)
import UI.Select as Select
import UI.Tab as Tab


type Msg
    = ToggleDrawer
    | SelectFruit (Select.Msg Option)
    | TappedBody
    | UserSettingsTabSelected (Tab.Msg Data.UserSettingsTab)
