module UI.Button exposing (Button, ButtonType(..), LoadingStatus(..), button, buttonType, ghost, icon, iconBtn, label, loading, new, onTap, outline, primary, secondary)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import Loading
import Maybe.Extra as Maybe
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import Util



-- todo : add ring state when focued


primary : List (Element.Attribute msg) -> { a | onTap : Maybe msg, label : String } -> Element msg
primary attrs btn =
    new
        |> buttonType Primary
        |> onTap btn.onTap
        |> label btn.label
        |> button attrs


secondary : List (Element.Attribute msg) -> { a | onTap : Maybe msg, label : String } -> Element msg
secondary attrs btn =
    new
        |> buttonType Secondary
        |> onTap btn.onTap
        |> label btn.label
        |> button attrs


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


iconBtn : List (Element.Attribute msg) -> { a | onTap : Maybe msg, icon : Element msg } -> Element msg
iconBtn attrs btn =
    new
        |> buttonType Icon
        |> icon btn.icon
        |> onTap btn.onTap
        |> button attrs


type alias Button msg =
    { buttonType : Maybe ButtonType
    , icon : Maybe (Element msg)
    , onTap : Maybe msg
    , label : Maybe String
    , loading : LoadingStatus
    }


type ButtonType
    = Primary
    | Secondary
    | Outline
    | Ghost
    | Icon


type LoadingStatus
    = Loading String
    | Loaded


{-| Button Builder

    Button.new
        |> Button.buttonType Primary
        |> Button.onTap Toggle
        |> Button.label "Toggle"
        |> Button.button

-}
new : Button msg
new =
    { buttonType = Nothing
    , icon = Nothing
    , onTap = Nothing
    , label = Nothing
    , loading = Loaded
    }


buttonType : ButtonType -> Button msg -> Button msg
buttonType btnType btn =
    { btn | buttonType = Just btnType }


icon : Element msg -> Button msg -> Button msg
icon el btn =
    { btn | icon = Just el }


onTap : Maybe msg -> Button msg -> Button msg
onTap onTapMsg btn =
    { btn | onTap = onTapMsg }


label : String -> Button msg -> Button msg
label lbl btn =
    { btn | label = Just lbl }


loading : LoadingStatus -> Button msg -> Button msg
loading status btn =
    { btn | loading = status }


button : List (Element.Attribute msg) -> Button msg -> Element msg
button attrs btn =
    let
        attrs_ : List (Element.Attribute msg)
        attrs_ =
            -- user supplied attrs should come last to take precedence
            commonAttrs ++ attrs
    in
    Input.button
        (if btn.loading == Loaded then
            Maybe.unwrap attrs_ (\btn_ -> btnTypeAttrs btn_ ++ attrs_) btn.buttonType

         else
            loadingStatusAttrs ++ attrs_
        )
        { onPress = btn.onTap
        , label =
            case btn.loading of
                Loading loadingLabel ->
                    Element.row [ Element.spacing 12 ] [ Element.el [] spinner, Element.el [] (Element.text loadingLabel) ]

                Loaded ->
                    renderLabel ( btn.icon, btn.label )
        }


renderLabel : ( Maybe (Element msg), Maybe String ) -> Element msg
renderLabel pair =
    case pair of
        ( Nothing, Nothing ) ->
            Element.none

        ( Just icon_, Just label_ ) ->
            Element.row [ Element.width Element.fill, Element.spacing 8 ] [ icon_, Element.el [] (Element.text label_) ]

        ( Just icon_, Nothing ) ->
            icon_

        ( Nothing, Just label_ ) ->
            Element.text label_



-- Internal


loadingStatusAttrs : List (Element.Attribute msg)
loadingStatusAttrs =
    [ Background.color Color.loading
    , Font.color Color.neutral
    , Util.style "pointer-events" "none"
    , Util.style "cursor" "not-allowed"
    ]


btnTypeAttrs : ButtonType -> List (Element.Attribute msg)
btnTypeAttrs type_ =
    case type_ of
        Primary ->
            [ Background.color Color.preset.primary
            , Font.color Color.neutral
            , Element.mouseOver [ Color.preset.primary |> Color.setAlpha 0.9 |> Background.color ]
            ]

        Secondary ->
            [ Background.color Color.preset.secondary
            , Element.mouseOver [ Color.preset.secondary |> Color.setAlpha 0.9 |> Background.color ]
            ]

        Outline ->
            Background.color Color.neutral
                :: Element.mouseOver [ Background.color Color.slate50 ]
                :: addBorder Color.zinc200

        Ghost ->
            [ Element.mouseOver [ Background.color Color.slate50 ]
            ]

        Icon ->
            Background.color Color.neutral
                :: Element.mouseOver [ Background.color Color.slate50 ]
                :: addBorder Color.zinc200


commonAttrs : List (Element.Attribute msg)
commonAttrs =
    let
        transitions : List (Element.Attribute msg)
        transitions =
            -- todo : replace with anim library
            [ Html.Attributes.style "transition-property" "color,background-color,border-color,text-decoration-color,fill,stroke"
            , Html.Attributes.style "transition-timing-function" "cubic-bezier(.4,0,.2,1)"
            , Html.Attributes.style "transition-duration" "0.15s"
            ]
                |> Util.fromAtrrs
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


spinner : Element msg
spinner =
    let
        color : String
        color =
            -- Colors.neutral
            "#ffffff"

        config : Loading.Config
        config =
            Loading.defaultConfig
    in
    Loading.render
        Loading.Spinner
        { config | size = 16, color = color }
        Loading.On
        |> Element.html



-- Util


addBorder : Element.Color -> List (Element.Attribute msg)
addBorder color =
    [ Border.width 1
    , Border.color color
    ]
