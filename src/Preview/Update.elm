module Preview.Update exposing (update)

import Preview.Model as Preview
import Preview.Msg as Preview exposing (Msg(..))
import UI.Select as Select


update : Preview.Msg -> Preview.Model -> ( Preview.Model, Cmd Preview.Msg )
update msg model =
    case msg of
        SelectAccount selectMsg ->
            ( { model | account = Select.update selectMsg model.account }, Cmd.none )

        OnTapEmailSection emailSection ->
            ( { model | currentEmailSection = emailSection }, Cmd.none )
