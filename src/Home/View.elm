module Home.View exposing (document)

import Browser exposing (Document)
import Element exposing (Element, centerX, centerY, el, fill, height, image, inFront, paddingXY, px, rgb255, row, spacing, text, width, wrappedRow)
import Element.Background as Background
import Element.Border as Border
import Home.Model as Home
import Home.Msg as Home exposing (Msg(..))
import UI.Button as Button
import UI.Drawer as Drawer
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import UI.Preset.Util as Util


view : Home.Model -> Element Home.Msg
view _ =
    wrappedRow
        [ width fill
        , height fill
        , spacing 10
        , Background.color (rgb255 255 255 255)
        , inFront toggleDrawerBtn
        ]
    <|
        loremLargeContent


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


toggleDrawerBtn : Element Msg
toggleDrawerBtn =
    row [ centerX, paddingXY 0 24, spacing 20 ]
        [ Button.ghost { onTap = Nothing, label = "Ghost" }
        , Button.outline Util.shadow { onTap = Just ToggleDrawer, label = "Toggle" }
        ]


document : Home.Model -> Document Home.Msg
document model =
    { title = "Home"
    , body = [ view model |> Drawer.layout model.drawer drawer ]
    }
