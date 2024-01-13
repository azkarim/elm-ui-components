module UI.Button exposing (ghost, outline, shadow)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import Util



-- todo : add ring state when focued


outline : List (Element.Attribute msg) -> { a | onTap : Maybe msg, label : String } -> Element msg
outline attr { onTap, label } =
    Input.button
        ([ Background.color Color.neutral
         , Border.width 1
         , Element.mouseOver [ Background.color Color.slate50 ]
         ]
            ++ commonAttr
            ++ attr
        )
        { onPress = onTap
        , label = Element.text label
        }


ghost : { a | onTap : Maybe msg, label : String } -> Element msg
ghost { onTap, label } =
    Input.button
        ([ Border.width 0
         , Element.mouseOver
            [ Background.color Color.slate50
            ]
         ]
            ++ commonAttr
        )
        { onPress = onTap
        , label = Element.text label
        }


shadow : List (Element.Attribute msg)
shadow =
    [ Border.shadow
        { offset = ( 0, 4 )
        , size = -1
        , blur = 6
        , color = shadowColor
        }
    , Border.shadow
        { offset = ( 0, 2 )
        , size = -2
        , blur = 4
        , color = shadowColor
        }
    ]


shadowColor : Element.Color
shadowColor =
    Element.rgba255 0 0 0 0.1


commonAttr : List (Element.Attribute msg)
commonAttr =
    let
        transitions : List (Element.Attribute msg)
        transitions =
            -- todo : replace with anim library
            [ Html.Attributes.style "transition-property" "color,background-color,border-color,text-decoration-color,fill,stroke"
            , Html.Attributes.style "transition-timing-function" "cubic-bezier(.4,0,.2,1)"
            , Html.Attributes.style "transition-duration" "0.15s"
            ]
                |> Util.fromAtrr
    in
    [ Element.paddingXY Size.padding_4 Size.padding_3
    , Border.rounded Size.border_md
    , Border.color Color.zinc200
    , Element.focused []
    , Font.size Size.text_sm
    , Font.letterSpacing 0.4
    , Font.family [ Font.sansSerif ]
    , Font.medium
    ]
        ++ transitions
