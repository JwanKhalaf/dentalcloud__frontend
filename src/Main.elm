module Main exposing (..)

import Browser
import Browser.Events exposing (onKeyPress)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode
import Page.Calendar
import Page.Home
import Page.NotFound
import Route exposing (Route)
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


type alias Preferences =
    Bool


type alias PagesState =
    { calendar : Page.Calendar.Model
    }


type alias Model =
    { navKey : Nav.Key
    , url : Url.Url
    , route : Maybe Route
    , preferences : Preferences
    , pagesState : PagesState
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    let
        ( pagesState, cmd ) =
            pagesInit
    in
    ( { navKey = navKey
      , url = url
      , route = Route.fromUrl url
      , preferences = True
      , pagesState = pagesState
      }
    , cmd
    )


pagesInit : ( PagesState, Cmd Msg )
pagesInit =
    let
        ( counterModel, counterCmd ) =
            Page.Calendar.init

        cmd =
            Cmd.batch [ Cmd.map GotCalendarMsg counterCmd ]
    in
    ( { calendar = counterModel }
    , cmd
    )



-- UPDATE


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotCalendarMsg Page.Calendar.Msg
    | ShowSearch


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.navKey (Url.toString url)
                    )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url, route = Route.fromUrl url }, Cmd.none )

        GotCalendarMsg subMsg ->
            updateCounter model subMsg

        ShowSearch ->
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


updateCounter : Model -> Page.Calendar.Msg -> ( Model, Cmd Msg )
updateCounter model subMsg =
    let
        pageModels =
            model.pagesState

        previousPageModel =
            pageModels.calendar

        ( newPageModel, pageCmd ) =
            Page.Calendar.update subMsg previousPageModel

        newPages =
            { pageModels | calendar = newPageModel }

        newModel =
            { model | pagesState = newPages }
    in
    ( newModel, Cmd.map GotCalendarMsg pageCmd )



-- SUBSCRIPTIONS


keyPressDecoder : Decode.Decoder Msg
keyPressDecoder =
    Decode.map2
        (\key control ->
            if key == "q" && control then
                ShowSearch

            else
                NoOp
        )
        (Decode.field "key" Decode.string)
        (Decode.field "ctrlKey" Decode.bool)


subscriptions : Model -> Sub Msg
subscriptions _ =
    onKeyPress keyPressDecoder



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        ( pageTitel, pageContent ) =
            pageView model
    in
    { title = pageTitel
    , body =
        [ aside [ class "w-[312px] flex-none flex flex-col px-4 pt-8 border-r border-gray-200" ]
            [ nav []
                [ ul []
                    [ sidebarLink "Home" "fa-house" model.route Route.Home
                    , sidebarLink "Calendar" "fa-calendar" model.route Route.Calendar
                    ]
                ]
            ]
        , main_ [] [ pageContent ]
        , div [ class "absolute w-1/3 bg-white border-0 rounded-lg focus-visible:ring-0 focus-visible:shadow-none shadow-xl opacity-100" ]
            [ label [ class "relative block border-b border-gray-300" ]
                [ span [ class "sr-only" ] [ text "search" ]
                , span [ class "absolute inset-y-0 left-0 flex items-center pl-3.5" ]
                    [ i [ class "fa-regular fa-search" ] []
                    ]
                , span [ class "absolute inset-y-0 ring-0 flex items-center pr-3.5 text-gray-500 font-semibold" ]
                    []
                , input
                    [ class "w-full h-16 border-0 rounded-lg focus:ring-0 placeholder:text-gray-500 placeholder:text-base placeholder:font-normal px-11", type_ "text", name "search", placeholder "Search" ]
                    []
                ]
            ]
        ]
    }


pageView : Model -> ( String, Html Msg )
pageView model =
    case model.route of
        Nothing ->
            Page.NotFound.view

        Just Route.Home ->
            Page.Home.view

        Just Route.Calendar ->
            let
                ( title, content ) =
                    Page.Calendar.view model.pagesState.calendar
            in
            ( title, Html.map GotCalendarMsg content )


sidebarLink : String -> String -> Maybe Route -> Route -> Html msg
sidebarLink linktext icon activeRoute targetRoute =
    li [ class "group mb-1" ]
        [ a [ href (Route.toUrl targetRoute), class (sidebarLinkCss (isActivePage activeRoute targetRoute)) ]
            [ i [ class ("fa-regular " ++ icon) ] []
            , text linktext
            ]
        ]


isActivePage : Maybe Route -> Route -> Bool
isActivePage activeRoute targetRoute =
    case activeRoute of
        Nothing ->
            False

        Just r ->
            if r == targetRoute then
                True

            else
                False


sidebarLinkCss : Bool -> String
sidebarLinkCss isActive =
    if isActive then
        "flex items-center gap-2 group-hover:text-primary-700 group-hover:bg-primary-50 text-gray-700 font-semibold text-base px-3 py-2 rounded-md text-primary-700 bg-primary-50"

    else
        "flex items-center gap-2 group-hover:text-primary-700 group-hover:bg-primary-50 text-gray-700 font-semibold text-base px-3 py-2 rounded-md"
