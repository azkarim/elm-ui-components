module UI.Drawer exposing (Config, layout, toggle)

import Element exposing (Element)
import Element.Background as Background
import Element.Events as Events
import Html
import Html.Attributes
import Util exposing (ifElse)


type alias Config msg =
    { isVisible : Bool
    , onTap : msg
    }


toggle : Config msg -> Config msg
toggle config =
    { config | isVisible = not config.isVisible }


layout : Config msg -> Element msg -> Html.Html msg
layout { isVisible, onTap } content =
    Element.layout
        [ Element.htmlAttribute <| Html.Attributes.style "width" "100vw"
        , Element.height Element.fill
        , Element.clipX
        , ifElse Element.clipY Util.noAttr isVisible
        , Background.color (Element.rgb255 0 0 0)
        ]
    <|
        Element.el
            (Element.width Element.fill
                :: Element.height Element.fill
                :: ifElse (Element.inFront <| transparentOverlay onTap) Util.noAttr isVisible
                :: transition
                ++ ifElse recedeContent [] isVisible
            )
            content


transparentOverlay : msg -> Element msg
transparentOverlay onTap =
    Element.row
        [ Element.width Element.fill
        , Element.height Element.fill
        , Background.color (Element.rgba255 0 0 0 0.6)
        , Events.onClick onTap
        ]
        []


transition : List (Element.Attribute msg)
transition =
    [ Html.Attributes.style "transform-origin" "center top 0px"
    , Html.Attributes.style "transition-property" "transform, border-radius"
    , Html.Attributes.style "transition-duration" "0.5s"
    , Html.Attributes.style "transition-timing-function" "cubic-bezier(0.32, 0.72, 0, 1)"
    ]
        |> Util.fromAtrr


recedeContent : List (Element.Attribute msg)
recedeContent =
    [ Html.Attributes.style "transform" "scale(0.9864583333333333) translateY(calc(env(safe-area-inset-top) + 14px))"
    ]
        |> Util.fromAtrr
