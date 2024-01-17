module UI.Theme exposing (theme)

import Element
import UI.Preset.Color as Color
import UI.Preset.Size as Size


theme : { primary : Element.Color, secondary : Element.Color, hover : Element.Color, border : Element.Color, borderRounded : Int }
theme =
    { primary = Color.slate900
    , secondary = Color.zinc200
    , hover = Color.zinc100
    , border = Color.zinc200
    , borderRounded = Size.border_md
    }
