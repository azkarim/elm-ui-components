module UI.Tab exposing (ActiveStatus(..), Config, Msg, State, init, tab, update)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import UI.Preset.Util as Util
import UI.Theme exposing (theme)
import Util exposing (ifElse)


type alias State tab =
    { activeTab : tab
    }


type alias Config tab embedMsg =
    { tabs : List tab
    , toString : tab -> String
    , embedMsg : Msg tab -> embedMsg
    }


init : tab -> State tab
init =
    State


type Msg tab
    = SelectTab tab


update : Msg tab -> State tab -> State tab
update msg state =
    case msg of
        SelectTab tabSelected ->
            { state | activeTab = tabSelected }


tab : List (Element.Attribute embedMsg) -> Config tab embedMsg -> State tab -> Element embedMsg
tab attrs config state =
    config.tabs
        |> List.map
            (\tab_ ->
                renderTabEl
                    { tab = tab_
                    , toString = config.toString
                    , status = ifElse Active InActive (state.activeTab == tab_)
                    , embedMsg = config.embedMsg
                    }
            )
        |> Element.row (commonAttrs0 ++ attrs)


type ActiveStatus
    = Active
    | InActive


renderTabEl : { tab : tab, toString : tab -> String, status : ActiveStatus, embedMsg : Msg tab -> embedMsg } -> Element embedMsg
renderTabEl config =
    Element.el (commonAttrs1 ++ dynamicAttrs1 config.status (SelectTab config.tab |> config.embedMsg))
        (Element.el [ Element.centerX ] (Element.text <| config.toString config.tab))


commonAttrs0 : List (Element.Attribute embedMsg)
commonAttrs0 =
    Element.width Element.fill
        :: Element.paddingXY Size.padding_1 Size.padding_1
        :: Element.spaceEvenly
        :: Element.spacing Size.spacing1
        :: Background.color Color.zinc100
        :: Border.rounded theme.borderRounded
        :: Element.focused []
        :: Font.size Size.text_xs
        :: Font.letterSpacing 0.8
        :: Font.family [ Font.sansSerif ]
        :: Font.medium
        :: Util.userSelectNone


dynamicAttrs1 : ActiveStatus -> embedMsg -> List (Element.Attribute embedMsg)
dynamicAttrs1 status inactiveOnClick =
    case status of
        Active ->
            [ Background.color Color.neutral
            , Font.color Color.zinc900
            ]
                ++ Util.shadow

        InActive ->
            [ Font.color Color.zinc500
            , Element.pointer
            , Events.onClick inactiveOnClick
            ]


commonAttrs1 : List (Element.Attribute msg)
commonAttrs1 =
    Element.width Element.fill
        :: Element.paddingXY Size.padding_3 Size.padding_2
        :: Border.rounded theme.borderRounded
        :: transitions


transitions : List (Element.Attribute msg)
transitions =
    [ Util.style "transition-property" "color,background-color"
    , Util.style "transition-timing-function" "cubic-bezier(.4,0,.2,1)"
    , Util.style "transition-duration" "0.15s"
    ]
