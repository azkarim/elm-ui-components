module Preview.View exposing (document)

import Browser exposing (Document)
import Element exposing (Element, alignTop, centerX, centerY, column, el, fill, height, px, row, spaceEvenly, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Preview.Model as Preview exposing (FilterEmail(..))
import Preview.Msg as Preview exposing (Msg(..))
import Preview.SidebarMenu as SidebarMenu
import Preview.Util as Util
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import UI.Tab as Tab
import UI.Theme exposing (theme)
import UI.Util as Util
import Util exposing (userSelectNone)


view : Preview.Model -> Element Preview.Msg
view model =
    row
        (centerX
            :: centerY
            :: width (fill |> Element.maximum 1340)
            :: height (fill |> Element.maximum 800)
            :: Background.color Color.neutral
            :: Border.rounded theme.size.rounded
            :: Util.addBorder
            ++ Util.shadow_xl
        )
    <|
        [ SidebarMenu.view model
        , emailListTab model
        ]


emailListTab : Preview.Model -> Element Msg
emailListTab model =
    column [ width (px 700), height fill, Border.widthEach { right = 1, bottom = 0, left = 0, top = 0 }, Border.color theme.color.border, alignTop ]
        [ emailListTabBar model
        , el (Element.moveDown Size.spacing1 :: Util.divider) Element.none
        ]


emailListTabBar : Preview.Model -> Element Msg
emailListTabBar model =
    row
        [ width fill
        , height (px Size.spacing13)
        , spaceEvenly
        , Util.padding
        ]
        [ el (Font.bold :: centerY :: userSelectNone) (text "Inbox")
        , Tab.tab [ centerY, width (px Size.spacing42) ] { tabs = [ AllMail, Unread ], toString = filterTabLabel, embedMsg = FilterTab } model.filterEmails
        ]


filterTabLabel : FilterEmail -> String
filterTabLabel filter =
    case filter of
        AllMail ->
            "All mail"

        Unread ->
            "Unread"


document : Preview.Model -> Document Preview.Msg
document model =
    { title = "Preview"
    , body = [ view model |> Element.layout [ Element.width Element.fill, Element.height Element.fill ] ]
    }
