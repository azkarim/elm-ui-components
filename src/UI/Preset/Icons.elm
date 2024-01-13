module UI.Preset.Icons exposing (..)

import Element exposing (Element)
import Svg exposing (path, svg)
import Svg.Attributes exposing (d, fill, stroke, strokeLinecap, strokeLinejoin, strokeWidth, viewBox)


rightArrow : Element msg
rightArrow =
    svg [ fill "", viewBox "0 0 24 24", strokeWidth "2", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "m8.25 4.5 7.5 7.5-7.5 7.5" ] [] ]
        |> Element.html


renderIcon : Element msg -> Element msg
renderIcon icon =
    Element.el [ Element.width (Element.px 16), Element.height (Element.px 16) ] icon
