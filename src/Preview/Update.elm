module Preview.Update exposing (update)

import Preview.Model as Preview
import Preview.Msg as Preview exposing (Msg(..))
import UI.Select as Select
import UI.Tab as Tab


update : Preview.Msg -> Preview.Model -> ( Preview.Model, Cmd Preview.Msg )
update msg model =
    case msg of
        SelectAccount selectMsg ->
            ( { model | account = Select.update selectMsg model.account }, Cmd.none )

        FilterTab tabMsg ->
            ( { model | filterEmails = Tab.update tabMsg model.filterEmails }, Cmd.none )

        OnTapEmailSection emailSection ->
            ( { model | currentEmailSection = emailSection }, Cmd.none )

        OnTapBody ->
            ( { model | account = Select.hide model.account }, Cmd.none )
