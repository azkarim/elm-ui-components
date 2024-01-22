module Preview.Model exposing (Email, EmailLabel(..), FilterEmail(..), Model, Unread, init)

import UI.Select as Select
import UI.Tab as Tab


type alias Model =
    { account : Select.State Email
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


type alias Email =
    String
