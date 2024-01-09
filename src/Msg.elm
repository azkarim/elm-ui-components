module Msg exposing (Msg(..))

import Home.Msg as Home


type Msg
    = HomeMsg Home.Msg
    | OnUrlRequest
    | OnUrlChange
