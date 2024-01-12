module Home.View exposing (document)

import Browser exposing (Document)
import Element exposing (Element, centerX, centerY, fill, height, image, inFront, spacing, text, width, wrappedRow)
import Element.Input as Input
import Home.Drawer as Drawer
import Home.Model as Home
import Home.Msg as Home exposing (Msg(..))


view : Home.Model -> Element Home.Msg
view _ =
    wrappedRow
        [ width fill
        , height fill
        , spacing 10
        , inFront toggleDrawerBtn
        ]
        (List.range 0 50 |> List.map (\_ -> image [] { src = "https://picsum.photos/200/300", description = "" }))


toggleDrawerBtn : Element Msg
toggleDrawerBtn =
    Input.button [ centerX, centerY ] { onPress = Just ToggleDrawer, label = text "Show Drawer" }


document : Home.Model -> Document Home.Msg
document model =
    { title = "Home"
    , body = [ view model |> Drawer.layout model.drawer ]
    }
