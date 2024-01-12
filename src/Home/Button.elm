module Home.Button exposing (outline)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import Util


outline : { a | onTap : Maybe msg, label : String } -> Element msg
outline { onTap, label } =
    Input.button
        ([ Element.focused []
         , Background.color backgroundColor
         , Border.color borderColor
         , Border.rounded 6
         , Border.width 1
         , Element.paddingXY 16 12
         , Font.size fontSize
         , Font.family [ Font.sansSerif ]
         , Font.medium
         , Font.letterSpacing 0.4
         , Element.mouseOver [ Background.color hoverColor ]
         ]
            ++ transitions
        )
        { onPress = onTap
        , label = Element.text label
        }


transitions : List (Element.Attribute msg)
transitions =
    [ Html.Attributes.style "transition-property" "color,background-color,border-color,text-decoration-color,fill,stroke"
    , Html.Attributes.style "transition-timing-function" "cubic-bezier(.4,0,.2,1)"
    , Html.Attributes.style "transition-duration" "0.15s"
    ]
        |> Util.fromAtrr


fontSize : Int
fontSize =
    14


hoverColor : Element.Color
hoverColor =
    Element.rgb255 248 250 252


backgroundColor : Element.Color
backgroundColor =
    Element.rgb255 255 255 255


borderColor : Element.Color
borderColor =
    Element.rgb255 228 228 231
