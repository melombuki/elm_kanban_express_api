module Main exposing (..)

import App.Model exposing (Model)
import App.Router exposing (..)
import App.Update exposing (init, update)
import App.Messages exposing (..)
import App.View exposing (view)
import RouteUrl


main : RouteUrl.RouteUrlProgram Never Model Msg
main =
    RouteUrl.program
        { delta2url = delta2url
        , location2messages = location2messages
        , init = App.Update.init
        , update = App.Update.update
        , view = App.View.view
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
