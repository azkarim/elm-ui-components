module Main exposing (main)

import Browser
import Browser.Navigation as Navigation
import Document
import Msg exposing (Msg)
import Route
import State exposing (State)
import Subscriptions
import Update
import Url exposing (Url)


main : Program () State Msg
main =
    Browser.application
        { init = init
        , view = Document.document
        , update = Update.update
        , subscriptions = Subscriptions.subscriptions
        , onUrlRequest = Route.onUrlRequest
        , onUrlChange = Route.onUrlChange
        }


init : flags -> Url -> Navigation.Key -> ( State, Cmd Msg )
init _ url _ =
    ( State.init |> (\m -> { m | route = Route.toRoute url }), Cmd.none )
