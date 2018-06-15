module Pages.CreateTask.Messages exposing (..)

import Http
import Resources.Tasks.Model exposing (..)


type Msg
    = NewName String
    | NewDescription String
    | PostTask Task
    | OnPostTask (Result Http.Error ())
