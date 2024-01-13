module UI.Preset.Util exposing (..)

import Element
import Element.Border as Border
import UI.Preset.Color as Color


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
