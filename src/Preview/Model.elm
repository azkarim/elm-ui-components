module Preview.Model exposing (Email, EmailSection(..), Model, Unread, accounts, dataEmailSections, iconsForAccount, init, isEmailSectionEqual, user)

import Element exposing (Element)
import UI.Preset.Icon as Icon
import UI.Select as Select


type alias Model =
    { account : Select.State Email
    , currentEmailSection : EmailSection
    }


init : Model
init =
    { account = Select.init (Just "alonzo@lambda.com"), currentEmailSection = Inbox (Just 98) }



-- Menu : Email Section


type EmailSection
    = Inbox (Maybe Unread)
    | Drafts (Maybe Unread)
    | Sent (Maybe Unread)
    | Junk (Maybe Unread)
    | Trash (Maybe Unread)
    | Archive (Maybe Unread)
    | Social (Maybe Unread)
    | Updates (Maybe Unread)
    | Forums (Maybe Unread)
    | Shopping (Maybe Unread)
    | Promotions (Maybe Unread)


type alias Unread =
    Int


isEmailSectionEqual : EmailSection -> EmailSection -> Bool
isEmailSectionEqual a b =
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


dataEmailSections : List EmailSection
dataEmailSections =
    [ Inbox <| Just 98
    , Drafts Nothing
    , Sent <| Just 12
    , Junk <| Just 1020
    , Trash Nothing
    , Archive <| Just 586
    , Social <| Just 1030
    , Updates <| Just 23
    , Forums <| Just 109
    , Shopping <| Just 98
    , Promotions <| Just 5001
    ]



-- Accounts


accounts : List Email
accounts =
    [ "alonzo@gmail.com", "alonzo@me.com", "alonzo@lambda.com" ]


iconsForAccount : String -> Element msg
iconsForAccount email =
    case email of
        "alonzo@gmail.com" ->
            Icon.cloud

        "alonzo@me.com" ->
            Icon.desktop

        "alonzo@lambda.com" ->
            Icon.buildingLibrary

        _ ->
            Icon.user


user : String
user =
    "Alonzo Church"


type alias Email =
    String
