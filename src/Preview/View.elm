module Preview.View exposing (document)

import Browser exposing (Document)
import Element exposing (Element, alignRight, alignTop, centerX, centerY, column, el, fill, height, paddingXY, px, row, spaceEvenly, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Heroicons.Outline as Heroicons
import Html exposing (Html)
import Maybe.Extra as Maybe
import Preview.Model as Preview exposing (Email, EmailSection(..), FilterEmail(..), Unread, accounts, dataEmailSections, filterTabLabel, iconsForAccount, isEmailSectionEqual, user)
import Preview.Msg as Preview exposing (Msg(..))
import UI.Button as Button
import UI.Preset.Color as Color
import UI.Preset.Icon as Icon
import UI.Preset.Size as Size
import UI.Select as Select
import UI.Tab as Tab
import UI.Theme exposing (theme)
import UI.Util as Util
import Util exposing (ifElse, userSelectNone)


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
        [ menu model
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
        , padding
        ]
        [ el (Font.bold :: centerY :: userSelectNone) (text "Inbox")
        , Tab.tab [ centerY, width (px Size.spacing42) ] { tabs = [ AllMail, Unread ], toString = filterTabLabel, embedMsg = FilterTab } model.filterEmails
        ]



-- Menu : Email Section


menu : Preview.Model -> Element Msg
menu model =
    column
        [ width (px 230)
        , height fill
        , Border.widthEach { right = theme.size.border, bottom = 0, left = 0, top = 0 }
        , Border.color theme.color.border
        ]
        [ el [ width fill, padding, height (px Size.spacing14) ] (selectAccount model)
        , el Util.divider Element.none
        , renderMenu emailManagementSections model
        , el Util.divider Element.none
        , renderMenu labelledEmails model
        ]


renderMenu : List EmailSection -> Preview.Model -> Element Msg
renderMenu sections model =
    column [ width fill, padding, Element.spacing Size.spacing1 ] <| renderEmailSectionBtns sections model.currentEmailSection


emailManagementSections : List EmailSection
emailManagementSections =
    List.take 6 dataEmailSections


labelledEmails : List EmailSection
labelledEmails =
    List.drop 6 dataEmailSections


renderEmailSectionBtns : List EmailSection -> EmailSection -> List (Element Msg)
renderEmailSectionBtns sections currentEmailSection =
    sections
        |> List.map
            (\section ->
                Button.button [ width fill, Font.size Size.spacing3 ]
                    { buttonType = Just <| ifElse Button.Primary Button.Ghost (isEmailSectionEqual section currentEmailSection)
                    , icon = Just <| (section |> emailSectionIcon |> Element.html |> Util.renderIcon)
                    , onTap = Just <| OnTapEmailSection section
                    , label = Just <| emailSectionBtnLabel section
                    , loading = Nothing
                    }
            )


emailSectionBtnLabel : EmailSection -> Element msg
emailSectionBtnLabel section =
    let
        unread_ : Maybe Unread -> Element msg
        unread_ count =
            el [ alignRight ] (Maybe.unwrap Element.none (String.fromInt >> text) count)

        label : String -> Element msg
        label lbl =
            el [] (text lbl)

        renderLabel : String -> Maybe Unread -> Element msg
        renderLabel lbl unreadCount =
            row [ width fill ]
                [ label lbl
                , unread_ unreadCount
                ]
    in
    case section of
        Inbox unread ->
            renderLabel "Inbox" unread

        Drafts unread ->
            renderLabel "Drafts" unread

        Sent unread ->
            renderLabel "Sent" unread

        Junk unread ->
            renderLabel "Junk" unread

        Trash unread ->
            renderLabel "Trash" unread

        Archive unread ->
            renderLabel "Archive" unread

        Social unread ->
            renderLabel "Social" unread

        Updates unread ->
            renderLabel "Updates" unread

        Forums unread ->
            renderLabel "Forums" unread

        Shopping unread ->
            renderLabel "Shopping" unread

        Promotions unread ->
            renderLabel "Promotions" unread


emailSectionIcon : EmailSection -> Html msg
emailSectionIcon section =
    case section of
        Inbox _ ->
            Heroicons.inbox []

        Drafts _ ->
            Heroicons.document []

        Sent _ ->
            Heroicons.paperAirplane []

        Junk _ ->
            Heroicons.archiveBoxXMark []

        Trash _ ->
            Heroicons.trash []

        Archive _ ->
            Heroicons.archiveBox []

        Social _ ->
            Heroicons.users []

        Updates _ ->
            Heroicons.informationCircle []

        Forums _ ->
            Heroicons.chatBubbleLeft []

        Shopping _ ->
            Heroicons.shoppingBag []

        Promotions _ ->
            Heroicons.gift []



-- Account


selectAccount : Preview.Model -> Element Msg
selectAccount model =
    Select.el Util.shadow selectAccountConfig model.account


selectAccountConfig : Select.CustomConfig Email Preview.Msg
selectAccountConfig =
    let
        label : Element msg
        label =
            row [ centerY, spaceEvenly ]
                [ row [ spacing ]
                    [ Util.renderIcon Icon.user
                    , el [] (text <| user)
                    ]
                , el [] (Util.renderIcon Icon.upDown)
                ]

        item : Email -> Element msg
        item email =
            row [ spacing, centerY, Font.size Size.spacing3 ]
                [ Util.renderIcon <| iconsForAccount email
                , el [] (text email)
                ]

        itemAsSelected : Email -> Element msg
        itemAsSelected email =
            row [ spacing ]
                [ item email
                , Util.renderIcon Icon.check
                ]

        itemAsLabel : String -> Element msg
        itemAsLabel email =
            row [ centerY, spaceEvenly, width fill ]
                [ row [ spacing ]
                    [ Util.renderIcon <| iconsForAccount email
                    , el [] (text user)
                    ]
                , Util.renderIcon <| Icon.upDown
                ]

        spacing : Element.Attribute msg
        spacing =
            Element.spacing Size.spacing3
    in
    { label = label
    , options = accounts
    , item = item
    , itemAsSelected = itemAsSelected
    , itemAsLabel = itemAsLabel
    , embedMsg = SelectAccount
    }


padding : Element.Attribute msg
padding =
    paddingXY Size.spacing3 Size.spacing2


document : Preview.Model -> Document Preview.Msg
document model =
    { title = "Preview"
    , body = [ view model |> Element.layout [ Element.width Element.fill, Element.height Element.fill ] ]
    }
