module App.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, href, src, style, target)
import Html.Events exposing (onClick)
import App.Model exposing (..)
import App.Messages exposing (..)
import Pages.Dashboard.View exposing (..)
import Pages.CreateTask.View exposing (..)
import Pages.Task.View exposing (..)
import Pages.EditTask.View exposing (..)
import Pages.PageNotFound.View exposing (..)


view : App.Model.Model -> Html App.Messages.Msg
view model =
    div []
        [ div [ class "ui container main" ]
            [ viewHeader model
            , viewMainContent model
            , pre [ class "ui padded" ] []
            ]
        , viewFooter
        ]


viewHeader : App.Model.Model -> Html App.Messages.Msg
viewHeader model =
    let
        navbar =
            navbarAuthenticated
    in
        div [ class "ui secondary pointing menu" ] (navbar model)


navbarAuthenticated : App.Model.Model -> List (Html App.Messages.Msg)
navbarAuthenticated model =
    let
        id =
            case model.task of
                Just task ->
                    task.id

                Nothing ->
                    ""
    in
        [ a
            [ classByPage Dashboard model.activePage
            , onClick <| SetActivePage Dashboard
            ]
            [ text "Dashboard" ]
        , a
            [ classByPage CreateTask model.activePage
            , onClick <| SetActivePage CreateTask
            ]
            [ text "CreateTask" ]
        ]


viewPageNotFoundItem : Page -> Html App.Messages.Msg
viewPageNotFoundItem activePage =
    a
        [ classByPage PageNotFound activePage
        , onClick <| SetActivePage PageNotFound
        ]
        [ text "404 page" ]


viewMainContent : App.Model.Model -> Html App.Messages.Msg
viewMainContent model =
    case model.activePage of
        AccessDenied ->
            Pages.PageNotFound.View.view

        Dashboard ->
            Html.map DashboardPageUpdates (Pages.Dashboard.View.view model.tasks)

        CreateTask ->
            Html.map CreateTaskPageUpdates (Pages.CreateTask.View.view model.createTask)

        Task id ->
            Html.map TaskPageUpdates (Pages.Task.View.view model.task)

        EditTask id ->
            Html.map EditTaskPageUpdates (Pages.EditTask.View.view model.editTask)

        PageNotFound ->
            Pages.PageNotFound.View.view


viewFooter : Html App.Messages.Msg
viewFooter =
    div [ class "ui inverted vertical footer segment form-page" ]
        [ div [ class "ui container" ]
            [ text "Powered by: "
            , a [ href "http://www.melombuki.com", target "_blank" ]
                [ text "Melombuki" ]
            , text ", and all the coffees."
            ]
        ]


{-| Get menu items classes. This function gets the active page and checks if
it is indeed the page used.
-}
classByPage : Page -> Page -> Attribute a
classByPage page activePage =
    classList
        [ ( "item", True )
        , ( "active", page == activePage )
        ]
