module UI.Badge exposing (Badge(..), badge, outline, primary, secondary)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html.Attributes
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import UI.Theme exposing (theme)
import Util


primary : String -> Element msg
primary label =
    badge [] label Primary


secondary : String -> Element msg
secondary label =
    badge [] label Secondary


outline : String -> Element msg
outline label =
    badge [] label Outline


{-|

    `ifElse Badge.Primary Badge.secondary active |> Badge.badge "Leisure"`

-}
badge : List (Element.Attribute msg) -> String -> Badge -> Element msg
badge attrs label badeType =
    Element.el (commonAttrs ++ badgeTypeAttrs badeType ++ attrs) (Element.text label)


type Badge
    = Primary
    | Secondary
    | Outline


badgeTypeAttrs : Badge -> List (Element.Attribute msg)
badgeTypeAttrs type_ =
    case type_ of
        Primary ->
            [ Background.color theme.primary
            , Font.color Color.neutral
            , Element.mouseOver [ theme.primary |> Color.setAlpha 0.9 |> Background.color ]
            ]
                ++ transitions

        Secondary ->
            [ Background.color theme.secondary
            ]

        Outline ->
            Background.color Color.neutral
                :: addBorder theme.border


commonAttrs : List (Element.Attribute msg)
commonAttrs =
    Element.paddingXY Size.padding_3 Size.padding_1
        :: Border.rounded theme.borderRounded
        :: Element.focused []
        :: Font.size Size.text_xs
        :: Font.letterSpacing 0.6
        :: Font.family [ Font.sansSerif ]
        :: Font.medium
        :: Util.userSelectNone


transitions : List (Element.Attribute msg)
transitions =
    -- todo : replace with anim library
    [ Html.Attributes.style "transition-property" "color,background-color,border-color,text-decoration-color,fill,stroke"
    , Html.Attributes.style "transition-timing-function" "cubic-bezier(.4,0,.2,1)"
    , Html.Attributes.style "transition-duration" "0.15s"
    ]
        |> Util.fromAtrrs



-- Util


addBorder : Element.Color -> List (Element.Attribute msg)
addBorder color =
    [ Border.width 1
    , Border.color color
    ]
