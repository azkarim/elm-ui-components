module Home.View exposing (document)

import Browser exposing (Document)
import Element exposing (Element, centerX, centerY, el, fill, height, image, inFront, paddingXY, px, rgb255, row, spacing, text, width, wrappedRow)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Home.Data as Data exposing (Option(..), UserSettingsTab(..), optionStr)
import Home.Model as Home
import Home.Msg as Home exposing (Msg(..))
import UI.Badge as Badge
import UI.Button as Button
import UI.Drawer as Drawer
import UI.Preset.Color as Color
import UI.Preset.Icon as Icon
import UI.Preset.Size as Size
import UI.Preset.Util as Util
import UI.Select as Select
import UI.Tab as Tab
import Util


view : Home.Model -> Element Home.Msg
view model =
    wrappedRow
        [ width fill
        , height fill
        , spacing 10
        , Background.color (rgb255 255 255 255)
        , inFront (uiSet model)
        ]
    <|
        []


loremLargeContent : List (Element msg)
loremLargeContent =
    List.range 0 100
        |> List.map (\_ -> image [] { src = "https://picsum.photos/200", description = "lorem image" })


drawer : Element msg
drawer =
    row
        [ width fill
        , height (px 400)
        , Border.roundEach { topLeft = Size.border_lg, topRight = Size.border_lg, bottomRight = 0, bottomLeft = 0 }
        , Background.color Color.neutral50
        ]
        [ el [ centerX, centerY ] (text "I'm Drawer") ]


uiSet : Home.Model -> Element Msg
uiSet model =
    wrappedRow [ centerX, paddingXY 24 24, spacing 20 ]
        [ Button.ghost [] { onTap = Nothing, label = "Ghost" }
        , Button.outline Util.shadow { onTap = Just ToggleDrawer, label = "Toggle" }
        , Button.primary Util.shadow { onTap = Just ToggleDrawer, label = "Toggle" }
        , Button.secondary [] { onTap = Just ToggleDrawer, label = "Toggle" }
        , Button.iconBtn [] { onTap = Just ToggleDrawer, icon = Icon.renderIcon Icon.rightArrow }
        , Button.new
            |> Button.buttonType Button.Primary
            |> Button.onTap (Just ToggleDrawer)
            |> Button.icon (Icon.renderIcon Icon.email)
            |> Button.label "Login with Email"
            |> Button.loading (Button.Loading "Please wait...")
            |> Button.button []
        , Select.select [] selectConfig model.selectFruitState
        , Badge.primary "work"
        , Badge.secondary "budget"
        , Badge.outline "outline"
        , Badge.badge [ Border.rounded 12, Events.onClick ToggleDrawer, Element.paddingXY Size.padding_3 Size.padding_2, Element.pointer ] "Dashboard" Badge.Secondary
        , Tab.tab [ Element.width (Element.fill |> Element.minimum 200) ] tabConfig model.userSettingsTab
        ]


tabConfig : Tab.Config Data.UserSettingsTab Msg
tabConfig =
    { tabs = [ Account, Password ]
    , toString = Data.tabStr
    , embedMsg = UserSettingsTabSelected
    }



-- Select


selectConfig : Select.Config Home.Msg Option
selectConfig =
    { label = "Select a fruit"
    , options = options
    , toString = optionStr
    , embedMsg = SelectFruit
    }


options : List Option
options =
    [ Apple, Banana, Blueberry, Grapes, Pineapple ]


document : Home.Model -> Document Home.Msg
document model =
    { title = "Home"
    , body = [ view model |> Drawer.layout model.drawer drawer ]
    }
