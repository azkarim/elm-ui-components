module UI.Drawer exposing (Config, layout, toggle)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Html
import Html.Attributes
import Maybe.Extra as Maybe
import Simple.Animation as Animation exposing (Animation)
import Simple.Animation.Property as P
import UI.Preset.Size as Size
import Util exposing (ifElse)


type alias Config msg =
    { isDrawerVisible : Maybe Bool
    , drawerHeight : Int
    , onTap : msg
    }


toggle : Config msg -> Config msg
toggle config =
    let
        update : Maybe Bool
        update =
            case config.isDrawerVisible of
                Nothing ->
                    Just True

                Just True ->
                    Just False

                Just False ->
                    Just True
    in
    { config | isDrawerVisible = update }


layout : Config msg -> Element msg -> Element msg -> Html.Html msg
layout { isDrawerVisible, onTap, drawerHeight } drawer content =
    Element.layout
        [ Element.htmlAttribute <| Html.Attributes.style "width" "100vw"
        , Element.height Element.fill
        , Element.clipX
        , Background.color (Element.rgb255 0 0 0)
        , Maybe.unwrap Util.noAttr (ifElse Element.clipY Element.scrollbarY) isDrawerVisible
        , Maybe.unwrap Util.noAttr (renderDrawer { drawer = drawer, height = drawerHeight }) isDrawerVisible
        ]
    <|
        Element.el
            (Element.width Element.fill
                :: Element.height Element.fill
                :: Maybe.unwrap Element.clipX (ifElse Element.clip Element.clipX) isDrawerVisible
                :: Maybe.unwrap Util.noAttr (ifElse (Border.rounded Size.border_lg) (Border.rounded 0)) isDrawerVisible
                :: Maybe.unwrap Util.noAttr (ifElse (Element.inFront <| recedeOverlay onTap) Util.noAttr) isDrawerVisible
                :: transitions
                ++ Maybe.unwrap [] (ifElse recede []) isDrawerVisible
            )
            content


renderDrawer : { drawer : Element msg, height : Int } -> Bool -> Element.Attribute msg
renderDrawer { drawer, height } isVisible =
    let
        slideInOut : Animation
        slideInOut =
            Animation.fromTo
                { duration = 500
                , options = Animation.cubic 0.32 0.72 0 1 :: ifElse [] [ Animation.reverse ] isVisible
                }
                [ P.y (toFloat height) ]
                [ P.y 0 ]
    in
    Element.inFront <|
        Util.animatedEl Element.el
            slideInOut
            [ Element.width Element.fill
            , Element.alignBottom
            ]
            drawer


recedeOverlay : msg -> Element msg
recedeOverlay onTap =
    Element.row
        [ Element.width Element.fill
        , Element.height Element.fill
        , Background.color (Element.rgba255 0 0 0 0.6)
        , Events.onClick onTap
        ]
        []


transitions : List (Element.Attribute msg)
transitions =
    -- todo : refactor to animation library
    [ Html.Attributes.style "transform-origin" "center top 0px"
    , Html.Attributes.style "transition-property" "transform"
    , Html.Attributes.style "transition-duration" "0.5s"
    , Html.Attributes.style "transition-timing-function" "cubic-bezier(0.32, 0.72, 0, 1)"
    ]
        |> Util.fromAtrrs


recede : List (Element.Attribute msg)
recede =
    -- todo : refactor to animation library
    [ Html.Attributes.style "transform" "scale(0.9864583333333333) translateY(calc(env(safe-area-inset-top) + 14px))"
    ]
        |> Util.fromAtrrs
