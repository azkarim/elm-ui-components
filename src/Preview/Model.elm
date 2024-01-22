module Preview.Model exposing (Email, EmailAddress, EmailLabel(..), EmailTag(..), FilterEmail(..), Model, Unread, init)

import UI.Select as Select
import UI.Tab as Tab


type alias Model =
    { account : Select.State EmailAddress
    , viewEmailLabel : EmailLabel
    , filterEmails : Tab.State FilterEmail
    }


init : Model
init =
    { account = Select.init (Just "alonzo@lambda.com"), viewEmailLabel = Inbox (Just 98), filterEmails = Tab.init AllMail }


type FilterEmail
    = AllMail
    | Unread


type EmailLabel
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


type alias EmailAddress =
    String


type alias Email =
    { from : String
    , subject : String
    , body : String
    , tags : List EmailTag
    , read : Bool
    }


type EmailTag
    = Meeting
    | Work
    | Important
    | Budget
