module Preview.View exposing (document)

import Browser exposing (Document)
import Element exposing (Element, centerX, centerY, column, el, fill, height, paddingXY, px, row, spaceEvenly, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Preview.Model as Preview exposing (Email, accounts, iconsForAccount, user)
import Preview.Msg as Preview exposing (Msg(..))
import UI.Preset.Color as Color
import UI.Preset.Icon as Icon
import UI.Preset.Size as Size
import UI.Select as Select
import UI.Theme exposing (theme)
import UI.Util as Util


view : Preview.Model -> Element Preview.Msg
view model =
    el
        (centerX
            :: centerY
            :: width (fill |> Element.maximum 1340)
            :: height (fill |> Element.maximum 800)
            :: Background.color Color.neutral
            :: Border.rounded theme.size.rounded
            :: Util.addBorder
            ++ Util.shadow_xl
        )
    <|
        el
            [ width (px 230)
            , height fill
            , Border.widthEach { right = theme.size.border, bottom = 0, left = 0, top = 0 }
            , Border.color theme.color.border
            ]
            (column [ width fill ]
                [ el [ paddingXY Size.spacing3 Size.spacing2, width fill ]
                    (selectAccount model)
                , Util.divider
                , row [] []
                ]
            )


selectAccount : Preview.Model -> Element Msg
selectAccount model =
    Select.el Util.shadow selectAccountConfig model.account


selectAccountConfig : Select.CustomConfig Email Preview.Msg
selectAccountConfig =
    let
        label : Element msg
        label =
            row [ centerY, spaceEvenly ]
                [ row [ spacing ]
                    [ Util.renderIcon Icon.user
                    , el [] (text <| user)
                    ]
                , el [] (Util.renderIcon Icon.upDown)
                ]

        item : Email -> Element msg
        item email =
            row [ spacing, centerY, Font.size Size.spacing3 ]
                [ Util.renderIcon <| iconsForAccount email
                , el [] (text email)
                ]

        itemAsSelected : Email -> Element msg
        itemAsSelected email =
            row [ spacing ]
                [ item email
                , Util.renderIcon Icon.check
                ]

        itemAsLabel : String -> Element msg
        itemAsLabel email =
            row [ centerY, spaceEvenly, width fill ]
                [ row [ spacing ]
                    [ Util.renderIcon <| iconsForAccount email
                    , el [] (text user)
                    ]
                , Util.renderIcon <| Icon.upDown
                ]

        spacing : Element.Attribute msg
        spacing =
            Element.spacing Size.spacing3
    in
    { label = label
    , options = accounts
    , item = item
    , itemAsSelected = itemAsSelected
    , itemAsLabel = itemAsLabel
    , embedMsg = SelectAccount
    }


document : Preview.Model -> Document Preview.Msg
document model =
    { title = "Preview"
    , body = [ view model |> Element.layout [ Element.width Element.fill, Element.height Element.fill ] ]
    }
