module Home.Data exposing (Option(..), optionStr)


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
