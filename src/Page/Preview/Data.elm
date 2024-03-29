module Page.Preview.Data exposing (accounts, emailManagement, emailOpsBtnSet0, emailOpsBtnSet1, emails, iconForAccount, labelledEmails, user)

import Element exposing (Element)
import Heroicons.Outline as Heroicons
import Html exposing (Html)
import Page.Preview.Model exposing (Email, EmailAddress, EmailLabel(..), EmailTag(..), Label, TooltipId)
import UI.Preset.Icon as Icon


emailOpsBtnSet0 : List ( TooltipId, Label, Html msg )
emailOpsBtnSet0 =
    [ ( "archive", "Archive", Heroicons.archiveBoxArrowDown [] )
    , ( "spam", "Spam", Heroicons.archiveBoxXMark [] )
    , ( "trash", "Trash", Heroicons.trash [] )
    ]


emailOpsBtnSet1 : List ( TooltipId, Label, Html msg )
emailOpsBtnSet1 =
    [ ( "snooze", "Snooze", Heroicons.bellSnooze [] )
    , ( "flag", "Flag", Heroicons.flag [] )
    , ( "download", "Download", Heroicons.arrowDownOnSquare [] )
    ]


emailLabels : List EmailLabel
emailLabels =
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


emailManagement : List EmailLabel
emailManagement =
    List.take 6 emailLabels


labelledEmails : List EmailLabel
labelledEmails =
    List.drop 6 emailLabels



-- Accounts


accounts : List EmailAddress
accounts =
    [ "alonzo@gmail.com", "alonzo@me.com", "alonzo@lambda.com" ]


iconForAccount : String -> Element msg
iconForAccount email =
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


emails : List Email
emails =
    [ { id = 0
      , from = "Sarah Connor"
      , subject = "New Project Proposal"
      , body = "Hello Team, I am sending over the new project proposal. Please review it and give your feedback by EOD. Regards, Sarah"
      , tags = [ Work, Important ]
      , read = True
      }
    , { id = 1
      , from = "John Doe"
      , subject = "Budget Approval Needed"
      , body = "Dear Finance, The budget for the upcoming quarter needs approval. Attached is the expenditure report. Please process this as a priority. Best, John"
      , tags = [ Budget, Important ]
      , read = False
      }
    , { id = 2
      , from = "Jane Smith"
      , subject = "Team Building Activity"
      , body = "Hi everyone, We have planned a team building activity this Friday. Hope to see you all there! Cheers, Jane"
      , tags = [ Work ]
      , read = True
      }
    , { id = 3
      , from = "Alan Turing"
      , subject = "Algorithm Discussion"
      , body = "Dear Colleagues, I propose a discussion on the new algorithm we're developing next Thursday. Regards, Alan"
      , tags = [ Meeting, Work ]
      , read = True
      }
    , { id = 4
      , from = "Grace Hopper"
      , subject = "Conference Schedule"
      , body = "Hello, The schedule for the upcoming tech conference is attached. Please confirm your attendance. Regards, Grace"
      , tags = [ Work, Important ]
      , read = True
      }
    , { id = 5
      , from = "Elon Musk"
      , subject = "Innovation Ideas"
      , body = "Team, I'm looking for fresh innovative ideas for our next project. Send me a brief proposal if you have any. - Elon"
      , tags = [ Work, Important ]
      , read = False
      }
    , { id = 6
      , from = "Ada Lovelace"
      , subject = "Programming Workshop"
      , body = "Dear Students, There will be a programming workshop next week. Please enroll if you haven't yet. Regards, Ada"
      , tags = [ Work ]
      , read = True
      }
    , { id = 7
      , from = "Steve Jobs"
      , subject = "Design Meeting"
      , body = "Design Team, We need to discuss the user interface for our new app. Let's meet this Wednesday. - Steve"
      , tags = [ Meeting, Work, Important ]
      , read = False
      }
    , { id = 8
      , from = "Larry Page"
      , subject = "Research and Development Update"
      , body = "R&D Team, Please provide an update on the research and development progress by next Monday. - Larry"
      , tags = [ Work, Important ]
      , read = True
      }
    , { id = 9
      , from = "Marissa Mayer"
      , subject = "Quarterly Review"
      , body = "Management Team, The quarterly review documents are ready for your perusal. Please review them before our meeting. Regards, Marissa"
      , tags = [ Meeting, Budget, Important ]
      , read = True
      }
    ]
