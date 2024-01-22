module Preview.Emails exposing (view)

import Element exposing (Element, alignTop, centerY, column, el, fill, height, paddingXY, paragraph, px, row, scrollbarY, spaceEvenly, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import List
import Preview.Data as Data
import Preview.Model as Preview exposing (Email, EmailTag(..), FilterEmail(..))
import Preview.Msg exposing (Msg(..))
import Preview.Util as Util
import UI.Badge as Badge
import UI.Preset.Color as Color
import UI.Preset.Size as Size
import UI.Tab as Tab
import UI.Theme exposing (theme)
import UI.Util as Util
import Util exposing (ifElse, userSelectNone)


view : Preview.Model -> Element Msg
view model =
    column [ width (px 700), height fill, Border.widthEach { right = 1, bottom = 0, left = 0, top = 0 }, Border.color theme.color.border, alignTop ]
        [ header model
        , el (Element.moveDown Size.spacing1 :: Util.divider) Element.none
        , emails
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
        , filterEmailsTabs model
        ]


filterEmailsTabs : Preview.Model -> Element Msg
filterEmailsTabs model =
    Tab.tab [ centerY, width (px Size.spacing42) ] { tabs = [ AllMail, Unread ], toString = filterEmailStr, embedMsg = FilterTab } model.filterEmails


emails : Element msg
emails =
    List.map email Data.emails
        |> column [ width fill, height fill, scrollbarY, Util.padding_md, Element.spacing Size.spacing3 ]


email : Email -> Element msg
email email_ =
    column
        (width fill
            :: paddingXY Size.spacing3 Size.spacing4
            :: Element.spacing Size.spacing2
            :: Border.rounded theme.size.rounded
            :: Font.medium
            :: Font.size Size.spacing3
            :: Element.pointer
            :: Element.mouseOver [ Background.color theme.color.hover ]
            :: Util.shadow
            ++ Util.addBorder
        )
        [ paragraph [ Font.semiBold, Font.letterSpacing 1.0 ] [ text <| email_.from ]
        , paragraph [ Font.letterSpacing 0.6 ] [ text <| email_.subject ]
        , paragraph [ width fill, Font.letterSpacing 0.6, Font.color Color.zinc500, paddingXY 0 Size.spacing2 ] [ text <| email_.body ]
        , row [ Element.spacing Size.spacing3 ] <|
            List.map (\tag -> Badge.badge [ Util.lowercase ] (emailTagStr tag) (ifElse Badge.Primary Badge.Secondary (highlightImportant tag))) email_.tags
        ]


highlightImportant : EmailTag -> Bool
highlightImportant tag =
    case tag of
        Important ->
            True

        _ ->
            False


emailTagStr : EmailTag -> String
emailTagStr tag =
    case tag of
        Meeting ->
            "Meeting"

        Work ->
            "Work"

        Important ->
            "Important"

        Budget ->
            "Budget"


filterEmailStr : FilterEmail -> String
filterEmailStr filter =
    case filter of
        AllMail ->
            "All mail"

        Unread ->
            "Unread"
