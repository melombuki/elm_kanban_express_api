module Pages.Task.View exposing (view)

import Html exposing (div, text, h1, ul, li, Html)
import Html.Attributes exposing (class)
import Pages.Task.Model exposing (..)
import Pages.Task.Messages exposing (..)
import Resources.Tasks.Model exposing (..)


-- VIEW


view : Maybe Task -> Html Msg
view model =
    div []
        [ div [ class "ui segment center aligned" ]
            [ h1 [ class "content" ]
                [ div [ class "header" ]
                    [ text "Do This Thing" ]
                ]
            ]
        , div [] [ taskView model ]
        ]


taskView : Maybe Task -> Html Msg
taskView task =
    case task of
        Just newTask ->
            div [ class "item" ]
                [ div [ class "ui raised card centered" ]
                    [ div [ class "content" ]
                        [ div [ class "header" ] [ text newTask.name ]
                        , div [ class "meta" ] [ text <| statusToString newTask ]
                        , div [] [ text newTask.description ]
                        ]
                    ]
                ]

        Nothing ->
            div [] [ text "There was a problem getting your task, take the day off!!" ]
