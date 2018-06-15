module Pages.EditTask.View exposing (..)

import Html exposing (div, text, input, button, span, br, a, label, select, option, Html)
import Html.Attributes exposing (class, href, placeholder, style, type_, readonly, value, disabled, selected, hidden)
import Html.Events exposing (on, onInput, onClick)
import Json.Decode as Json
import Resources.Tasks.Model exposing (..)
import Pages.EditTask.Messages exposing (..)


-- VIEW


view : Task -> Html Msg
view task =
    div []
        [ div [ class "ui form" ]
            [ div [ class "ui top attached header" ] [ text <| "Edit task: " ++ task.id ]
            , (taskView task)
            ]
        ]


targetValueDecoder : Json.Decoder Status
targetValueDecoder =
    Html.Events.targetValue
        |> Json.andThen
            (\val ->
                case val of
                    "Todo" ->
                        Json.succeed Todo

                    "InProgress" ->
                        Json.succeed InProgress

                    "Done" ->
                        Json.succeed Done

                    _ ->
                        Json.fail ("Invalid status: " ++ val)
            )


taskView : Task -> Html Msg
taskView task =
    let
        selectedState =
            on "change"
                (Json.map NewStatus targetValueDecoder)
    in
        div [ class "ui attached clearing segment" ]
            [ div [ class "field" ]
                [ label [] [ text "Name" ]
                , input [ type_ "text", placeholder "Enter a new name", class "header", onInput NewName, value task.name ] []
                ]
            , div [ class "field" ]
                [ label [] [ text "Status" ]
                , select [ selectedState ]
                    [ option [ value "", disabled True, selected True, hidden True ] []
                    , option [ value "Todo" ] [ text "Todo" ]
                    , option [ value "InProgress" ] [ text "InProgress" ]
                    , option [ value "Done" ] [ text "Done" ]
                    ]
                ]
            , div [ class "field" ]
                [ label [] [ text "Description" ]
                , input [ type_ "text", placeholder "Enter a description", class "header", onInput NewDescription, value task.description ] []
                ]
            , div [ class "ui right floated primary button", onClick (PostTask task) ] [ text "Sumbit" ]
            , a [ href <| "#dashboard" ] [ div [ class "ui right floated button" ] [ text "Cancel" ] ]
            ]
