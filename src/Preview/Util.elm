module Preview.Util exposing (glowBorder, padding, padding_md)

import Element exposing (paddingXY)
import Element.Border as Border
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import UI.Util as Util


padding : Element.Attribute msg
padding =
    paddingXY Size.spacing_3 Size.spacing_2


padding_md : Element.Attribute msg
padding_md =
    paddingXY Size.spacing_4 Size.spacing_3


glowBorder : List (Element.Attribute msg)
glowBorder =
    [ Border.width 1, Border.color (Color.sky_400 |> Util.setAlpha 0.4) ]
