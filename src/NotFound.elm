module NotFound exposing (document)

import Browser exposing (Document)
import Element


document : Document msg
document =
    { title = "404 - Not Found"
    , body = [ Element.layout [ Element.width Element.fill, Element.height Element.fill ] (Element.text "Not found") ]
    }
