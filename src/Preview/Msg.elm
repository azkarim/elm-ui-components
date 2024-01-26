module Preview.Msg exposing (Msg(..))

import Preview.Model as Model exposing (EmailId, EmailLabel, FilterEmail, TooltipId)
import UI.Select as Select
import UI.Tab as Tab
import UI.Tooltip as Tooltip


type Msg
    = SelectAccount (Select.Msg Model.EmailAddress)
    | FilterTab (Tab.Msg FilterEmail)
    | OnTapViewEmail EmailId
    | OnTapEmailLabel EmailLabel
    | OnTapBody
    | OnTooltipMsg (Tooltip.Msg TooltipId)
