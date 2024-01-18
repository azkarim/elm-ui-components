module UI.Badge exposing (Badge(..), badge, outline, primary, secondary)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import UI.Theme exposing (theme)
import UI.Util as Util
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
            [ Background.color theme.color.primary
            , Font.color Color.neutral
            , Element.mouseOver [ theme.color.primary |> Util.setAlpha 0.9 |> Background.color ]
            ]
                ++ Util.transitions

        Secondary ->
            [ Background.color theme.color.secondary
            ]

        Outline ->
            Background.color Color.neutral
                :: Util.addBorder


commonAttrs : List (Element.Attribute msg)
commonAttrs =
    Element.paddingXY Size.padding_3 Size.padding_1
        :: Border.rounded theme.size.rounded
        :: Element.focused []
        :: Font.size Size.text_xs
        :: Font.letterSpacing 0.6
        :: Font.family [ Font.sansSerif ]
        :: Font.medium
        :: Util.userSelectNone
