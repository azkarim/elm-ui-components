module Home.View exposing (document)

import Browser exposing (Document)
import Element exposing (Element, centerX, el, fill, height, rgb255, spacing, width, wrappedRow)
import Element.Background as Background
import Element.Border as Border
import Home.Button as Button
import Home.Drawer as Drawer
import Home.Model as Home
import Home.Msg as Home exposing (Msg(..))
import Util exposing (ifElse)


view : Home.Model -> Element Home.Msg
view { drawer } =
    wrappedRow
        [ width fill
        , height fill
        , ifElse (Border.rounded 8) Util.noAttr drawer.isVisible
        , spacing 10
        , Background.color (rgb255 255 255 255)
        ]
        [ toggleDrawerBtn ]


toggleDrawerBtn : Element Msg
toggleDrawerBtn =
    el [ centerX ] (Button.outline { onTap = Just ToggleDrawer, label = "Toggle" })


document : Home.Model -> Document Home.Msg
document model =
    { title = "Home"
    , body = [ view model |> Drawer.layout model.drawer ]
    }
