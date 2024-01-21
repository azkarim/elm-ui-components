module Components.Update exposing (update)

import Components.Model as Components
import Components.Msg as Components exposing (Msg(..))
import UI.Drawer as Drawer
import UI.Select as Select
import UI.Tab as Tab


update : Components.Msg -> Components.Model -> ( Components.Model, Cmd Components.Msg )
update msg model =
    case msg of
        ToggleDrawer ->
            ( { model | drawer = Drawer.toggle model.drawer }, Cmd.none )

        SelectFruit selectMsg ->
            ( { model | selectFruitState = Select.update selectMsg model.selectFruitState }, Cmd.none )

        OnTapBody ->
            ( { model | selectFruitState = Select.hide model.selectFruitState }, Cmd.none )

        UserSettingsTabSelected tabMsg ->
            ( { model | userSettingsTab = Tab.update tabMsg model.userSettingsTab }, Cmd.none )
