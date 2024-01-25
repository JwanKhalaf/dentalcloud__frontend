module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "DentalCloud"
    , body =
        [ aside [ class "w-[280px] flex-none flex flex-col px-4 pt-8 border-r border-gray-200" ]
            [ nav []
                [ ul []
                    [ sidebarLink "Home" "fa-house" "/"
                    , sidebarLink "Calendar" "fa-calendar" "/calendar"
                    ]
                ]
            ]
        , Html.main_ []
            [ text "Hello from "
            , b [] [ text (Url.toString model.url) ]
            ]
        ]
    }


sidebarLink : String -> String -> String -> Html msg
sidebarLink linktext icon path =
    li [ class "group mb-1" ]
        [ a [ href path, class "flex items-center gap-2 group-hover:text-primary-700 group-hover:bg-primary-50 text-gray-700 font-semibold text-base px-3 py-2 rounded-md" ]
            [ i [ class ("fa-regular " ++ icon) ] []
            , text linktext
            ]
        ]
