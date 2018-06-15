module Pages.Dashboard.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field, andThen)
import Resources.Tasks.Model exposing (..)
import Pages.Dashboard.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:8001/tasks"


collectionDecoder : Decode.Decoder (List Task)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Task
memberDecoder =
    Decode.map4 Task
        (field "_id" Decode.string)
        (field "name" Decode.string)
        (field "description" Decode.string)
        (Decode.map stringToStatus (field "status" Decode.string))
