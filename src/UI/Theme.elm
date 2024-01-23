module UI.Theme exposing (theme)

import Element
import UI.Preset.Color as Color
import UI.Preset.Size as Size


theme : { color : { primary : Element.Color, secondary : Element.Color, hover : Element.Color, border : Element.Color }, size : { border : Int, rounded : Int, icon : number } }
theme =
    { color =
        { primary = Color.slate900
        , secondary = Color.zinc200
        , hover = Color.zinc100
        , border = Color.zinc200
        }
    , size =
        { border = Size.border_1
        , rounded = Size.border_md
        , icon = Size.spacing3
        }
    }
