module Page.Preview.Init exposing (init)

import Dict exposing (Dict)
import Page.Preview.Data as Data
import Page.Preview.Model as Preview exposing (EmailLabel(..), FilterEmail(..), TooltipId)
import UI.Select as Select
import UI.Tab as Tab


init : Preview.Model
init =
    { account = Select.init (Just "alonzo@lambda.com"), viewEmailLabel = Inbox (Just 98), filterEmails = Tab.init AllMail, viewEmail = 0, tooltips = initTooltips }


initTooltips : Dict TooltipId Bool
initTooltips =
    (Data.emailOpsBtnSet0 ++ Data.emailOpsBtnSet1)
        |> List.foldl (\( tooltipId, _, _ ) dict -> Dict.insert tooltipId False dict) Dict.empty
