module UI.Select exposing (Config, CustomConfig, Msg, State, el, hide, init, select, selected, update)

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



-- todo : focus styling, use hero-icons package


type alias State option =
    { isVisible : Bool
    , selected : Maybe option
    , highlightSelected : Bool
    }


type alias Config option embedMsg =
    { label : String
    , options : List option
    , toString : option -> String
    , embedMsg : Msg option -> embedMsg
    }


type alias CustomConfig option embedMsg =
    { label : Element embedMsg
    , options : List option
    , item : option -> Element embedMsg
    , itemAsSelected : option -> Element embedMsg
    , itemAsLabel : option -> Element embedMsg
    , embedMsg : Msg option -> embedMsg
    }


type Msg option
    = ToggleSelect
    | Selected option
      -- we remove the highlighted bg on selected item when mouse starts to move inside viewOptions panel; ready to select new option
    | RemoveSelectedOptionHighlight


init : Maybe option -> State option
init option =
    { isVisible = False, selected = option, highlightSelected = False }


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


select : List (Element.Attribute embedMsg) -> Config option embedMsg -> State option -> Element embedMsg
select attrs config state =
    let
        elemConfig : CustomConfig option embedMsg
        elemConfig =
            { label = elemLabel config.label
            , options = config.options
            , item = config.toString >> elemItem
            , itemAsSelected = config.toString >> elemItemAsSelected
            , itemAsLabel = config.toString >> elemItemAsLabel
            , embedMsg = config.embedMsg
            }
    in
    el attrs elemConfig state


{-| A Select element

    type alias CustomConfig option embedMsg =
        { label : Element embedMsg
        , options : List option
        , item : option -> Element embedMsg
        , itemAsSelected : option -> Element embedMsg
        , itemAsLabel : option -> Element embedMsg
        , embedMsg : Msg option -> embedMsg
        }

-}
el : List (Element.Attribute embedMsg) -> CustomConfig option embedMsg -> State option -> Element embedMsg
el attrs config state =
    Element.el
        (Element.width (Element.fill |> Element.minimum size.minWidth)
            :: Element.height (Element.px size.height)
            :: Border.width theme.size.border
            :: Border.rounded theme.size.rounded
            :: Border.color theme.color.border
            :: Font.size Size.text_sm
            :: Font.letterSpacing 0.4
            :: Font.family [ Font.sansSerif ]
            :: Font.medium
            :: ifElse (Element.below <| viewOptions { options = config.options, item = config.item, itemAsSelected = config.itemAsSelected, embedMsg = config.embedMsg, highlightSelected = state.highlightSelected } state.selected) Util.noAttr state.isVisible
            :: Util.userSelectNone
            ++ attrs
        )
        (Element.el
            [ Element.width Element.fill
            , Element.height Element.fill
            , Element.paddingXY Size.padding_3 Size.padding_2
            , Element.pointer
            , Util.onClick (config.embedMsg ToggleSelect)
            ]
            (renderLabel config state.selected)
        )



-- Internal


renderLabel : { a | label : Element embedMsg, itemAsLabel : option -> Element embedMsg } -> Maybe option -> Element embedMsg
renderLabel config selectedOption =
    Maybe.unwrap config.label config.itemAsLabel selectedOption


viewOptions : { options : List option, item : option -> Element embedMsg, itemAsSelected : option -> Element embedMsg, embedMsg : Msg option -> embedMsg, highlightSelected : Bool } -> Maybe option -> Element embedMsg
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
            (Element.moveDown Size.spacing_1
                :: Element.width Element.fill
                :: Element.paddingXY Size.padding_2 Size.padding_2
                :: Border.width theme.size.border
                :: Border.rounded theme.size.rounded
                :: Border.color theme.color.border
                :: Background.color Color.neutral
                :: Util.shadow
            )
        <|
            List.map (Lazy.lazy2 renderItem { item = config.item, itemAsSelected = config.itemAsSelected, embedMsg = config.embedMsg, highlightSelected = config.highlightSelected, selectedOption = selectedOption }) config.options


renderItem : { item : option -> Element embedMsg, itemAsSelected : option -> Element embedMsg, embedMsg : Msg option -> embedMsg, highlightSelected : Bool, selectedOption : Maybe option } -> option -> Element embedMsg
renderItem config option =
    Element.el
        [ Element.width Element.fill
        , Element.paddingXY Size.padding_2 Size.padding_3
        , Border.rounded theme.size.rounded
        , Element.pointer
        , ifElse (Background.color theme.color.hover) Util.noAttr (Just option == config.selectedOption && config.highlightSelected)
        , Element.mouseOver [ Background.color theme.color.hover ]
        , Util.onClick (config.embedMsg <| Selected option)
        ]
    <|
        ifElse (config.itemAsSelected option) (config.item option) (config.selectedOption == Just option)


slideInAnim : Animation
slideInAnim =
    Animation.fromTo
        { duration = 200
        , options = [ Animation.cubic 0.32 0.72 0 1 ]
        }
        [ P.property "transform" "scaleY(0.8) translateZ(0)" ]
        [ P.property "transform" "scaleY(1) translateZ(0)" ]


elemLabel : String -> Element msg
elemLabel label =
    Element.row [ Element.width Element.fill, Element.spaceEvenly, Element.centerY ]
        [ Element.el [] (Element.text label)
        , downArrow
        ]


elemItemAsLabel : String -> Element msg
elemItemAsLabel =
    elemLabel


elemItem : String -> Element msg
elemItem option =
    Element.row [ Element.centerY ]
        [ Element.el [ Element.width (Element.px Size.spacing_6) ] Element.none
        , Element.text option
        ]


elemItemAsSelected : String -> Element msg
elemItemAsSelected option =
    Element.row [ Element.centerY ]
        [ Element.el [ Element.width (Element.px Size.spacing_6), Element.centerX ] check
        , Element.text option
        ]


downArrow : Element msg
downArrow =
    Util.renderIcon Icon.downArrow


check : Element msg
check =
    Util.renderIcon Icon.check


size : { height : Int, minWidth : Int }
size =
    { height = Size.spacing_10
    , minWidth = Size.spacing_45
    }
