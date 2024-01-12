module UI.Button exposing (outline)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import UI.Preset.Color as Colors
import UI.Preset.Size as Size
import Util


outline : { a | onTap : Maybe msg, label : String } -> Element msg
outline { onTap, label } =
    Input.button
        ([ Element.focused []
         , Background.color Colors.neutral
         , Border.color Colors.zinc200
         , Border.rounded Size.border_md
         , Border.width 1
         , Element.paddingXY Size.padding_4 Size.padding_3
         , Font.size Size.text_sm
         , Font.family [ Font.sansSerif ]
         , Font.medium
         , Font.letterSpacing 0.4
         , Element.mouseOver [ Background.color Colors.slate50 ]
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
