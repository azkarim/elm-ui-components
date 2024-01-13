module UI.Preset.Color exposing (..)

import Element


preset : { primary : Element.Color, secondary : Element.Color }
preset =
    { primary = slate900
    , secondary = zinc200
    }


slate50 : Element.Color
slate50 =
    -- #f8fafc
    Element.rgb255 248 250 252


slate100 : Element.Color
slate100 =
    -- #f1f5f9
    Element.rgb255 241 245 249


slate200 : Element.Color
slate200 =
    -- #e2e8f0
    Element.rgb255 226 232 240


slate300 : Element.Color
slate300 =
    -- #cbd5e1
    Element.rgb255 203 213 225


slate400 : Element.Color
slate400 =
    -- #94a3b8
    Element.rgb255 148 163 184


slate700 : Element.Color
slate700 =
    -- #334155
    Element.rgb255 51 65 85


slate900 : Element.Color
slate900 =
    -- #0f172a
    Element.rgb255 15 23 42


zinc100 : Element.Color
zinc100 =
    -- #f4f4f5
    Element.rgb255 244 244 245


zinc200 : Element.Color
zinc200 =
    -- #e4e4e7
    Element.rgb255 228 228 231


neutral : Element.Color
neutral =
    --#ffffff
    Element.rgb255 255 255 255


neutral50 : Element.Color
neutral50 =
    --#fafafa
    Element.rgb255 250 250 250


loading : Element.Color
loading =
    -- #848891
    Element.rgb255 132 136 145


shadow : Element.Color
shadow =
    --#000000
    Element.rgba255 0 0 0 0.1


setAlpha : Float -> Element.Color -> Element.Color
setAlpha alpha color =
    Element.toRgb color
        |> (\c ->
                { c | alpha = alpha }
                    |> Element.fromRgb
           )
