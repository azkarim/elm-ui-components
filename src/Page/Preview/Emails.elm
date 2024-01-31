module Page.Preview.Emails exposing (view)

import Element exposing (Element, alignTop, centerY, column, el, fill, height, paddingXY, paragraph, px, row, scrollbarY, spaceEvenly, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import List
import Page.Preview.Data as Data
import Page.Preview.Model as Preview exposing (Email, EmailId, EmailTag(..), FilterEmail(..))
import Page.Preview.Msg exposing (Msg(..))
import Page.Preview.Util as Util
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
        , el (Element.moveDown Size.spacing_1 :: Util.divider) Element.none
        , el [ width fill, height (px Size.spacing_1) ] Element.none -- spacer
        , emails model
        ]


header : Preview.Model -> Element Msg
header model =
    row
        [ width fill
        , height (px Size.spacing_13)
        , spaceEvenly
        , Util.padding
        ]
        [ el (Font.bold :: centerY :: userSelectNone) (text "Inbox")
        , filterEmailsTabs model
        ]


filterEmailsTabs : Preview.Model -> Element Msg
filterEmailsTabs model =
    Tab.tab [ centerY, width (px Size.spacing_42) ] { tabs = [ AllMail, Unread ], toString = filterEmailStr, embedMsg = FilterTab } model.filterEmails


emails : Preview.Model -> Element Msg
emails model =
    let
        predicate : Email -> Maybe Email
        predicate email_ =
            case model.filterEmails.activeTab of
                AllMail ->
                    Just email_

                Unread ->
                    ifElse (Just email_) Nothing (not email_.read)
    in
    Data.emails
        |> List.filterMap (predicate >> Maybe.map (email model.viewEmail))
        |> column [ width fill, height fill, scrollbarY, Util.padding_md, Element.spacing Size.spacing_3 ]


email : EmailId -> Email -> Element Msg
email selectedEmail email_ =
    column
        (width fill
            :: paddingXY Size.spacing_3 Size.spacing_4
            :: Element.spacing Size.spacing_2
            :: Border.rounded theme.size.rounded
            :: ifElse (Background.color theme.color.hover) (Background.color Color.neutral) (selectedEmail == email_.id)
            :: Font.medium
            :: Font.size Size.spacing_3
            :: Element.pointer
            :: Events.onClick (OnTapViewEmail email_.id)
            :: Element.mouseOver [ Background.color theme.color.hover ]
            :: Util.shadow
            ++ highlightBorder email_
            ++ Util.transitions
        )
        [ paragraph [ Font.semiBold, Font.letterSpacing 1.0 ] [ text <| email_.from ]
        , paragraph [ Font.letterSpacing 0.6 ] [ text <| email_.subject ]
        , paragraph [ width fill, Font.letterSpacing 0.6, Font.color Color.zinc_500, paddingXY 0 Size.spacing_2, Element.spacing Size.spacing_2 ] [ text <| email_.body ]
        , row [ Element.spacing Size.spacing_3 ] <|
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


highlightBorder : { a | read : Bool } -> List (Element.Attribute msg)
highlightBorder { read } =
    ifElse Util.glowBorder Util.addBorder (not read)
