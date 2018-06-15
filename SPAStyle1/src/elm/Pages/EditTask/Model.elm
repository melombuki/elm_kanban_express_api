module Pages.EditTask.Model exposing (..)

import Resources.Tasks.Model exposing (Task, emptyModel)


type alias Model =
    Task


emptyModel : Model
emptyModel =
    Resources.Tasks.Model.emptyModel



-- TODO use this to store the initial model when
-- the page loads for the first time


previousModel : Model
previousModel =
    emptyModel
