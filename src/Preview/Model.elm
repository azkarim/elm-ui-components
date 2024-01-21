module Preview.Model exposing (Email, Model, accounts, iconsForAccount, init, user)

import Element exposing (Element)
import UI.Preset.Icon as Icon
import UI.Select as Select


type alias Model =
    { account : Select.State Email }


init : Model
init =
    { account = Select.init (Just "alonzo@lambda.com") }


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
