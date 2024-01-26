module Preview.Model exposing (Email, EmailAddress, EmailId, EmailLabel(..), EmailTag(..), FilterEmail(..), Label, Model, TooltipId, Unread)

import Dict exposing (Dict)
import UI.Select as Select
import UI.Tab as Tab


type alias Model =
    { account : Select.State EmailAddress
    , viewEmailLabel : EmailLabel
    , viewEmail : EmailId
    , filterEmails : Tab.State FilterEmail
    , tooltips : Dict TooltipId Bool
    }


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
    { id : EmailId
    , from : String
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


type alias EmailId =
    Int


type alias TooltipId =
    String


type alias Label =
    String
