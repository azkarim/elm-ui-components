module Components.Data exposing (Option(..), UserSettingsTab(..), optionStr, tabStr)


type UserSettingsTab
    = Account
    | Password


tabStr : UserSettingsTab -> String
tabStr tab =
    case tab of
        Account ->
            "Account"

        Password ->
            "Password"


type Option
    = Apple
    | Banana
    | Blueberry
    | Grapes
    | Pineapple


optionStr : Option -> String
optionStr option =
    case option of
        Apple ->
            "Apple"

        Banana ->
            "Banana"

        Blueberry ->
            "Blueberry"

        Grapes ->
            "Grapes"

        Pineapple ->
            "Pineapple"
