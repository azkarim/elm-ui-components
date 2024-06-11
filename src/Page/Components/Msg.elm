module Page.Components.Msg exposing (Msg(..))

import Page.Components.Data as Data exposing (FruitOption)
import UI.Accordion as Accordion
import UI.Select as Select
import UI.Tab as Tab


type Msg
    = ToggleDrawer
      -- | SelectFruit (Select.Msg Option)
    | SelectFruit (Select.State FruitOption)
    | OnTapBody
    | OnTapAccordion Accordion.Msg
    | UserSettingsTabSelected (Tab.Msg Data.UserSettingsTab)
