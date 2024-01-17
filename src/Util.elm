module Util exposing (animatedEl, fromAtrrs, ifElse, noAttr, onClick, style, userSelectNone)

import Element
import Html
import Html.Attributes
import Html.Events
import Json.Decode as D
import Simple.Animation exposing (Animation)
import Simple.Animation.Animated as Animated


animatedEl : (List (Element.Attribute msg) -> children -> Element.Element msg) -> Animation -> List (Element.Attribute msg) -> children -> Element.Element msg
animatedEl =
    Animated.ui
        { behindContent = Element.behindContent
        , htmlAttribute = Element.htmlAttribute
        , html = Element.html
        }


onClick : msg -> Element.Attribute msg
onClick msg =
    Html.Events.custom "click" (D.succeed { message = msg, stopPropagation = True, preventDefault = True })
        |> Element.htmlAttribute


noAttr : Element.Attribute msg
noAttr =
    Element.htmlAttribute <| Html.Attributes.style "" ""


style : String -> String -> Element.Attribute msg
style prop value =
    Element.htmlAttribute <| Html.Attributes.style prop value


userSelectNone : List (Element.Attribute msg)
userSelectNone =
    [ style "user-select" "none"
    , style "-webkit-user-select" "none"
    ]


fromAtrrs : List (Html.Attribute msg) -> List (Element.Attribute msg)
fromAtrrs =
    List.map Element.htmlAttribute


ifElse : a -> a -> Bool -> a
ifElse true false cond =
    if cond then
        true

    else
        false
