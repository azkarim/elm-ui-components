module Page.Preview.Msg exposing (Msg(..))

import Page.Preview.Model as Model exposing (EmailId, EmailLabel, FilterEmail, TooltipId)
import UI.Select as Select
import UI.Tab as Tab
import UI.Tooltip as Tooltip


type Msg
    = SelectAccount (Select.State Model.EmailAddress)
    | FilterTab (Tab.Msg FilterEmail)
    | OnTapViewEmail EmailId
    | OnTapEmailLabel EmailLabel
    | OnTapBody
    | OnTooltipMsg (Tooltip.Msg TooltipId)
