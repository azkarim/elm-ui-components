module Page.Components.Msg exposing (Msg(..))

import Page.Components.Data as Data exposing (Option)
import UI.Accordion as Accordion
import UI.Select as Select
import UI.Tab as Tab


type Msg
    = ToggleDrawer
    | SelectFruit (Select.Msg Option)
    | OnTapBody
    | OnTapAccordion Accordion.Msg
    | UserSettingsTabSelected (Tab.Msg Data.UserSettingsTab)
