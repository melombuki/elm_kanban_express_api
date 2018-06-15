module Pages.Task.Messages exposing (..)

import Http
import Resources.Tasks.Model exposing (..)


type Msg
    = OnFetchTask (Result Http.Error Task)
