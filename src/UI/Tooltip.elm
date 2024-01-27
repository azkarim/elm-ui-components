module UI.Tooltip exposing (Config, Msg(..), tooltip)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import UI.Theme exposing (theme)
import UI.Util as Util
import Util


type alias Config id msg =
    { id : id
    , elem : Element msg
    , embedMsg : Msg id -> msg
    , isTooltipOpen : Bool
    }


type Msg id
    = OnMouseLeave id
    | OnMouseEnter id


tooltip : List (Element.Attribute msg) -> Config id msg -> Element msg
tooltip attrs config =
    if not config.isTooltipOpen then
        Element.none

    else
        renderTooltip { id = config.id, elem = config.elem, userAttrs = attrs, embedMsg = config.embedMsg }


renderTooltip : { id : id, elem : Element msg, userAttrs : List (Element.Attribute msg), embedMsg : Msg id -> msg } -> Element msg
renderTooltip { id, elem, userAttrs, embedMsg } =
    Element.el (userEvents id embedMsg ++ commonAttrs ++ userAttrs) elem


userEvents : id -> (Msg id -> msg) -> List (Element.Attribute msg)
userEvents id embedMsg =
    [ Util.onMouseEnter (OnMouseEnter id |> embedMsg)
    , Util.onMouseLeave (OnMouseLeave id |> embedMsg)
    ]


commonAttrs : List (Element.Attribute msg)
commonAttrs =
    [ Element.paddingXY Size.padding_3 Size.padding_2
    , Border.rounded theme.size.rounded
    , Background.color theme.color.primary
    , Font.size Size.text_xs
    , Font.color Color.neutral
    , Font.letterSpacing 0.4
    , Font.family [ Font.sansSerif ]
    , Font.medium
    ]
        ++ Util.transitions
