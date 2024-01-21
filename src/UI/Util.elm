module UI.Util exposing (addBorder, renderIcon, setAlpha, shadow, shadow_xl, transitions)

import Element exposing (Element)
import Element.Border as Border
import Html.Attributes
import UI.Preset.Color as Color
import UI.Theme exposing (theme)
import Util


shadow : List (Element.Attribute msg)
shadow =
    [ Border.shadow
        { offset = ( 0, 4 )
        , size = -1
        , blur = 6
        , color = Color.shadow
        }
    , Border.shadow
        { offset = ( 0, 2 )
        , size = -2
        , blur = 4
        , color = Color.shadow
        }
    ]


shadow_xl : List (Element.Attribute msg)
shadow_xl =
    [ Border.shadow
        { offset = ( 0, 20 )
        , size = -5
        , blur = 25
        , color = Color.shadow
        }
    , Border.shadow
        { offset = ( 0, 8 )
        , size = -6
        , blur = 10
        , color = Color.shadow
        }
    ]


transitions : List (Element.Attribute msg)
transitions =
    -- todo : replace with anim library
    [ Html.Attributes.style "transition-property" "color,background-color,border-color,text-decoration-color,fill,stroke"
    , Html.Attributes.style "transition-timing-function" "cubic-bezier(.4,0,.2,1)"
    , Html.Attributes.style "transition-duration" "0.15s"
    ]
        |> Util.fromAtrrs


renderIcon : Element msg -> Element msg
renderIcon icon =
    Element.el [ Element.width (Element.px theme.size.icon), Element.height (Element.px theme.size.icon) ] icon


addBorder : List (Element.Attribute msg)
addBorder =
    [ Border.width theme.size.border
    , Border.color theme.color.border
    ]


setAlpha : Float -> Element.Color -> Element.Color
setAlpha alpha color =
    Element.toRgb color
        |> (\c ->
                { c | alpha = alpha }
                    |> Element.fromRgb
           )
