module UI.Select exposing (select)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import UI.Preset.Color as Color
import UI.Preset.Icons as Icons
import UI.Preset.Size as Size
import UI.Preset.Util as Util
import Util exposing (ifElse)


type alias Selected =
    Bool


select : Element msg
select =
    Element.row
        [ Element.width (Element.fill |> Element.minimum size.minWidth)
        , Element.height (Element.px size.height)
        , Element.spaceEvenly
        , Element.paddingXY Size.padding_3 Size.padding_2
        , Border.width 1
        , Border.rounded Size.border_md
        , Border.color Color.zinc200
        , Font.size Size.text_sm
        , Font.letterSpacing 0.4
        , Font.family [ Font.sansSerif ]
        , Font.medium
        , Util.style "user-select" "none"
        , Element.pointer
        , Element.below optionsPanel
        ]
        [ Element.el [ Element.centerY ] (Element.text "Select a fruit")
        , Icons.renderIcon Icons.downArrow
        ]


optionsPanel : Element msg
optionsPanel =
    Element.column
        (Element.moveDown Size.spacing
            :: Element.width Element.fill
            :: Element.paddingXY Size.padding_2 Size.padding_2
            :: Border.width 1
            :: Border.rounded Size.border_md
            :: Border.color Color.zinc200
            :: Util.shadow
        )
    <|
        List.map renderItem loremOptions


renderItem : ( String, Selected ) -> Element msg
renderItem ( option, selected ) =
    Element.row
        [ Element.width Element.fill
        , Element.paddingXY Size.padding_2 Size.padding_3
        , Border.rounded Size.border_md
        , Element.pointer
        , Element.mouseOver [ Background.color Color.slate50 ]
        ]
        [ Element.el [ Element.width (Element.px Size.spacing6), Element.centerY ] <| ifElse (Element.el [ Element.centerX ] (Icons.renderIcon Icons.check)) Element.none selected
        , Element.el [ Element.centerY, Element.alignLeft ] (Element.text option)
        ]


size : { height : Int, minWidth : Int }
size =
    { height = Size.spacing10
    , minWidth = Size.spacing45
    }


loremOptions : List ( String, Selected )
loremOptions =
    [ ( "Apple", False )
    , ( "Banana", False )
    , ( "Blueberry", True )
    , ( "Grapes", False )
    , ( "Pineapple", False )
    ]
