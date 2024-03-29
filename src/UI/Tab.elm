module UI.Tab exposing (ActiveStatus(..), Config, Msg, State, init, tab, update)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import UI.Theme exposing (theme)
import UI.Util as Util
import Util exposing (ifElse)


type alias State tab =
    { activeTab : tab
    }


type alias Config tab embedMsg =
    { tabs : List tab
    , toString : tab -> String
    , embedMsg : Msg tab -> embedMsg
    }


type alias CustomConfig tab embedMsg =
    { tabs : List tab
    , toElem : tab -> Element embedMsg
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
    let
        elemConfig : CustomConfig tab embedMsg
        elemConfig =
            { tabs = config.tabs
            , toElem = config.toString >> Element.text
            , embedMsg = config.embedMsg
            }
    in
    el attrs elemConfig state


type ActiveStatus
    = Active
    | InActive


el : List (Element.Attribute embedMsg) -> CustomConfig tab embedMsg -> State tab -> Element embedMsg
el attrs config state =
    config.tabs
        |> List.map
            (\tab_ ->
                renderTabEl
                    { tab = tab_
                    , toElem = config.toElem
                    , status = ifElse Active InActive (state.activeTab == tab_)
                    , embedMsg = config.embedMsg
                    }
            )
        |> Element.row (commonAttrs0 ++ attrs)


renderTabEl : { tab : tab, toElem : tab -> Element embedMsg, status : ActiveStatus, embedMsg : Msg tab -> embedMsg } -> Element embedMsg
renderTabEl config =
    Element.el (commonAttrs1 ++ dynamicAttrs1 config.status (SelectTab config.tab |> config.embedMsg))
        (Element.el [ Element.centerX ] (config.toElem config.tab))


commonAttrs0 : List (Element.Attribute embedMsg)
commonAttrs0 =
    Element.width Element.fill
        :: Element.paddingXY Size.padding_1 Size.padding_1
        :: Element.spaceEvenly
        :: Element.spacing Size.spacing_1
        :: Background.color Color.zinc_100
        :: Border.rounded theme.size.rounded
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
            , Font.color theme.color.font
            ]
                ++ Util.shadow

        InActive ->
            [ Font.color Color.zinc_500
            , Element.pointer
            , Events.onClick inactiveOnClick
            ]


commonAttrs1 : List (Element.Attribute msg)
commonAttrs1 =
    Element.width Element.fill
        :: Element.paddingXY Size.padding_3 Size.padding_2
        :: Border.rounded theme.size.rounded
        :: Util.transitions
