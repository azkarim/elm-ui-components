module Components.Subscriptions exposing (subscriptions)

import Browser.Events as Events
import Components.Model as Components
import Components.Msg as Components
import Json.Decode as JD


subscriptions : Components.Model -> List (Sub Components.Msg)
subscriptions { selectFruitState } =
    if selectFruitState.isVisible then
        [ Events.onClick (JD.succeed <| Components.OnTapBody) ]

    else
        [ Sub.none ]
