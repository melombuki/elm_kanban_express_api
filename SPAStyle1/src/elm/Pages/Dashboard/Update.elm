module Pages.Dashboard.Update exposing (..)

import Pages.Dashboard.Messages exposing (..)
import Pages.Dashboard.Commands exposing (..)
import Pages.Dashboard.Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchAll (Ok newTasks) ->
            newTasks ! []

        OnFetchAll (Err error) ->
            model ! []


init : ( Model, Cmd Msg )
init =
    ( emptyModel, Pages.Dashboard.Commands.fetchAll )
