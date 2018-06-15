module Pages.EditTask.Commands exposing (..)

import App.Model exposing (Page)
import Http
import Json.Decode as Decode exposing (field, andThen)
import Json.Encode as Encode exposing (..)
import Pages.EditTask.Messages exposing (..)
import Resources.Tasks.Model exposing (..)
import Task exposing (..)


setActivePage : msg -> Cmd Msg
setActivePage msg =
    Task.succeed msg
        |> Task.perform (\_ -> SetActivePage App.Model.Dashboard)


postTask body msg =
    let
        request =
            { method = "POST"
            , headers = []
            , url = postTaskUrl
            , body = Http.stringBody "application/json" (jsonToExpressJsonStringWithId body)
            , expect = Http.expectStringResponse (\_ -> Ok ())
            , timeout = Nothing
            , withCredentials = False
            }
    in
        Http.request request
            |> Http.send OnPostTask


fetchTaskBaseUrl : String
fetchTaskBaseUrl =
    "http://localhost:8001/task/"


postTaskUrl : String
postTaskUrl =
    "http://localhost:8001/updatetask/"


fetchTask : String -> Cmd Msg
fetchTask id =
    Http.get (fetchTaskUrl id) memberDecoder
        |> Http.send OnFetchTask


fetchTaskUrl : String -> String
fetchTaskUrl id =
    fetchTaskBaseUrl ++ id


memberDecoder : Decode.Decoder Resources.Tasks.Model.Task
memberDecoder =
    Decode.map4 Resources.Tasks.Model.Task
        (field "_id" Decode.string)
        (field "name" Decode.string)
        (field "description" Decode.string)
        (Decode.map stringToStatus (field "status" Decode.string))
