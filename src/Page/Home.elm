module Page.Home exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : ( String, Html msg )
view =
    ( "•Home•"
    , homeView
    )


homeView : Html msg
homeView =
    main_ [ class "pt-8 px-8 w-full" ]
        [ div [ class "mb-5" ]
            [ div [ class "flex items-center" ]
                [ i [ class "fa-regular fa-house" ] []
                ]
            ]
        , div [ class "mb-6" ]
            [ h1 [ class "font-inter text-gray-900 text-3xl font-semibold mb-1" ] [ text "Welcome Dr. Olivia" ]
            , p [ class "text-gray-600 text-base font-normal" ] [ text "Below is an overview of things" ]
            ]
        , div [ class "mb-6 flex" ]
            [ div [ class "rounded-xl p-6 mr-6 shadow-sm" ]
                [ h3 [ class "text-sm font-medium text-gray-600 mb-2" ] [ text "Today's appointments" ]
                , span [ class "text-3xl text-gray-900" ] [ text "4" ]
                ]
            , div [ class "rounded-xl p-6 shadow-sm" ]
                [ h3 [ class "text-sm font-medium text-gray-600 mb-2" ] [ text "Daily private grossing" ]
                , span [ class "text-3xl text-gray-900" ] [ text "£350" ]
                ]
            ]
        ]
