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


inbox : Element msg
inbox =
    svg [ viewBox "0 0 24 24", fill "currentColor" ] [ path [ fillRule "evenodd", d "M6.912 3a3 3 0 0 0-2.868 2.118l-2.411 7.838a3 3 0 0 0-.133.882V18a3 3 0 0 0 3 3h15a3 3 0 0 0 3-3v-4.162c0-.299-.045-.596-.133-.882l-2.412-7.838A3 3 0 0 0 17.088 3H6.912Zm13.823 9.75-2.213-7.191A1.5 1.5 0 0 0 17.088 4.5H6.912a1.5 1.5 0 0 0-1.434 1.059L3.265 12.75H6.11a3 3 0 0 1 2.684 1.658l.256.513a1.5 1.5 0 0 0 1.342.829h3.218a1.5 1.5 0 0 0 1.342-.83l.256-.512a3 3 0 0 1 2.684-1.658h2.844Z", clipRule "evenodd" ] [] ]
        |> Element.html


document : Element msg
document =
    svg [ fill "none", viewBox "0 0 24 24", strokeWidth "1.5", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m2.25 0H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Z" ] [] ]
        |> Element.html


paperAirplane : Element msg
paperAirplane =
    svg [ fill "none", viewBox "0 0 24 24", strokeWidth "1.5", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "M6 12 3.269 3.125A59.769 59.769 0 0 1 21.485 12 59.768 59.768 0 0 1 3.27 20.875L5.999 12Zm0 0h7.5" ] [] ]
        |> Element.html


trash : Element msg
trash =
    svg [ fill "none", viewBox "0 0 24 24", strokeWidth "1.5", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" ] [] ]
        |> Element.html


archiveBoxXMark : Element msg
archiveBoxXMark =
    svg [ fill "none", viewBox "0 0 24 24", strokeWidth "1.5", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "m20.25 7.5-.625 10.632a2.25 2.25 0 0 1-2.247 2.118H6.622a2.25 2.25 0 0 1-2.247-2.118L3.75 7.5m6 4.125 2.25 2.25m0 0 2.25 2.25M12 13.875l2.25-2.25M12 13.875l-2.25 2.25M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125Z" ] [] ]
        |> Element.html


archiveBox : Element msg
archiveBox =
    svg [ fill "none", viewBox "0 0 24 24", strokeWidth "1.5", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "m20.25 7.5-.625 10.632a2.25 2.25 0 0 1-2.247 2.118H6.622a2.25 2.25 0 0 1-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125Z" ] [] ]
        |> Element.html


users_outline : Element msg
users_outline =
    svg [ fill "none", viewBox "0 0 24 24", strokeWidth "1.5", stroke "currentColor" ] [ path [ strokeLinecap "round", strokeLinejoin "round", d "M15 19.128a9.38 9.38 0 0 0 2.625.372 9.337 9.337 0 0 0 4.121-.952 4.125 4.125 0 0 0-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 0 1 8.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0 1 11.964-3.07M12 6.375a3.375 3.375 0 1 1-6.75 0 3.375 3.375 0 0 1 6.75 0Zm8.25 2.25a2.625 2.625 0 1 1-5.25 0 2.625 2.625 0 0 1 5.25 0Z" ] [] ]
        |> Element.html
