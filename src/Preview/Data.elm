module Preview.Data exposing (accounts, emailManagement, iconForAccount, labelledEmails, user)

import Element exposing (Element)
import Preview.Model exposing (Email, EmailLabel(..))
import UI.Preset.Icon as Icon


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


accounts : List Email
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
