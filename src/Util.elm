module Util exposing (fromAtrr, ifElse, noAttr)

import Element
import Html
import Html.Attributes


noAttr : Element.Attribute msg
noAttr =
    Element.htmlAttribute <| Html.Attributes.style "" ""


fromAtrr : List (Html.Attribute msg) -> List (Element.Attribute msg)
fromAtrr =
    List.map Element.htmlAttribute


ifElse : a -> a -> Bool -> a
ifElse true false cond =
    if cond then
        true

    else
        false
