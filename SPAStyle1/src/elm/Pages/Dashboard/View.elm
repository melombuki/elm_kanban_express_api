module Pages.Dashboard.View exposing (view)

import Html exposing (div, text, h1, ul, li, a, i, Html)
import Html.Attributes exposing (class, href)
import Pages.Dashboard.Model as Dashboard exposing (..)
import Pages.Dashboard.Messages exposing (..)
import Resources.Tasks.Model exposing (..)


-- VIEW


view : Dashboard.Model -> Html Msg
view model =
    div []
        [ div [ class "ui segment center aligned" ]
            [ h1 [ class "content" ]
                [ div [ class "header" ] [ text <| "Welcome " ++ "Josh" ]
                , div [ class "meta" ] [ text <| "@" ++ "melombuki" ]
                , div [] [ text "Here are all of the tasks you have to do:" ]
                ]
            ]
        , div [ class "ui center aligned three column stackable grid" ]
            [ div [ class "row" ]
                [ div [ class "column" ]
                    [ div [ class "ui vertical fluid menu" ]
                        (model
                            |> List.filter (\t -> t.status == Todo)
                            |> List.map (\t -> taskView t)
                        )
                    ]
                , div [ class "column" ]
                    [ div [ class "ui vertical fluid menu" ]
                        (model
                            |> List.filter (\t -> t.status == InProgress)
                            |> List.map (\t -> taskView t)
                        )
                    ]
                , div [ class "column" ]
                    [ div [ class "ui vertical fluid menu" ]
                        (model
                            |> List.filter (\t -> t.status == Done)
                            |> List.map (\t -> taskView t)
                        )
                    ]
                ]
            ]
        ]


taskView : Task -> Html Msg
taskView task =
    div [ class "item" ]
        [ div [ class "ui raised card centered" ]
            [ div [ class "content" ]
                [ div [ class "header" ]
                    [ a [ href <| "#edittask/" ++ task.id ] [ i [ class "edit icon" ] [] ]
                    , a [ href <| "#task/" ++ task.id ] [ text task.name ]
                    ]
                , div [ class "meta" ] [ text <| statusToString task ]
                , div [] [ text task.description ]
                ]
            ]
        ]


getTaskColumn : Task -> String
getTaskColumn task =
    case task.status of
        InProgress ->
            "centered"

        Todo ->
            "left"

        Done ->
            "right"
