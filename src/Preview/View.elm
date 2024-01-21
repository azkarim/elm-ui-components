module Preview.View exposing (document)

import Browser exposing (Document)
import Element exposing (Element, fill, height, row, text, width)
import Element.Background as Background
import Preview.Model as Preview
import Preview.Msg as Preview
import UI.Preset.Color as Color


view : Preview.Model -> Element Preview.Msg
view model =
    row
        [ width fill
        , height fill
        , Background.color Color.neutral
        ]
    <|
        [ text "Hello Preview" ]


document : Preview.Model -> Document Preview.Msg
document model =
    { title = "Preview"
    , body = [ view model |> Element.layout [ Element.width Element.fill, Element.height Element.fill ] ]
    }
