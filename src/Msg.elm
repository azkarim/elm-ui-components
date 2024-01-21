module Msg exposing (Msg(..))

import Components.Msg as Components
import Preview.Msg as Preview


type Msg
    = ComponentsMsg Components.Msg
    | PreviewMsg Preview.Msg
    | OnUrlRequest
    | OnUrlChange
