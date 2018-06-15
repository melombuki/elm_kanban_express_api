module Pages.Task.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field, andThen)
import Resources.Tasks.Model exposing (..)
import Pages.Task.Messages exposing (..)


fetchTask : String -> Cmd Msg
fetchTask id =
    Http.get (fetchTaskUrl id) memberDecoder
        |> Http.send OnFetchTask


fetchTaskUrl : String -> String
fetchTaskUrl id =
    "http://localhost:8001/task/" ++ id


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
