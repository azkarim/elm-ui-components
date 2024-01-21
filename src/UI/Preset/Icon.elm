module UI.Preset.Icon exposing (..)

import Element exposing (Element)
import Svg exposing (path, svg)
import Svg.Attributes exposing (clipRule, d, fill, fillRule, stroke, strokeLinecap, strokeLinejoin, strokeWidth, viewBox)


rightArrow : Element msg
rightArrow =
    svg [ fill "", viewBox "0 0 24 24", strokeWidth "2", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "m8.25 4.5 7.5 7.5-7.5 7.5" ] [] ]
        |> Element.html


downArrow : Element msg
downArrow =
    svg [ fill "none", viewBox "0 0 24 24", strokeWidth "1.5", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "m19.5 8.25-7.5 7.5-7.5-7.5" ] [] ]
        |> Element.html


user : Element msg
user =
    svg [ viewBox "0 0 24 24", fill "currentColor" ] [ path [ fillRule "evenodd", d "M18.685 19.097A9.723 9.723 0 0 0 21.75 12c0-5.385-4.365-9.75-9.75-9.75S2.25 6.615 2.25 12a9.723 9.723 0 0 0 3.065 7.097A9.716 9.716 0 0 0 12 21.75a9.716 9.716 0 0 0 6.685-2.653Zm-12.54-1.285A7.486 7.486 0 0 1 12 15a7.486 7.486 0 0 1 5.855 2.812A8.224 8.224 0 0 1 12 20.25a8.224 8.224 0 0 1-5.855-2.438ZM15.75 9a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0Z", clipRule "evenodd" ] [] ]
        |> Element.html


upDown : Element msg
upDown =
    svg [ fill "none", viewBox "0 0 24 24", strokeWidth "1.5", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "M8.25 15 12 18.75 15.75 15m-7.5-6L12 5.25 15.75 9" ] [] ]
        |> Element.html


email : Element msg
email =
    svg [ fill "none", viewBox "0 0 24 24", strokeWidth "1.5", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "M21.75 6.75v10.5a2.25 2.25 0 0 1-2.25 2.25h-15a2.25 2.25 0 0 1-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25m19.5 0v.243a2.25 2.25 0 0 1-1.07 1.916l-7.5 4.615a2.25 2.25 0 0 1-2.36 0L3.32 8.91a2.25 2.25 0 0 1-1.07-1.916V6.75" ] [] ]
        |> Element.html


check : Element msg
check =
    svg [ fill "none", viewBox "0 0 24 24", strokeWidth "2.5", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "m4.5 12.75 6 6 9-13.5" ] [] ]
        |> Element.html


buildingLibrary : Element msg
buildingLibrary =
    svg [ viewBox "0 0 24 24", fill "currentColor" ] [ path [ d "M11.584 2.376a.75.75 0 0 1 .832 0l9 6a.75.75 0 1 1-.832 1.248L12 3.901 3.416 9.624a.75.75 0 0 1-.832-1.248l9-6Z" ] [], path [ fillRule "evenodd", d "M20.25 10.332v9.918H21a.75.75 0 0 1 0 1.5H3a.75.75 0 0 1 0-1.5h.75v-9.918a.75.75 0 0 1 .634-.74A49.109 49.109 0 0 1 12 9c2.59 0 5.134.202 7.616.592a.75.75 0 0 1 .634.74Zm-7.5 2.418a.75.75 0 0 0-1.5 0v6.75a.75.75 0 0 0 1.5 0v-6.75Zm3-.75a.75.75 0 0 1 .75.75v6.75a.75.75 0 0 1-1.5 0v-6.75a.75.75 0 0 1 .75-.75ZM9 12.75a.75.75 0 0 0-1.5 0v6.75a.75.75 0 0 0 1.5 0v-6.75Z", clipRule "evenodd" ] [], path [ d "M12 7.875a1.125 1.125 0 1 0 0-2.25 1.125 1.125 0 0 0 0 2.25Z" ] [] ]
        |> Element.html


cloud : Element msg
cloud =
    svg [ viewBox "0 0 24 24", fill "currentColor" ] [ path [ fillRule "evenodd", d "M4.5 9.75a6 6 0 0 1 11.573-2.226 3.75 3.75 0 0 1 4.133 4.303A4.5 4.5 0 0 1 18 20.25H6.75a5.25 5.25 0 0 1-2.23-10.004 6.072 6.072 0 0 1-.02-.496Z", clipRule "evenodd" ] [] ]
        |> Element.html


desktop : Element msg
desktop =
    svg [ viewBox "0 0 24 24", fill "currentColor" ] [ path [ fillRule "evenodd", d "M2.25 5.25a3 3 0 0 1 3-3h13.5a3 3 0 0 1 3 3V15a3 3 0 0 1-3 3h-3v.257c0 .597.237 1.17.659 1.591l.621.622a.75.75 0 0 1-.53 1.28h-9a.75.75 0 0 1-.53-1.28l.621-.622a2.25 2.25 0 0 0 .659-1.59V18h-3a3 3 0 0 1-3-3V5.25Zm1.5 0v7.5a1.5 1.5 0 0 0 1.5 1.5h13.5a1.5 1.5 0 0 0 1.5-1.5v-7.5a1.5 1.5 0 0 0-1.5-1.5H5.25a1.5 1.5 0 0 0-1.5 1.5Z", clipRule "evenodd" ] [] ]
        |> Element.html
