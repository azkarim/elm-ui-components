module Preview.Msg exposing (Msg(..))

import Preview.Model as Model exposing (EmailSection, FilterEmail)
import UI.Select as Select
import UI.Tab as Tab


type Msg
    = SelectAccount (Select.Msg Model.Email)
    | FilterTab (Tab.Msg FilterEmail)
    | OnTapEmailSection EmailSection
    | OnTapBody
