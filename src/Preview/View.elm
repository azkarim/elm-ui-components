module Preview.View exposing (document)

import Browser exposing (Document)
import Element exposing (Element, centerX, centerY, fill, height, px, row, text, width)
import Element.Background as Background
import Element.Border as Border
import Preview.Model as Preview
import Preview.Msg as Preview
import UI.Preset.Color as Color
import UI.Theme exposing (theme)
import UI.Util as Util


view : Preview.Model -> Element Preview.Msg
view model =
    row
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
        []


document : Preview.Model -> Document Preview.Msg
document model =
    { title = "Preview"
    , body = [ view model |> Element.layout [ Element.width Element.fill, Element.height Element.fill ] ]
    }