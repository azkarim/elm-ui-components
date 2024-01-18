module UI.Select exposing (Config, Msg, State, hide, init, select, selected, update)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Lazy as Lazy
import Maybe.Extra as Maybe
import Simple.Animation as Animation exposing (Animation)
import Simple.Animation.Property as P
import UI.Preset.Color as Color
import UI.Preset.Icon as Icon
import UI.Preset.Size as Size
import UI.Theme exposing (theme)
import UI.Util as Util
import Util exposing (ifElse)



-- todo : focus styling


type alias State option =
    { isVisible : Bool
    , selected : Maybe option
    , highlightSelected : Bool
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
      -- we remove the highlighted bg on selected item when mouse starts to move inside viewOptions panel; ready to select new option
    | RemoveSelectedOptionHighlight


init : State option
init =
    { isVisible = False, selected = Nothing, highlightSelected = False }


update : Msg option -> State option -> State option
update msg state =
    case msg of
        ToggleSelect ->
            { state | isVisible = not state.isVisible, highlightSelected = ifElse True False (Maybe.isJust state.selected) }

        Selected option ->
            { state | selected = Just option, isVisible = False, highlightSelected = True }

        RemoveSelectedOptionHighlight ->
            { state | highlightSelected = False }


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
            :: Border.width theme.size.border
            :: Border.rounded theme.size.rounded
            :: Border.color theme.color.border
            :: Font.size Size.text_sm
            :: Font.letterSpacing 0.4
            :: Font.family [ Font.sansSerif ]
            :: Font.medium
            :: ifElse (Element.below <| viewOptions { options = config.options, toString = config.toString, embedMsg = config.embedMsg, highlightSelected = state.highlightSelected } state.selected) Util.noAttr state.isVisible
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
            , Util.renderIcon Icon.downArrow
            ]
        ]


selectLabel : { a | label : String, toString : option -> String } -> Maybe option -> String
selectLabel config option =
    Maybe.unwrap config.label config.toString option


viewOptions : { options : List option, toString : option -> String, embedMsg : Msg option -> embedMsg, highlightSelected : Bool } -> Maybe option -> Element embedMsg
viewOptions config selectedOption =
    Util.animatedEl Element.el
        slideInAnim
        [ Element.width Element.fill
        , Util.style "transform-origin" "top"
        , Util.style "will-change" "transform"
        , ifElse (Events.onMouseMove (config.embedMsg RemoveSelectedOptionHighlight)) Util.noAttr config.highlightSelected
        ]
    <|
        Element.column
            (Element.moveDown Size.spacing1
                :: Element.width Element.fill
                :: Element.paddingXY Size.padding_2 Size.padding_2
                :: Border.width theme.size.border
                :: Border.rounded theme.size.rounded
                :: Border.color theme.color.border
                :: Background.color Color.neutral
                :: Util.shadow
            )
        <|
            List.map (Lazy.lazy2 renderItem { toString = config.toString, embedMsg = config.embedMsg, highlightSelected = config.highlightSelected, selectedOption = selectedOption }) config.options


renderItem : { toString : option -> String, embedMsg : Msg option -> embedMsg, highlightSelected : Bool, selectedOption : Maybe option } -> option -> Element embedMsg
renderItem config option =
    Element.row
        [ Element.width Element.fill
        , Element.paddingXY Size.padding_2 Size.padding_3
        , Border.rounded theme.size.rounded
        , Element.pointer
        , ifElse (Background.color theme.color.hover) Util.noAttr (Just option == config.selectedOption && config.highlightSelected)
        , Element.mouseOver [ Background.color theme.color.hover ]
        , Util.onClick (config.embedMsg <| Selected option)
        ]
        [ Element.el
            [ Element.width (Element.px Size.spacing6)
            , Element.centerY
            ]
          <|
            ifElse (Element.el [ Element.centerX ] (Util.renderIcon Icon.check)) Element.none (config.selectedOption == Just option)
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
