module App.Router exposing (delta2url, location2messages)

import App.Model exposing (..)
import App.Messages exposing (..)
import Navigation exposing (Location)
import RouteUrl exposing (HistoryEntry(..), UrlChange)
import UrlParser exposing (Parser, (</>), s, int, string, map, oneOf, parseHash)


delta2url : Model -> Model -> Maybe UrlChange
delta2url previous current =
    case current.activePage of
        AccessDenied ->
            Nothing

        Dashboard ->
            Just <| UrlChange NewEntry "/#dashboard"

        CreateTask ->
            Just <| UrlChange NewEntry "/#create-task"

        Task id ->
            Just <| UrlChange NewEntry <| "/#task/" ++ id

        EditTask id ->
            Just <| UrlChange NewEntry <| "/#edittask/" ++ id

        PageNotFound ->
            Just <| UrlChange NewEntry "/#404"


location2messages : Location -> List Msg
location2messages location =
    let
        parsedRoute =
            parseHash route location
    in
        case parsedRoute of
            Nothing ->
                [ SetActivePage Dashboard ]

            Just Dashboard ->
                [ SetActivePage Dashboard ]

            Just CreateTask ->
                [ SetActivePage CreateTask ]

            Just (Task id) ->
                [ SetActivePage (Task id) ]

            Just (EditTask id) ->
                [ SetActivePage (EditTask id) ]

            Just PageNotFound ->
                [ SetActivePage PageNotFound ]

            _ ->
                [ SetActivePage PageNotFound ]


route : Parser (Page -> a) a
route =
    oneOf
        [ map Dashboard (s "dashboard")
        , map CreateTask (s "create-task")
        , map Task (s "task" </> string)
        , map EditTask (s "edittask" </> string)
        , map CreateTask (s "404")
        ]
