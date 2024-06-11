module Page.Components.Update exposing (update)

import Page.Components.Model as Components
import Page.Components.Msg as Components exposing (Msg(..))
import UI.Accordion as Accordion
import UI.Drawer as Drawer
import UI.Select as Select
import UI.Tab as Tab


update : Components.Msg -> Components.Model -> ( Components.Model, Cmd Components.Msg )
update msg model =
    case msg of
        ToggleDrawer ->
            ( { model | drawer = Drawer.toggle model.drawer }, Cmd.none )

        SelectFruit selectModel ->
            ( { model | selectFruitState = selectModel }, Cmd.none )

        OnTapBody ->
            ( { model | selectFruitState = Select.hide model.selectFruitState }, Cmd.none )

        OnTapAccordion accordionMsg ->
            ( { model | accordion = Accordion.update accordionMsg model.accordion }, Cmd.none )

        UserSettingsTabSelected tabMsg ->
            ( { model | userSettingsTab = Tab.update tabMsg model.userSettingsTab }, Cmd.none )
