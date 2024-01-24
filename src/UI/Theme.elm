module UI.Theme exposing (theme)

import Element
import UI.Preset.Color as Color
import UI.Preset.Size as Size


theme : { color : { primary : Element.Color, secondary : Element.Color, hover : Element.Color, border : Element.Color }, size : { border : Int, rounded : Int, icon : number } }
theme =
    { color =
        { primary = Color.slate_900
        , secondary = Color.zinc_200
        , hover = Color.zinc_100
        , border = Color.zinc_200
        }
    , size =
        { border = Size.border_1
        , rounded = Size.border_md
        , icon = Size.spacing_3
        }
    }
