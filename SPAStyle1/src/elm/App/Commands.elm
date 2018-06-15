module App.Commands exposing (goto)

import App.Model exposing (Page)
import App.Messages exposing (..)
import Task exposing (..)


goto : msg -> Cmd Msg
goto msg =
    Task.succeed msg
        |> Task.perform (\_ -> App.Messages.SetActivePage App.Model.Dashboard)
