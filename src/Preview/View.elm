module Preview.View exposing (document)

import Browser exposing (Document)
import Element exposing (Element, centerX, centerY, fill, height, row, width)
import Element.Background as Background
import Element.Border as Border
import Preview.Emails as Emails
import Preview.Model as Preview
import Preview.Msg as Preview
import Preview.SidebarMenu as SidebarMenu
import Preview.ViewEmail as ViewEmail
import UI.Preset.Color as Color
import UI.Theme exposing (theme)
import UI.Util as Util


view : Preview.Model -> Element Preview.Msg
view model =
    row
        (centerX
            :: centerY
            :: width fill
            :: height fill
            :: Background.color Color.neutral
            :: Border.rounded theme.size.rounded
            :: Util.addBorder
            ++ Util.shadow_xl
        )
    <|
        [ SidebarMenu.view model
        , Emails.view model
        , ViewEmail.view model
        ]


document : Preview.Model -> Document Preview.Msg
document model =
    { title = "Preview"
    , body = [ view model |> Element.layout [ Element.width Element.fill, Element.height Element.fill, Util.noOverflowX ] ]
    }
