module Msg exposing (Msg(..))

import Page.Components.Msg as Components
import Page.Preview.Msg as Preview


type Msg
    = ComponentsMsg Components.Msg
    | PreviewMsg Preview.Msg
    | OnUrlRequest
    | OnUrlChange
