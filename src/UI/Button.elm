module UI.Button exposing (Button, ButtonType(..), LoadingStatus(..), button, buttonType, ghost, icon, iconBtn, label, loading, new, onTap, outline, primary, secondary)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Loading
import Maybe.Extra as Maybe
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import UI.Theme exposing (theme)
import UI.Util as Util
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
    , label : Maybe (Element msg)
    , loading : Maybe LoadingStatus
    }


type ButtonType
    = Primary
    | Secondary
    | Outline
    | Ghost
    | Icon


type LoadingStatus
    = Loading String
    | Idle


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
    , label = Nothing
    , icon = Nothing
    , onTap = Nothing
    , loading = Nothing
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
    btn |> elemLabel (Element.text lbl)


elemLabel : Element msg -> Button msg -> Button msg
elemLabel elem btn =
    { btn | label = Just elem }


loading : LoadingStatus -> Button msg -> Button msg
loading status btn =
    { btn | loading = Just status }


{-| A button

    type alias Button msg =
        { buttonType : Maybe ButtonType
        , icon : Maybe (Element msg)
        , onTap : Maybe msg
        , label : Maybe (Element msg)
        , loading : Maybe LoadingStatus
        }

-}
button : List (Element.Attribute msg) -> Button msg -> Element msg
button attrs btn =
    let
        attrs_ : List (Element.Attribute msg)
        attrs_ =
            -- user supplied attrs should come last to take precedence
            commonAttrs ++ attrs

        btnLoaded : Bool
        btnLoaded =
            (btn.loading == Just Idle) || (btn.loading == Nothing)
    in
    Input.button
        (if btnLoaded then
            Maybe.unwrap attrs_ (\btn_ -> btnTypeAttrs btn_ ++ attrs_) btn.buttonType

         else
            loadingStatusAttrs ++ attrs_
        )
        { onPress = btn.onTap
        , label =
            case btn.loading of
                Just (Loading loadingLabel) ->
                    Element.row [ Element.spacing Size.spacing_3 ] [ Element.el [] spinner, Element.el [] (Element.text loadingLabel) ]

                Just Idle ->
                    renderElemLabel ( btn.icon, btn.label )

                Nothing ->
                    renderElemLabel ( btn.icon, btn.label )
        }



-- Internal


renderElemLabel : ( Maybe (Element msg), Maybe (Element msg) ) -> Element msg
renderElemLabel pair =
    case pair of
        ( Nothing, Nothing ) ->
            Element.none

        ( Just icon_, Just label_ ) ->
            Element.row [ Element.width Element.fill, Element.spacing Size.spacing_2 ] [ icon_, label_ ]

        ( Just icon_, Nothing ) ->
            icon_

        ( Nothing, Just label_ ) ->
            label_


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
            [ Background.color theme.color.primary
            , Font.color Color.neutral
            , Element.mouseOver [ theme.color.primary |> Util.setAlpha 0.9 |> Background.color ]
            ]

        Secondary ->
            [ Background.color theme.color.secondary
            , Element.mouseOver [ theme.color.secondary |> Util.setAlpha 0.9 |> Background.color ]
            ]

        Outline ->
            Background.color Color.neutral
                :: Element.mouseOver [ Background.color Color.slate_50 ]
                :: Util.addBorder

        Ghost ->
            [ Element.mouseOver [ Background.color Color.slate_50 ]
            ]

        Icon ->
            Background.color Color.neutral
                :: Element.mouseOver [ Background.color Color.slate_50 ]
                :: Util.addBorder


commonAttrs : List (Element.Attribute msg)
commonAttrs =
    [ Element.paddingXY Size.padding_4 Size.padding_3
    , Border.rounded theme.size.rounded
    , Element.focused []
    , Font.size Size.text_sm
    , Font.letterSpacing 0.4
    , Font.family [ Font.sansSerif ]
    , Font.medium
    ]
        ++ Util.transitions


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
        { config | size = Size.spacing_4, color = color }
        Loading.On
        |> Element.html
