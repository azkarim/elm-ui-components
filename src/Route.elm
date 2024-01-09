module Route exposing (Route(..), onUrlChange, onUrlRequest)

import Browser
import Msg exposing (Msg)
import Url exposing (Url)


type Route
    = Home


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest _ =
    Msg.OnUrlRequest


onUrlChange : Url -> Msg
onUrlChange _ =
    Msg.OnUrlChange
