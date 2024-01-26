module Preview.Update exposing (update)

import Dict exposing (Dict)
import Preview.Model as Preview exposing (TooltipId)
import Preview.Msg as Preview exposing (Msg(..))
import UI.Select as Select
import UI.Tab as Tab
import UI.Tooltip as Tooltip


update : Preview.Msg -> Preview.Model -> ( Preview.Model, Cmd Preview.Msg )
update msg model =
    case msg of
        SelectAccount selectMsg ->
            ( { model | account = Select.update selectMsg model.account }, Cmd.none )

        FilterTab tabMsg ->
            ( { model | filterEmails = Tab.update tabMsg model.filterEmails }, Cmd.none )

        OnTapViewEmail emailId ->
            ( { model | viewEmail = emailId }, Cmd.none )

        OnTapEmailLabel emailLabel ->
            ( { model | viewEmailLabel = emailLabel }, Cmd.none )

        OnTapBody ->
            ( { model | account = Select.hide model.account }, Cmd.none )

        OnTooltipMsg tooltipMsg ->
            ( updateTooltipState tooltipMsg model, Cmd.none )


updateTooltipState : Tooltip.Msg TooltipId -> Preview.Model -> Preview.Model
updateTooltipState msg model =
    case msg of
        Tooltip.OnMouseEnter id ->
            { model | tooltips = showTooltip id model.tooltips }

        Tooltip.OnMouseLeave id ->
            { model | tooltips = hideTooltip id model.tooltips }


showTooltip : TooltipId -> Dict TooltipId Bool -> Dict TooltipId Bool
showTooltip id =
    Dict.update id (Maybe.map (\_ -> True))


hideTooltip : TooltipId -> Dict TooltipId Bool -> Dict TooltipId Bool
hideTooltip id =
    Dict.update id (Maybe.map (\_ -> False))
