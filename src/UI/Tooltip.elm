module UI.Tooltip exposing (Config, Msg(..), events, tooltip)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Simple.Animation as Animation exposing (Animation)
import Simple.Animation.Property as P
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import UI.Theme exposing (theme)
import UI.Util as Util
import Util exposing (ifElse)


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
        Util.animatedEl Element.el (popupAnim config.isTooltipOpen) [] <| renderTooltip { elem = config.elem, userAttrs = attrs }


renderTooltip : { elem : Element msg, userAttrs : List (Element.Attribute msg) } -> Element msg
renderTooltip { elem, userAttrs } =
    Element.el (commonAttrs ++ userAttrs) elem


events : id -> (Msg id -> msg) -> List (Element.Attribute msg)
events id embedMsg =
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


popupAnim : Bool -> Animation
popupAnim isVisible =
    Animation.fromTo
        { duration = 200
        , options = Animation.cubic 0.32 0.72 0 1 :: ifElse [] [ Animation.reverse ] isVisible
        }
        [ P.opacity 0 ]
        [ P.opacity 1 ]
