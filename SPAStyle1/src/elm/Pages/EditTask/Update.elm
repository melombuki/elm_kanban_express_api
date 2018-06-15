module Pages.EditTask.Update exposing (..)

import App.Model exposing (Page)
import App.Commands exposing (goto)
import Pages.EditTask.Commands exposing (..)
import Pages.EditTask.Messages exposing (..)
import Resources.Tasks.Model exposing (..)


update : Msg -> Resources.Tasks.Model.Task -> ( Resources.Tasks.Model.Task, Cmd Msg )
update msg model =
    case msg of
        NewName name ->
            { model | name = name } ! []

        NewStatus state ->
            { model | status = state } ! []

        NewDescription description ->
            { model | description = description } ! []

        PostTask task ->
            let
                nextCmd =
                    postTask task OnPostTask
            in
                ( task, nextCmd )

        OnPostTask result ->
            let
                emptyTask =
                    Resources.Tasks.Model.emptyModel
            in
                case result of
                    Ok task ->
                        ( emptyTask, setActivePage msg )

                    Err error ->
                        ( emptyTask, setActivePage msg )

        OnFetchTask (Ok newTask) ->
            newTask ! []

        OnFetchTask (Err error) ->
            Resources.Tasks.Model.emptyModel ! []

        SetActivePage page ->
            model ! []
