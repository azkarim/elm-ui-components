module Page.Components.Subscriptions exposing (subscriptions)

import Browser.Events as Events
import Json.Decode as JD
import Page.Components.Model as Components
import Page.Components.Msg as Components


subscriptions : Components.Model -> List (Sub Components.Msg)
subscriptions { selectFruitState } =
    if selectFruitState.isVisible then
        [ Events.onClick (JD.succeed <| Components.OnTapBody) ]

    else
        [ Sub.none ]
