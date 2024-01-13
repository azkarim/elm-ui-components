module Util exposing (animatedEl, fromAtrrs, ifElse, noAttr, style)

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


style : String -> String -> Element.Attribute msg
style prop value =
    Element.htmlAttribute <| Html.Attributes.style prop value


fromAtrrs : List (Html.Attribute msg) -> List (Element.Attribute msg)
fromAtrrs =
    List.map Element.htmlAttribute


ifElse : a -> a -> Bool -> a
ifElse true false cond =
    if cond then
        true

    else
        false
