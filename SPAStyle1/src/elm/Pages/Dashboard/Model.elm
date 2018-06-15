module Pages.Dashboard.Model exposing (..)

import Resources.Tasks.Model exposing (Task)


type alias Model =
    List Task


emptyModel : Model
emptyModel =
    []


model : Model
model =
    emptyModel
