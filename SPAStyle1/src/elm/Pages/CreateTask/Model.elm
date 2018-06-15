module Pages.CreateTask.Model exposing (..)

import Resources.Tasks.Model exposing (Task, emptyModel)


type alias Model =
    Task


emptyModel : Model
emptyModel =
    Resources.Tasks.Model.emptyModel


model : Model
model =
    emptyModel
