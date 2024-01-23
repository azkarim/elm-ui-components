module Preview.ViewEmail exposing (view)

import Element exposing (Element, alignTop, centerX, column, el, fill, height, paddingXY, paragraph, px, row, text, width)
import Element.Font as Font
import Heroicons.Outline as Heroicons
import Html exposing (Html)
import List.Extra as List
import Maybe.Extra as Maybe
import Preview.Data as Data
import Preview.Model as Preview exposing (Email)
import Preview.Util as Util
import UI.Avatar as Avatar
import UI.Button as Button
import UI.Preset.Size as Size
import UI.Util as Util


view : Preview.Model -> Element msg
view model =
    let
        emailSelected : Maybe Email
        emailSelected =
            List.getAt model.viewEmail Data.emails
    in
    column
        [ width fill
        , alignTop
        ]
        [ header
        , el (Element.moveDown Size.spacing1 :: Util.divider) Element.none
        , Maybe.unwrap Element.none emailHeader emailSelected
        , el (Element.moveDown Size.spacing1 :: Util.divider) Element.none
        , Maybe.unwrap Element.none emailBody emailSelected
        ]


emailBody : Email -> Element msg
emailBody email_ =
    el [ padding_lg ]
        (paragraph [ Font.medium, Font.size Size.spacing3_5, Element.spacing Size.spacing3 ] [ text email_.body ])


emailHeader : Email -> Element msg
emailHeader email_ =
    row [ width fill, Element.spacing Size.spacing4, padding_lg ]
        [ el [ alignTop ] (avatar email_)
        , column [ width fill, Element.spacing Size.spacing1, Font.medium, Font.size Size.spacing3 ]
            [ paragraph [ Font.semiBold ] [ text <| email_.from ]
            , paragraph [] [ text <| email_.subject ]
            ]
        ]


avatar : Email -> Element msg
avatar email_ =
    let
        initials : String
        initials =
            String.words email_.from
                |> List.map (String.slice 0 1)
                |> List.take 2
                |> String.concat
    in
    Avatar.avatar [] (text <| initials)


header : Element msg
header =
    row
        [ width fill
        , height (px Size.spacing13)
        , Util.padding
        ]
        [ row [ Element.alignRight, Element.spacing Size.spacing1 ] <| List.map menuBtn (emailOpsBtnSet0 ++ emailOpsBtnSet1)
        ]


emailOpsBtnSet0 : List (Html msg)
emailOpsBtnSet0 =
    [ Heroicons.archiveBoxArrowDown []
    , Heroicons.archiveBoxXMark []
    , Heroicons.trash []
    ]


emailOpsBtnSet1 : List (Html msg)
emailOpsBtnSet1 =
    [ Heroicons.bellSnooze []
    , Heroicons.flag []
    , Heroicons.arrowDownOnSquare []
    ]


menuBtn : Html msg -> Element msg
menuBtn icon_ =
    Button.new
        |> Button.icon (renderIcon <| icon_)
        |> Button.buttonType Button.Ghost
        |> Button.button []


renderIcon : Html msg -> Element msg
renderIcon icon =
    icon
        |> Element.html
        |> Element.el [ Element.width (Element.px iconSize), Element.height (Element.px iconSize) ]


iconSize : Int
iconSize =
    Size.spacing5


padding_lg : Element.Attribute msg
padding_lg =
    paddingXY Size.spacing4 Size.spacing6
