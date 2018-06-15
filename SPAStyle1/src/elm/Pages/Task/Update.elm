module Pages.Task.Update exposing (..)

import Pages.Task.Messages exposing (..)
import Pages.Task.Commands exposing (..)
import Pages.Task.Model exposing (..)


update : Msg -> Maybe Model -> ( Maybe Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchTask (Ok newTasks) ->
            Just newTasks ! []

        OnFetchTask (Err error) ->
            Nothing ! []
