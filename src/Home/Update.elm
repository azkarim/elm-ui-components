module Home.Update exposing (update)

import Home.Drawer as Drawer
import Home.Model as Home
import Home.Msg as Home exposing (Msg(..))


update : Home.Msg -> Home.Model -> ( Home.Model, Cmd Home.Msg )
update msg model =
    case msg of
        ToggleDrawer ->
            ( { model | drawer = Drawer.toggle model.drawer }, Cmd.none )
