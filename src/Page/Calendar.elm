module Page.Calendar exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    Int


type Msg
    = Increment
    | Decrement
    | Reset


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none )

        Reset ->
            init


title : Model -> String
title model =
    String.join " " [ "•Count:", String.fromInt model, "•" ]


view : Model -> ( String, Html Msg )
view model =
    ( title model
    , p []
        [ Html.h1 [] [ Html.text "Counter" ]
        , Html.div [ class "grid" ]
            [ Html.text (String.fromInt model)
            ]
        ]
    )
