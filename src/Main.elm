port module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Component.CommandPalette
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onFocus)
import Page.Calendar
import Page.Home
import Page.NotFound
import Platform.Cmd as Cmd
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



-- PORTS


port showCommandCentre : (() -> msg) -> Sub msg


port hideCommandCentre : (() -> msg) -> Sub msg



-- MODEL


type alias Preferences =
    Bool


type alias PagesState =
    { calendar : Page.Calendar.Model
    , showCommandCentre : Bool
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
    ( { calendar = counterModel, showCommandCentre = False }
    , cmd
    )



-- UPDATE


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotCalendarMsg Page.Calendar.Msg
    | ShowCommandCentre
    | HideCommandCentre


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

        ShowCommandCentre ->
            let
                { pagesState } =
                    model
            in
            ( { model | pagesState = { pagesState | showCommandCentre = True } }
            , Component.CommandPalette.focusSearchBox { onFocus = \_ -> NoOp }
            )

        HideCommandCentre ->
            let
                { pagesState } =
                    model
            in
            ( { model | pagesState = { pagesState | showCommandCentre = False } }
            , Cmd.none
            )

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


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ showCommandCentre (\() -> ShowCommandCentre)
        , hideCommandCentre (\() -> HideCommandCentre)
        ]



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
        , if model.pagesState.showCommandCentre then
            Component.CommandPalette.view

          else
            text ""
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
