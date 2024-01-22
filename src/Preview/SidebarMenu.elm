module Preview.SidebarMenu exposing (view)

import Element exposing (Element, alignRight, centerY, column, el, fill, height, px, row, spaceEvenly, text, width)
import Element.Border as Border
import Element.Font as Font
import Heroicons.Outline as Heroicons
import Html exposing (Html)
import Maybe.Extra as Maybe
import Preview.Data as Data
import Preview.Model as Preview exposing (EmailAddress, EmailLabel(..), Unread)
import Preview.Msg as Preview exposing (Msg(..))
import Preview.Util as Util
import UI.Button as Button
import UI.Preset.Icon as Icon
import UI.Preset.Size as Size
import UI.Select as Select
import UI.Theme exposing (theme)
import UI.Util as Util
import Util exposing (ifElse)


view : Preview.Model -> Element Msg
view model =
    column
        [ width (px 230)
        , height fill
        , Border.widthEach { right = theme.size.border, bottom = 0, left = 0, top = 0 }
        , Border.color theme.color.border
        ]
        [ selectAccount model
        , el Util.divider Element.none
        , emailMenu Data.emailManagement model
        , el Util.divider Element.none
        , emailMenu Data.labelledEmails model
        ]


emailMenu : List EmailLabel -> Preview.Model -> Element Msg
emailMenu emailLabels model =
    column [ width fill, Util.padding, Element.spacing Size.spacing1 ] <| emailLabelBtns emailLabels model.viewEmailLabel


emailLabelBtns : List EmailLabel -> EmailLabel -> List (Element Msg)
emailLabelBtns emailLabels viewEmailLabel =
    emailLabels
        |> List.map
            (\emailLabel ->
                Button.button [ width fill, Font.size Size.spacing3 ]
                    { buttonType = Just <| ifElse Button.Primary Button.Ghost (isEmailLabelEqual emailLabel viewEmailLabel)
                    , icon = Just <| (emailLabel |> emailLabelIcon |> Element.html |> Util.renderIcon)
                    , onTap = Just <| OnTapEmailLabel emailLabel
                    , label = Just <| emailLabelBtnLabel emailLabel
                    , loading = Nothing
                    }
            )


emailLabelBtnLabel : EmailLabel -> Element msg
emailLabelBtnLabel emailLabel =
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
    case emailLabel of
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


emailLabelIcon : EmailLabel -> Html msg
emailLabelIcon emailLabel =
    case emailLabel of
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


isEmailLabelEqual : EmailLabel -> EmailLabel -> Bool
isEmailLabelEqual a b =
    case ( a, b ) of
        ( Inbox _, Inbox _ ) ->
            True

        ( Drafts _, Drafts _ ) ->
            True

        ( Sent _, Sent _ ) ->
            True

        ( Junk _, Junk _ ) ->
            True

        ( Trash _, Trash _ ) ->
            True

        ( Archive _, Archive _ ) ->
            True

        ( Social _, Social _ ) ->
            True

        ( Updates _, Updates _ ) ->
            True

        ( Forums _, Forums _ ) ->
            True

        ( Shopping _, Shopping _ ) ->
            True

        ( Promotions _, Promotions _ ) ->
            True

        _ ->
            False



-- Account


selectAccount : Preview.Model -> Element Msg
selectAccount model =
    el [ width fill, Util.padding, height (px Size.spacing14) ]
        (Select.el Util.shadow selectAccountConfig model.account)


selectAccountConfig : Select.CustomConfig EmailAddress Preview.Msg
selectAccountConfig =
    let
        label : Element msg
        label =
            row [ centerY, spaceEvenly ]
                [ row [ spacing ]
                    [ Util.renderIcon Icon.user
                    , el [] (text <| Data.user)
                    ]
                , el [] (Util.renderIcon Icon.upDown)
                ]

        item : EmailAddress -> Element msg
        item email =
            row [ spacing, centerY, Font.size Size.spacing3 ]
                [ Util.renderIcon <| Data.iconForAccount email
                , el [] (text email)
                ]

        itemAsSelected : EmailAddress -> Element msg
        itemAsSelected email =
            row [ spacing ]
                [ item email
                , Util.renderIcon Icon.check
                ]

        itemAsLabel : String -> Element msg
        itemAsLabel email =
            row [ centerY, spaceEvenly, width fill ]
                [ row [ spacing ]
                    [ Util.renderIcon <| Data.iconForAccount email
                    , el [] (text Data.user)
                    ]
                , Util.renderIcon <| Icon.upDown
                ]

        spacing : Element.Attribute msg
        spacing =
            Element.spacing Size.spacing3
    in
    { label = label
    , options = Data.accounts
    , item = item
    , itemAsSelected = itemAsSelected
    , itemAsLabel = itemAsLabel
    , embedMsg = SelectAccount
    }
