module App.Update exposing (init, update)

import App.Model exposing (..)
import App.Commands exposing (..)
import App.Messages exposing (..)
import Task exposing (..)
import Pages.Dashboard.Update exposing (..)
import Pages.Dashboard.Commands exposing (..)
import Pages.Task.Update exposing (..)
import Pages.Task.Commands exposing (..)
import Pages.CreateTask.Update exposing (..)
import Pages.EditTask.Messages exposing (..)
import Pages.EditTask.Update exposing (..)
import Pages.EditTask.Commands exposing (..)


init : ( App.Model.Model, Cmd msg )
init =
    App.Model.emptyModel ! []


update : App.Messages.Msg -> App.Model.Model -> ( App.Model.Model, Cmd App.Messages.Msg )
update msg model =
    case msg of
        App.Messages.SetActivePage page ->
            let
                cmd =
                    case page of
                        Dashboard ->
                            Cmd.map DashboardPageUpdates Pages.Dashboard.Commands.fetchAll

                        Task id ->
                            Cmd.map TaskPageUpdates (Pages.Task.Commands.fetchTask id)

                        EditTask id ->
                            Cmd.map EditTaskPageUpdates (Pages.EditTask.Commands.fetchTask id)

                        otherwise ->
                            Cmd.none
            in
                ( { model | activePage = page }, cmd )

        DashboardPageUpdates msg ->
            let
                ( tasks, cmd ) =
                    Pages.Dashboard.Update.update msg model.tasks
            in
                ( { model | tasks = tasks }, Cmd.map DashboardPageUpdates cmd )

        TaskPageUpdates msg ->
            let
                ( task, cmd ) =
                    Pages.Task.Update.update msg model.task
            in
                case task of
                    Just newTask ->
                        ( { model | task = Just newTask }, Cmd.map TaskPageUpdates cmd )

                    Nothing ->
                        ( { model | task = Nothing }, Cmd.map TaskPageUpdates cmd )

        CreateTaskPageUpdates msg ->
            let
                ( newModel, cmd ) =
                    Pages.CreateTask.Update.update msg model.createTask
            in
                { model | createTask = newModel } ! [ Cmd.map CreateTaskPageUpdates cmd ]

        EditTaskPageUpdates msg ->
            let
                ( task, cmd ) =
                    Pages.EditTask.Update.update msg model.editTask
            in
                case msg of
                    Pages.EditTask.Messages.SetActivePage page ->
                        ( { model | editTask = task }, goto page )

                    _ ->
                        { model | editTask = task } ! [ Cmd.map EditTaskPageUpdates cmd ]


{-| Determine if a page can be accessed by a user (anonymous or authenticated),
and if not return an access denied page.
If the user is authenticated, don't allow them to revisit Login page. Do the
opposite for anonumous user - don't allow them to visit the Dashboard page.
-}
setActivePageAccess : Page -> Page
setActivePageAccess page =
    page



--    case user of
--        Success _ ->
--            if page == Login then
--                AccessDenied
--            else
--                page
--
--        _ ->
--            if page == Dashboard then
--                AccessDenied
--            else if page == Task then
--                AccessDenied
--            else if page == CreateTaske then
--                AccessDenied
--            else
--                page
