module UI.Select exposing (Config, Msg, State, hide, init, select, selected, update)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Maybe.Extra as Maybe
import Simple.Animation as Animation exposing (Animation)
import Simple.Animation.Property as P
import UI.Preset.Color as Color
import UI.Preset.Icon as Icon
import UI.Preset.Size as Size
import UI.Preset.Util as Util
import UI.Theme exposing (theme)
import Util exposing (ifElse)



-- todo : focus styling


type alias State option =
    { isVisible : Bool
    , selected : Maybe option
    }


type alias Config embedMsg option =
    { label : String
    , options : List option
    , toString : option -> String
    , embedMsg : Msg option -> embedMsg
    }


type Msg option
    = ToggleSelect
    | Selected option


init : State option
init =
    { isVisible = False, selected = Nothing }


update : Msg option -> State option -> State option
update msg state =
    case msg of
        ToggleSelect ->
            { state | isVisible = not state.isVisible }

        Selected option ->
            { state | selected = Just option, isVisible = False }


hide : State option -> State option
hide state =
    { state | isVisible = False }


selected : State option -> Maybe option
selected state =
    state.selected


select : List (Element.Attribute embedMsg) -> Config embedMsg option -> State option -> Element embedMsg
select attrs config state =
    Element.row
        (Element.width (Element.fill |> Element.minimum size.minWidth)
            :: Element.height (Element.px size.height)
            :: Border.width 1
            :: Border.rounded theme.borderRounded
            :: Border.color theme.border
            :: Font.size Size.text_sm
            :: Font.letterSpacing 0.4
            :: Font.family [ Font.sansSerif ]
            :: Font.medium
            :: ifElse (Element.below <| viewOptions { options = config.options, toString = config.toString, embedMsg = config.embedMsg } state.selected) Util.noAttr state.isVisible
            :: Util.userSelectNone
            ++ attrs
        )
        [ Element.row
            [ Element.width Element.fill
            , Element.height Element.fill
            , Element.spaceEvenly
            , Element.paddingXY Size.padding_3 Size.padding_2
            , Element.pointer
            , Util.onClick (config.embedMsg ToggleSelect)
            ]
            [ Element.el [ Element.centerY ] (Element.text <| selectLabel config state.selected)
            , Icon.renderIcon Icon.downArrow
            ]
        ]


selectLabel : { a | label : String, toString : option -> String } -> Maybe option -> String
selectLabel config option =
    Maybe.unwrap config.label config.toString option


viewOptions : { options : List option, toString : option -> String, embedMsg : Msg option -> embedMsg } -> Maybe option -> Element embedMsg
viewOptions config selectedOption =
    Util.animatedEl Element.el
        slideInAnim
        [ Element.width Element.fill
        , Util.style "transform-origin" "top"
        , Util.style "will-change" "transform"
        ]
    <|
        Element.column
            (Element.moveDown Size.spacing1
                :: Element.width Element.fill
                :: Element.paddingXY Size.padding_2 Size.padding_2
                :: Border.width 1
                :: Border.rounded theme.borderRounded
                :: Border.color theme.border
                :: Util.shadow
            )
        <|
            List.map (renderItem { toString = config.toString, embedMsg = config.embedMsg } selectedOption) config.options


renderItem : { toString : option -> String, embedMsg : Msg option -> embedMsg } -> Maybe option -> option -> Element embedMsg
renderItem config selectedOption option =
    Element.row
        [ Element.width Element.fill
        , Element.paddingXY Size.padding_2 Size.padding_3
        , Border.rounded theme.borderRounded
        , Element.pointer
        , Element.mouseOver [ Background.color Color.slate50 ]
        , Util.onClick (config.embedMsg <| Selected option)
        ]
        [ Element.el
            [ Element.width (Element.px Size.spacing6)
            , Element.centerY
            ]
          <|
            ifElse (Element.el [ Element.centerX ] (Icon.renderIcon Icon.check)) Element.none (selectedOption == Just option)
        , Element.el
            [ Element.centerY
            , Element.alignLeft
            ]
            (Element.text <| config.toString option)
        ]


slideInAnim : Animation
slideInAnim =
    Animation.fromTo
        { duration = 200
        , options = [ Animation.cubic 0.32 0.72 0 1 ]
        }
        [ P.property "transform" "scaleY(0.8) translateZ(0)" ]
        [ P.property "transform" "scaleY(1) translateZ(0)" ]


size : { height : Int, minWidth : Int }
size =
    { height = Size.spacing10
    , minWidth = Size.spacing45
    }
