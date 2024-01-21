module Preview.Msg exposing (Msg(..))

import Preview.Model as Model
import UI.Select as Select


type Msg
    = SelectAccount (Select.Msg Model.Email)
