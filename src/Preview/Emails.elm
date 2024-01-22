module Preview.Emails exposing (view)

import Element exposing (Element, alignTop, centerY, column, el, fill, height, px, row, spaceEvenly, text, width)
import Element.Border as Border
import Element.Font as Font
import Preview.Model as Preview exposing (FilterEmail(..))
import Preview.Msg exposing (Msg(..))
import Preview.Util as Util
import UI.Preset.Size as Size
import UI.Tab as Tab
import UI.Theme exposing (theme)
import UI.Util as Util
import Util exposing (userSelectNone)


view : Preview.Model -> Element Msg
view model =
    column [ width (px 700), height fill, Border.widthEach { right = 1, bottom = 0, left = 0, top = 0 }, Border.color theme.color.border, alignTop ]
        [ header model
        , el (Element.moveDown Size.spacing1 :: Util.divider) Element.none
        ]


header : Preview.Model -> Element Msg
header model =
    row
        [ width fill
        , height (px Size.spacing13)
        , spaceEvenly
        , Util.padding
        ]
        [ el (Font.bold :: centerY :: userSelectNone) (text "Inbox")
        , Tab.tab [ centerY, width (px Size.spacing42) ] { tabs = [ AllMail, Unread ], toString = filterTab, embedMsg = FilterTab } model.filterEmails
        ]


filterTab : FilterEmail -> String
filterTab filter =
    case filter of
        AllMail ->
            "All mail"

        Unread ->
            "Unread"
