module Preview.Msg exposing (Msg(..))

import Preview.Model as Model exposing (EmailId, EmailLabel, FilterEmail)
import UI.Select as Select
import UI.Tab as Tab


type Msg
    = SelectAccount (Select.Msg Model.EmailAddress)
    | FilterTab (Tab.Msg FilterEmail)
    | OnTapViewEmail EmailId
    | OnTapEmailLabel EmailLabel
    | OnTapBody
