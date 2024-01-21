module Preview.Update exposing (update)

import Preview.Model as Preview
import Preview.Msg as Preview exposing (Msg(..))


update : Preview.Msg -> Preview.Model -> ( Preview.Model, Cmd Preview.Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
