module Preview.Util exposing (padding)

import Element exposing (paddingXY)
import UI.Preset.Size as Size


padding : Element.Attribute msg
padding =
    paddingXY Size.spacing3 Size.spacing2
