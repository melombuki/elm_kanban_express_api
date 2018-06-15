module Pages.CreateTask.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field, andThen)
import Json.Encode as Encode exposing (..)
import Pages.CreateTask.Messages exposing (..)
import Resources.Tasks.Model exposing (..)


postTask body msg =
    let
        request =
            { method = "POST"
            , headers = []
            , url = postTaskUrl
            , body = Http.stringBody "application/json" (jsonToExpressJsonString body)
            , expect = Http.expectStringResponse (\_ -> Ok ())
            , timeout = Nothing
            , withCredentials = False
            }
    in
        Http.request request
            |> Http.send OnPostTask


postTaskUrl : String
postTaskUrl =
    "http://localhost:8001/task"


memberDecoder : Decode.Decoder Task
memberDecoder =
    Decode.map4 Task
        (field "_id" Decode.string)
        (field "name" Decode.string)
        (field "description" Decode.string)
        (Decode.map stringToStatus (field "status" Decode.string))
