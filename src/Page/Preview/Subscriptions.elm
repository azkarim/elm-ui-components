module Page.Preview.Subscriptions exposing (subscriptions)

import Browser.Events as Events
import Json.Decode as JD
import Page.Preview.Model as Preview
import Page.Preview.Msg as Preview


subscriptions : Preview.Model -> List (Sub Preview.Msg)
subscriptions { account } =
    if account.isVisible then
        [ Events.onClick (JD.succeed <| Preview.OnTapBody) ]

    else
        [ Sub.none ]
