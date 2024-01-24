module Components.View exposing (document)

import Browser exposing (Document)
import Components.Data as Data exposing (Option(..), UserSettingsTab(..), optionStr)
import Components.Model as Components
import Components.Msg as Components exposing (Msg(..))
import Element exposing (Element, alignTop, centerX, centerY, el, fill, height, paddingXY, px, row, spacing, text, width, wrappedRow)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import UI.Avatar as Avatar
import UI.Badge as Badge
import UI.Button as Button
import UI.Drawer as Drawer
import UI.Preset.Color as Color
import UI.Preset.Icon as Icon
import UI.Preset.Size as Size
import UI.Select as Select
import UI.Tab as Tab
import UI.Util as Util


view : Components.Model -> Element Components.Msg
view model =
    wrappedRow
        [ width fill
        , height fill
        , spacing 10
        , Background.color Color.neutral
        ]
    <|
        [ uiSet model
        ]


drawer : Element msg
drawer =
    row
        [ width fill
        , height (px 400)
        , Border.roundEach { topLeft = Size.border_lg, topRight = Size.border_lg, bottomRight = 0, bottomLeft = 0 }
        , Background.color Color.neutral_50
        ]
        [ el [ centerX, centerY, Font.medium ] (text "Drawer") ]


uiSet : Components.Model -> Element Msg
uiSet model =
    wrappedRow [ width (fill |> Element.maximum 1280), centerX, alignTop, paddingXY Size.spacing_10 Size.spacing_10, spacing 20 ]
        [ Button.primary Util.shadow { onTap = Nothing, label = "Primary" }
        , Button.secondary [] { onTap = Nothing, label = "Secondary" }
        , Button.outline Util.shadow { onTap = Nothing, label = "Outline" }
        , Button.ghost [] { onTap = Nothing, label = "Ghost" }
        , Button.iconBtn [] { onTap = Nothing, icon = Util.renderIcon Icon.rightArrow }
        , exampleLoadingBtn
        , emailBtn
        , Select.select [] selectConfig model.selectFruitState
        , Badge.primary "primary"
        , Badge.secondary "secondary"
        , Badge.outline "outline"
        , Badge.badge [ Border.rounded 12, Events.onClick ToggleDrawer, Element.paddingXY Size.padding_3 Size.padding_2, Element.pointer ] "Metric" Badge.Secondary
        , Tab.tab [ Element.width (Element.fill |> Element.minimum 200) ] tabConfig model.userSettingsTab
        , Button.outline Util.shadow { onTap = Just ToggleDrawer, label = "Drawer" }
        , Avatar.avatar [] (Element.el [] (text "AK"))
        ]


exampleLoadingBtn : Element Msg
exampleLoadingBtn =
    Button.new
        |> Button.buttonType Button.Primary
        |> Button.onTap Nothing
        |> Button.icon (Util.renderIcon Icon.email)
        |> Button.label "Login with Email"
        |> Button.loading (Button.Loading "Please wait...")
        |> Button.button []


emailBtn : Element Msg
emailBtn =
    Button.button [ Element.width (px 200) ]
        { buttonType = Just Button.Ghost
        , icon = Just <| Util.renderIcon (Util.renderIcon Icon.email)
        , onTap = Nothing
        , label = Just <| emailLabel 10
        , loading = Just <| Button.Loaded
        }


emailLabel : Int -> Element msg
emailLabel counter =
    Element.row [ Element.width fill, Element.spaceEvenly ]
        [ Element.el [ Element.moveRight 10 ] (Element.text "Email")
        , Element.el [ Element.alignRight ] (Element.text <| String.fromInt counter)
        ]


tabConfig : Tab.Config Data.UserSettingsTab Msg
tabConfig =
    { tabs = [ Account, Password ]
    , toString = Data.tabStr
    , embedMsg = UserSettingsTabSelected
    }



-- Select


selectConfig : Select.Config Option Components.Msg
selectConfig =
    { label = "Select a fruit"
    , options = options
    , toString = optionStr
    , embedMsg = SelectFruit
    }


options : List Option
options =
    [ Apple, Banana, Blueberry, Grapes, Pineapple ]


document : Components.Model -> Document Components.Msg
document model =
    { title = "Components"
    , body = [ view model |> Drawer.layout model.drawer drawer ]
    }
