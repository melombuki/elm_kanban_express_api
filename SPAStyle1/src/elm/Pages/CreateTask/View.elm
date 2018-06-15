module Pages.CreateTask.View exposing (..)

import Html exposing (div, text, input, button, span, br, a, label, Html)
import Html.Attributes exposing (class, href, placeholder, style, type_)
import Resources.Tasks.Model exposing (..)
import Pages.CreateTask.Messages exposing (..)
import Html.Events exposing (onInput, onClick)


-- VIEW


view : Task -> Html Msg
view task =
    div []
        [ div [ class "ui form" ]
            [ div [ class "ui top attached header" ] [ text "Create a task" ]
            , (taskView2 task)
            ]
        ]


taskView2 : Task -> Html Msg
taskView2 task =
    div [ class "ui attached clearing segment" ]
        [ div [ class "field" ]
            [ label [] [ text "Name" ]
            , input [ type_ "text", placeholder "Enter a new name", class "header", onInput NewName ] [ text task.name ]
            ]
        , div [ class "field" ]
            [ label [] [ text "Description" ]
            , input [ type_ "text", placeholder "Enter a description", class "header", onInput NewDescription ] [ text task.description ]
            ]
        , div [ class "ui right floated primary button", onClick (PostTask task) ] [ text "Create" ]
        , a [ href <| "#dashboard" ] [ div [ class "ui right floated button" ] [ text "Cancel" ] ]
        ]
