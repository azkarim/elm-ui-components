module UI.Avatar exposing (avatar)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import UI.Preset.Size as Size
import UI.Theme exposing (theme)
import Util


avatar : List (Element.Attribute msg) -> Element msg -> Element msg
avatar attrs elem =
    Element.el
        (Element.width (Element.px square)
            :: Element.height (Element.px square)
            :: Border.rounded 50
            :: Background.color theme.color.secondary
            :: Font.size Size.spacing3
            :: Util.userSelectNone
            ++ attrs
        )
    <|
        Element.el
            [ Element.centerX
            , Element.centerY
            ]
            elem


square : Int
square =
    Size.spacing10
