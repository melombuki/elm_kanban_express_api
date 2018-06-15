module Pages.Dashboard.Messages exposing (..)

import Http
import Resources.Tasks.Model exposing (..)


type Msg
    = OnFetchAll (Result Http.Error (List Task))
