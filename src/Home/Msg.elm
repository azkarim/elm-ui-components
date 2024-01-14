module Home.Msg exposing (Msg(..))

import Home.Data exposing (Option)
import UI.Select as Select


type Msg
    = ToggleDrawer
    | SelectFruit (Select.Msg Option)
