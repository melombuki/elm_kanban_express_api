module App.Model exposing (emptyModel, Model, Page(..))

import Resources.Tasks.Model exposing (..)


type Page
    = AccessDenied
    | Dashboard
    | Task String
    | EditTask String
    | CreateTask
    | PageNotFound


type alias Model =
    { activePage : Page
    , tasks : List Task
    , task : Maybe Task
    , createTask : Task
    , editTask : Task
    }


emptyModel : Model
emptyModel =
    { activePage = Dashboard
    , tasks = []
    , task = Just Resources.Tasks.Model.emptyModel
    , createTask = Resources.Tasks.Model.emptyModel
    , editTask = Resources.Tasks.Model.emptyModel
    }
