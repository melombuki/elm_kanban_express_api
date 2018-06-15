module App.Messages exposing (..)

import App.Model exposing (Page)
import Pages.Dashboard.Messages exposing (..)
import Pages.Task.Messages exposing (..)
import Pages.CreateTask.Messages exposing (..)
import Pages.EditTask.Messages exposing (..)


type Msg
    = SetActivePage Page
    | DashboardPageUpdates Pages.Dashboard.Messages.Msg
    | TaskPageUpdates Pages.Task.Messages.Msg
    | CreateTaskPageUpdates Pages.CreateTask.Messages.Msg
    | EditTaskPageUpdates Pages.EditTask.Messages.Msg
