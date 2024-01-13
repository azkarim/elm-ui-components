module UI.Button exposing (Button, ButtonType(..), button, buttonType, ghost, icon, label, new, onTap, outline)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import Maybe.Extra as Maybe
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import Util



-- todo : add ring state when focued


outline : List (Element.Attribute msg) -> { a | onTap : Maybe msg, label : String } -> Element msg
outline attrs btn =
    new
        |> buttonType Outline
        |> onTap btn.onTap
        |> label btn.label
        |> button attrs


ghost : List (Element.Attribute msg) -> { a | onTap : Maybe msg, label : String } -> Element msg
ghost attrs btn =
    new
        |> buttonType Ghost
        |> onTap btn.onTap
        |> label btn.label
        |> button attrs


type alias Button msg =
    { buttonType : Maybe ButtonType
    , icon : Maybe String
    , onTap : Maybe msg
    , label : Maybe String
    }


type ButtonType
    = Outline
    | Ghost


{-| Button Builder

    Button.new
        |> Button.buttonType Primary
        |> Button.onTap Toggle
        |> Button.label "Toggle"
        |> Button.view

-}
new : Button msg
new =
    { buttonType = Nothing
    , icon = Nothing
    , onTap = Nothing
    , label = Nothing
    }


buttonType : ButtonType -> Button msg -> Button msg
buttonType btnType btn =
    { btn | buttonType = Just btnType }


icon : String -> Button msg -> Button msg
icon el btn =
    { btn | icon = Just el }


onTap : Maybe msg -> Button msg -> Button msg
onTap onTapMsg btn =
    { btn | onTap = onTapMsg }


label : String -> Button msg -> Button msg
label lbl btn =
    { btn | label = Just lbl }


button : List (Element.Attribute msg) -> Button msg -> Element msg
button attr btn =
    let
        attrs : List (Element.Attribute msg)
        attrs =
            commonAttr ++ attr
    in
    Input.button
        (Maybe.unwrap attrs (\btn_ -> btnTypeAttr btn_ ++ attrs) btn.buttonType)
        { onPress = btn.onTap
        , label = Maybe.unwrap Element.none Element.text btn.label
        }



-- Internal


btnTypeAttr : ButtonType -> List (Element.Attribute msg)
btnTypeAttr type_ =
    case type_ of
        Outline ->
            Background.color Color.neutral
                :: Element.mouseOver [ Background.color Color.slate50 ]
                :: addBorder Color.zinc200

        Ghost ->
            [ Element.mouseOver [ Background.color Color.slate50 ]
            ]


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
    , Element.focused []
    , Font.size Size.text_sm
    , Font.letterSpacing 0.4
    , Font.family [ Font.sansSerif ]
    , Font.medium
    ]
        ++ transitions



-- Util


hideBorder : Element.Attribute msg
hideBorder =
    Border.width 0


addBorder : Element.Color -> List (Element.Attribute msg)
addBorder color =
    [ Border.width 1
    , Border.color color
    ]
