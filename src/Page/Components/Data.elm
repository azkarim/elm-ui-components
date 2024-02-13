module Page.Components.Data exposing (Option(..), UserSettingsTab(..), accordionItems, optionStr, tabStr)

import UI.Accordion exposing (Accordion)


accordionItems : List Accordion
accordionItems =
    [ { item = "What does it mean for a function to be pure in functional programming?"
      , content = "A pure function has two key properties. First, its output depends solely on its input arguments; it doesn't access or modify any external state. Second, it doesn't produce any side effects, such as changing a global variable, printing to the console, or making a network call. This purity makes functions predictable, reusable, and easier to test, as you can trust they will always behave the same way given the same input."
      }
    , { item = "What is immutability in functional programming?"
      , content = "Immutability is a core principle in functional programming that prohibits the modification of data after it has been created. Instead of changing existing data, operations in a functional program create and work with copies of data with the desired changes applied. This approach simplifies reasoning about the program's state and avoids unintended side effects from shared mutable state."
      }
    , { item = "What are higher-order functions?"
      , content = "Higher-order functions are functions that can take other functions as arguments and/or return functions as their result. This capability is crucial for creating abstract and reusable code patterns in functional programming. For example, functions like map, filter, and reduce are higher-order functions because they take a function as an argument to apply to each element in a collection."
      }
    , { item = "How does recursion work in functional programming?"
      , content = "Recursion in functional programming refers to the technique of a function calling itself to solve a problem. Instead of using iterative loops, functional programs often rely on recursion to process data structures like lists or trees. Recursion is a powerful tool for breaking down complex problems into simpler sub-problems, but it requires careful design to avoid infinite loops and ensure efficiency."
      }
    ]


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
