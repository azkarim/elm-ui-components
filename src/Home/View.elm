module Home.View exposing (document)

import Browser exposing (Document)
import Element exposing (Element, centerX, centerY, el, fill, height, image, inFront, paddingXY, px, rgb255, row, spacing, text, width, wrappedRow)
import Element.Background as Background
import Element.Border as Border
import Home.Data exposing (Option(..), optionStr)
import Home.Model as Home
import Home.Msg as Home exposing (Msg(..))
import UI.Button as Button
import UI.Drawer as Drawer
import UI.Preset.Color as Color
import UI.Preset.Icons as Icons
import UI.Preset.Size as Size
import UI.Preset.Util as Util
import UI.Select as Select


view : Home.Model -> Element Home.Msg
view model =
    wrappedRow
        [ width fill
        , height fill
        , spacing 10
        , Background.color (rgb255 255 255 255)
        , inFront (toggleDrawerBtn model)
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
        , Border.rounded Size.border_lg
        , Background.color Color.neutral50
        ]
        [ el [ centerX, centerY ] (text "I'm Drawer") ]


toggleDrawerBtn : Home.Model -> Element Msg
toggleDrawerBtn model =
    wrappedRow [ centerX, paddingXY 0 24, spacing 20 ]
        [ Button.ghost [] { onTap = Nothing, label = "Ghost" }
        , Button.outline Util.shadow { onTap = Just ToggleDrawer, label = "Toggle" }
        , Button.primary Util.shadow { onTap = Just ToggleDrawer, label = "Toggle" }
        , Button.secondary [] { onTap = Just ToggleDrawer, label = "Toggle" }
        , Button.iconBtn [] { onTap = Just ToggleDrawer, icon = Icons.renderIcon Icons.rightArrow }
        , Button.new
            |> Button.buttonType Button.Primary
            |> Button.onTap (Just ToggleDrawer)
            |> Button.icon (Icons.renderIcon Icons.email)
            |> Button.label "Login with Email"
            |> Button.loading (Button.Loading "Please wait...")
            |> Button.button []
        , Select.select [] selectConfig model.selectFruitState
        ]



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
