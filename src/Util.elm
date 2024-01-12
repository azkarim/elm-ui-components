module Util exposing (animatedEl, fromAtrr, ifElse, noAttr)

import Element
import Html
import Html.Attributes
import Simple.Animation exposing (Animation)
import Simple.Animation.Animated as Animated


animatedEl : (List (Element.Attribute msg) -> children -> Element.Element msg) -> Animation -> List (Element.Attribute msg) -> children -> Element.Element msg
animatedEl =
    Animated.ui
        { behindContent = Element.behindContent
        , htmlAttribute = Element.htmlAttribute
        , html = Element.html
        }


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
