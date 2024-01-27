module Preview.ViewEmail exposing (view)

import Dict
import Element exposing (Element, alignTop, column, el, fill, height, paddingXY, paragraph, px, row, text, width)
import Element.Font as Font
import Html exposing (Html)
import List.Extra as List
import Maybe.Extra as Maybe
import Preview.Data as Data
import Preview.Model as Preview exposing (Email, Label, TooltipId)
import Preview.Msg exposing (Msg(..))
import Preview.Util as Util
import UI.Avatar as Avatar
import UI.Button as Button
import UI.Preset.Size as Size
import UI.Tooltip as Tooltip
import UI.Util as Util


view : Preview.Model -> Element Msg
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
        [ header model
        , el (Element.moveDown Size.spacing_1 :: Util.divider) Element.none
        , Maybe.unwrap Element.none emailHeader emailSelected
        , el (Element.moveDown Size.spacing_1 :: Util.divider) Element.none
        , Maybe.unwrap Element.none emailBody emailSelected
        ]


emailBody : Email -> Element msg
emailBody email_ =
    el [ padding_lg ]
        (paragraph [ Font.medium, Font.size Size.spacing_3_5, Element.spacing Size.spacing_3 ] [ text email_.body ])


emailHeader : Email -> Element msg
emailHeader email_ =
    row [ width fill, Element.spacing Size.spacing_4, padding_lg ]
        [ el [ alignTop ] (avatar email_)
        , column [ width fill, Element.spacing Size.spacing_1, Font.medium, Font.size Size.spacing_3 ]
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


header : Preview.Model -> Element Msg
header model =
    row
        [ width fill
        , height (px Size.spacing_13)
        , Util.padding
        ]
        [ row [ Element.alignRight, Element.spacing Size.spacing_1 ] <| List.map (menuBtn model) (Data.emailOpsBtnSet0 ++ Data.emailOpsBtnSet1)
        ]


menuBtn : Preview.Model -> ( TooltipId, Label, Html Msg ) -> Element Msg
menuBtn model ( tooltipId, tooltipLabel, icon_ ) =
    Button.new
        |> Button.icon (renderIcon <| icon_)
        |> Button.buttonType Button.Ghost
        |> Button.button
            ((Element.below <| renderTooltip ( tooltipId, tooltipLabel ) model)
                :: Tooltip.events tooltipId OnTooltipMsg
            )


renderTooltip : ( TooltipId, Label ) -> Preview.Model -> Element Msg
renderTooltip ( id, label ) model =
    Tooltip.tooltip []
        { id = id
        , elem = Element.el [] (Element.text label)
        , embedMsg = OnTooltipMsg
        , isTooltipOpen = Dict.get id model.tooltips |> Maybe.withDefault False
        }


renderIcon : Html msg -> Element msg
renderIcon icon =
    icon
        |> Element.html
        |> Element.el [ Element.width (Element.px iconSize), Element.height (Element.px iconSize) ]


iconSize : Int
iconSize =
    Size.spacing_5


padding_lg : Element.Attribute msg
padding_lg =
    paddingXY Size.spacing_4 Size.spacing_6
