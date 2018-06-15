module Resources.Tasks.Model exposing (..)


type alias Task =
    { id : String
    , name : String
    , description : String
    , status : Status
    }


type Status
    = Todo
    | InProgress
    | Done


statusToString : Task -> String
statusToString task =
    case task.status of
        InProgress ->
            "In Progress"

        Todo ->
            "Todo"

        Done ->
            "Done"


stringToStatus : String -> Status
stringToStatus status =
    case status of
        "In Progress" ->
            InProgress

        "Todo" ->
            Todo

        "Done" ->
            Done

        _ ->
            Todo


emptyModel : Task
emptyModel =
    { id = ""
    , name = ""
    , description = ""
    , status = Todo
    }


jsonToExpressJsonString : Task -> String
jsonToExpressJsonString task =
    "{\"name\":\"" ++ task.name ++ "\",\"description\":\"" ++ task.description ++ "\",\"status\":\"" ++ (statusToString task) ++ "\"}"


jsonToExpressJsonStringWithId : Task -> String
jsonToExpressJsonStringWithId task =
    "{\"_id\":\"" ++ task.id ++ "\",\"name\":\"" ++ task.name ++ "\",\"description\":\"" ++ task.description ++ "\",\"status\":\"" ++ (statusToString task) ++ "\"}"
