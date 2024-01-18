module UI.Util exposing (addBorder, renderIcon, shadow)

import Element exposing (Element)
import Element.Border as Border
import UI.Preset.Color as Color
import UI.Theme exposing (theme)


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


renderIcon : Element msg -> Element msg
renderIcon icon =
    Element.el [ Element.width (Element.px theme.size.icon), Element.height (Element.px theme.size.icon) ] icon


addBorder : List (Element.Attribute msg)
addBorder =
    [ Border.width 1
    , Border.color theme.color.border
    ]
