module Preview.Util exposing (padding, padding_md)

import Element exposing (paddingXY)
import UI.Preset.Size as Size


padding : Element.Attribute msg
padding =
    paddingXY Size.spacing3 Size.spacing2


padding_md : Element.Attribute msg
padding_md =
    paddingXY Size.spacing4 Size.spacing3
