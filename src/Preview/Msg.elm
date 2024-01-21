module Preview.Msg exposing (Msg(..))

import Preview.Model as Model exposing (EmailSection)
import UI.Select as Select


type Msg
    = SelectAccount (Select.Msg Model.Email)
    | OnTapEmailSection EmailSection
    | OnTapBody
