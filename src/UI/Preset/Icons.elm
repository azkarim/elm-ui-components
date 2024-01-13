module UI.Preset.Icons exposing (..)

import Element exposing (Element)
import Svg exposing (path, svg)
import Svg.Attributes exposing (d, fill, stroke, strokeLinecap, strokeLinejoin, strokeWidth, viewBox)


rightArrow : Element msg
rightArrow =
    svg [ fill "", viewBox "0 0 24 24", strokeWidth "2", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "m8.25 4.5 7.5 7.5-7.5 7.5" ] [] ]
        |> Element.html


email : Element msg
email =
    svg [ fill "none", viewBox "0 0 24 24", strokeWidth "1.5", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "M21.75 6.75v10.5a2.25 2.25 0 0 1-2.25 2.25h-15a2.25 2.25 0 0 1-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25m19.5 0v.243a2.25 2.25 0 0 1-1.07 1.916l-7.5 4.615a2.25 2.25 0 0 1-2.36 0L3.32 8.91a2.25 2.25 0 0 1-1.07-1.916V6.75" ] [] ]
        |> Element.html


renderIcon : Element msg -> Element msg
renderIcon icon =
    Element.el [ Element.width (Element.px 16), Element.height (Element.px 16) ] icon
