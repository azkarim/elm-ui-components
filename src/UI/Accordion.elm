module UI.Accordion exposing (Accordion, Config, Msg, State, accordion, init, update)

import Element exposing (Element, paddingXY)
import Element.Font as Font
import Maybe.Extra as Maybe
import UI.Preset.Size as Size
import UI.Theme exposing (theme)
import UI.Util as Util
import Util exposing (ifElse)


type alias Accordion =
    { item : String
    , content : String
    }


type alias Config embedMsg =
    { items : List Accordion
    , visible : Maybe Int
    , embedMsg : Msg -> embedMsg
    }


type alias State =
    Maybe Int


type Msg
    = OnTap Int


update : Msg -> State -> State
update msg state =
    case msg of
        OnTap idx ->
            Maybe.unwrap (Just idx) (\visibleIdx -> ifElse Nothing (Just idx) (visibleIdx == idx)) state


init : Maybe Int
init =
    Nothing


accordion : List (Element.Attribute embedMsg) -> Config embedMsg -> Element embedMsg
accordion attrs config =
    List.indexedMap (\idx acrdn -> renderItem { itemIdx = idx, visible = config.visible, embedMsg = config.embedMsg } acrdn) config.items
        |> List.intersperse divider
        |> (\items -> items ++ [ divider ])
        |> Element.column attrs


renderItem : { itemIdx : Int, visible : Maybe Int, embedMsg : Msg -> embedMsg } -> Accordion -> Element embedMsg
renderItem config acrdn =
    let
        isVisible : Bool
        isVisible =
            Maybe.unwrap False ((==) config.itemIdx) config.visible
    in
    Element.column
        [ Element.spacing Size.text_sm
        , Font.size theme.size.font
        , paddingXY 0 Size.spacing_4
        ]
        [ Element.paragraph
            [ Element.pointer
            , Font.medium
            , Util.onClick (OnTap config.itemIdx |> config.embedMsg)
            , Util.class "hover-underline"
            ]
            [ Element.text acrdn.item ]
        , ifElse (renderContent acrdn.content) Element.none isVisible
        ]


renderContent : String -> Element msg
renderContent content =
    Element.paragraph
        [ Font.hairline
        , Font.letterSpacing 1
        ]
        [ Element.text content ]


divider : Element msg
divider =
    Element.el Util.divider Element.none
