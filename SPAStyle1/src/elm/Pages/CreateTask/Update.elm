module Pages.CreateTask.Update exposing (..)

import Pages.CreateTask.Commands exposing (..)
import Pages.CreateTask.Messages exposing (..)
import Resources.Tasks.Model exposing (..)


update : Msg -> Task -> ( Task, Cmd Msg )
update msg model =
    case msg of
        NewName name ->
            { model | name = name } ! []

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
                    Ok () ->
                        emptyTask ! []

                    Err error ->
                        emptyTask ! []
