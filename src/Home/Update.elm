module Home.Update exposing (update)

import Home.Model as Home
import Home.Msg as Home exposing (Msg(..))
import UI.Drawer as Drawer
import UI.Select as Select
import UI.Tab as Tab


update : Home.Msg -> Home.Model -> ( Home.Model, Cmd Home.Msg )
update msg model =
    case msg of
        ToggleDrawer ->
            ( { model | drawer = Drawer.toggle model.drawer }, Cmd.none )

        SelectFruit selectMsg ->
            ( { model | selectFruitState = Select.update selectMsg model.selectFruitState }, Cmd.none )

        TappedBody ->
            ( { model | selectFruitState = Select.hide model.selectFruitState }, Cmd.none )

        UserSettingsTabSelected tabMsg ->
            ( { model | userSettingsTab = Tab.update tabMsg model.userSettingsTab }, Cmd.none )
