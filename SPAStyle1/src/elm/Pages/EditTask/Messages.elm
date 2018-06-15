module Pages.EditTask.Messages exposing (..)

import Http
import Resources.Tasks.Model exposing (..)
import App.Model exposing (Page)


type Msg
    = NewName String
    | NewDescription String
    | NewStatus Status
    | PostTask Task
    | OnPostTask (Result Http.Error ())
    | OnFetchTask (Result Http.Error Task)
    | SetActivePage Page
