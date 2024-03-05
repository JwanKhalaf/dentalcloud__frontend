module Component.CommandPalette exposing (focusSearchBox, view)

import Browser.Dom as Dom
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)
import Svg exposing (..)
import Svg.Attributes as SvgAttr exposing (..)
import Task


view : Html msg
view =
    commandPaletteView


focusSearchBox : { onFocus : Result Dom.Error () -> msg } -> Cmd msg
focusSearchBox { onFocus } =
    Task.attempt onFocus (Dom.focus "search-box")


commandPaletteView : Html msg
commandPaletteView =
    div
        [ Attr.class "relative z-10"
        , Attr.attribute "role" "dialog"
        , Attr.attribute "aria-modal" "true"
        ]
        [ div
            [ Attr.class "fixed inset-0 bg-gray-500 bg-opacity-25 transition-opacity"
            ]
            []
        , div
            [ Attr.class "fixed inset-0 z-10 w-screen overflow-y-auto p-4 sm:p-6 md:p-20"
            ]
            [ div
                [ Attr.class "mx-auto max-w-3xl transform divide-y divide-gray-100 overflow-hidden rounded-xl bg-white shadow-2xl ring-1 ring-black ring-opacity-5 transition-all"
                ]
                [ div
                    [ Attr.class "relative"
                    ]
                    [ svg
                        [ SvgAttr.class "pointer-events-none absolute left-4 top-3.5 h-5 w-5 text-gray-400"
                        , SvgAttr.viewBox "0 0 20 20"
                        , SvgAttr.fill "currentColor"
                        , Attr.attribute "aria-hidden" "true"
                        ]
                        [ Svg.path
                            [ SvgAttr.fillRule "evenodd"
                            , SvgAttr.d "M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z"
                            , SvgAttr.clipRule "evenodd"
                            ]
                            []
                        ]
                    , input
                        [ Attr.type_ "text"
                        , Attr.class "h-12 w-full border-0 bg-transparent pl-11 pr-4 text-gray-800 placeholder:text-gray-400 focus:ring-0 sm:text-sm"
                        , Attr.placeholder "Search..."
                        , Attr.attribute "role" "combobox"
                        , Attr.attribute "aria-expanded" "false"
                        , Attr.attribute "aria-controls" "options"
                        , Attr.id "search-box"
                        ]
                        []
                    ]
                , div
                    [ Attr.class "flex transform-gpu divide-x divide-gray-100"
                    ]
                    [ div
                        [ Attr.class "max-h-96 min-w-0 flex-auto scroll-py-4 overflow-y-auto px-6 py-4 sm:h-96"
                        ]
                        [ h2
                            [ Attr.class "mb-4 mt-2 text-xs font-semibold text-gray-500"
                            ]
                            [ Html.text "Recent searches" ]
                        , ul
                            [ Attr.class "-mx-2 text-sm text-gray-700"
                            , Attr.id "recent"
                            , Attr.attribute "role" "listbox"
                            ]
                            [ li
                                [ Attr.class "group flex cursor-default select-none items-center rounded-md p-2"
                                , Attr.id "recent-1"
                                , Attr.attribute "role" "option"
                                , Attr.tabindex -1
                                ]
                                [ img
                                    [ Attr.src "https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                                    , Attr.alt ""
                                    , Attr.class "h-6 w-6 flex-none rounded-full"
                                    ]
                                    []
                                , span
                                    [ Attr.class "ml-3 flex-auto truncate"
                                    ]
                                    [ Html.text "Floyd Miles" ]
                                , svg
                                    [ SvgAttr.class "ml-3 hidden h-5 w-5 flex-none text-gray-400"
                                    , SvgAttr.viewBox "0 0 20 20"
                                    , SvgAttr.fill "currentColor"
                                    , Attr.attribute "aria-hidden" "true"
                                    ]
                                    [ Svg.path
                                        [ SvgAttr.fillRule "evenodd"
                                        , SvgAttr.d "M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
                                        , SvgAttr.clipRule "evenodd"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , ul
                            [ Attr.class "-mx-2 text-sm text-gray-700"
                            , Attr.id "options"
                            , Attr.attribute "role" "listbox"
                            ]
                            [ li
                                [ Attr.class "group flex cursor-default select-none items-center rounded-md p-2"
                                , Attr.id "option-1"
                                , Attr.attribute "role" "option"
                                , Attr.tabindex -1
                                ]
                                [ img
                                    [ Attr.src "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                                    , Attr.alt ""
                                    , Attr.class "h-6 w-6 flex-none rounded-full"
                                    ]
                                    []
                                , span
                                    [ Attr.class "ml-3 flex-auto truncate"
                                    ]
                                    [ Html.text "Tom Cook" ]
                                , svg
                                    [ SvgAttr.class "ml-3 hidden h-5 w-5 flex-none text-gray-400"
                                    , SvgAttr.viewBox "0 0 20 20"
                                    , SvgAttr.fill "currentColor"
                                    , Attr.attribute "aria-hidden" "true"
                                    ]
                                    [ Svg.path
                                        [ SvgAttr.fillRule "evenodd"
                                        , SvgAttr.d "M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
                                        , SvgAttr.clipRule "evenodd"
                                        ]
                                        []
                                    ]
                                ]
                            , li
                                [ Attr.class "group flex cursor-default select-none items-center rounded-md p-2"
                                , Attr.id "option-2"
                                , Attr.attribute "role" "option"
                                , Attr.tabindex -1
                                ]
                                [ img
                                    [ Attr.src "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                                    , Attr.alt ""
                                    , Attr.class "h-6 w-6 flex-none rounded-full"
                                    ]
                                    []
                                , span
                                    [ Attr.class "ml-3 flex-auto truncate"
                                    ]
                                    [ Html.text "Courtney Henry" ]
                                , svg
                                    [ SvgAttr.class "ml-3 hidden h-5 w-5 flex-none text-gray-400"
                                    , SvgAttr.viewBox "0 0 20 20"
                                    , SvgAttr.fill "currentColor"
                                    , Attr.attribute "aria-hidden" "true"
                                    ]
                                    [ Svg.path
                                        [ SvgAttr.fillRule "evenodd"
                                        , SvgAttr.d "M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
                                        , SvgAttr.clipRule "evenodd"
                                        ]
                                        []
                                    ]
                                ]
                            , li
                                [ Attr.class "group flex cursor-default select-none items-center rounded-md p-2"
                                , Attr.id "option-3"
                                , Attr.attribute "role" "option"
                                , Attr.tabindex -1
                                ]
                                [ img
                                    [ Attr.src "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                                    , Attr.alt ""
                                    , Attr.class "h-6 w-6 flex-none rounded-full"
                                    ]
                                    []
                                , span
                                    [ Attr.class "ml-3 flex-auto truncate"
                                    ]
                                    [ Html.text "Dries Vincent" ]
                                , svg
                                    [ SvgAttr.class "ml-3 hidden h-5 w-5 flex-none text-gray-400"
                                    , SvgAttr.viewBox "0 0 20 20"
                                    , SvgAttr.fill "currentColor"
                                    , Attr.attribute "aria-hidden" "true"
                                    ]
                                    [ Svg.path
                                        [ SvgAttr.fillRule "evenodd"
                                        , SvgAttr.d "M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
                                        , SvgAttr.clipRule "evenodd"
                                        ]
                                        []
                                    ]
                                ]
                            , li
                                [ Attr.class "group flex cursor-default select-none items-center rounded-md p-2"
                                , Attr.id "option-4"
                                , Attr.attribute "role" "option"
                                , Attr.tabindex -1
                                ]
                                [ img
                                    [ Attr.src "https://images.unsplash.com/photo-1500917293891-ef795e70e1f6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                                    , Attr.alt ""
                                    , Attr.class "h-6 w-6 flex-none rounded-full"
                                    ]
                                    []
                                , span
                                    [ Attr.class "ml-3 flex-auto truncate"
                                    ]
                                    [ Html.text "Kristin Watson" ]
                                , svg
                                    [ SvgAttr.class "ml-3 hidden h-5 w-5 flex-none text-gray-400"
                                    , SvgAttr.viewBox "0 0 20 20"
                                    , SvgAttr.fill "currentColor"
                                    , Attr.attribute "aria-hidden" "true"
                                    ]
                                    [ Svg.path
                                        [ SvgAttr.fillRule "evenodd"
                                        , SvgAttr.d "M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
                                        , SvgAttr.clipRule "evenodd"
                                        ]
                                        []
                                    ]
                                ]
                            , li
                                [ Attr.class "group flex cursor-default select-none items-center rounded-md p-2"
                                , Attr.id "option-5"
                                , Attr.attribute "role" "option"
                                , Attr.tabindex -1
                                ]
                                [ img
                                    [ Attr.src "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                                    , Attr.alt ""
                                    , Attr.class "h-6 w-6 flex-none rounded-full"
                                    ]
                                    []
                                , span
                                    [ Attr.class "ml-3 flex-auto truncate"
                                    ]
                                    [ Html.text "Jeffrey Webb" ]
                                , svg
                                    [ SvgAttr.class "ml-3 hidden h-5 w-5 flex-none text-gray-400"
                                    , SvgAttr.viewBox "0 0 20 20"
                                    , SvgAttr.fill "currentColor"
                                    , Attr.attribute "aria-hidden" "true"
                                    ]
                                    [ Svg.path
                                        [ SvgAttr.fillRule "evenodd"
                                        , SvgAttr.d "M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
                                        , SvgAttr.clipRule "evenodd"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        ]
                    , div
                        [ Attr.class "hidden h-96 w-1/2 flex-none flex-col divide-y divide-gray-100 overflow-y-auto sm:flex"
                        ]
                        [ div
                            [ Attr.class "flex-none p-6 text-center"
                            ]
                            [ img
                                [ Attr.src "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                                , Attr.alt ""
                                , Attr.class "mx-auto h-16 w-16 rounded-full"
                                ]
                                []
                            , h2
                                [ Attr.class "mt-3 font-semibold text-gray-900"
                                ]
                                [ Html.text "Tom Cook" ]
                            , p
                                [ Attr.class "text-sm leading-6 text-gray-500"
                                ]
                                [ Html.text "Director, Product Development" ]
                            ]
                        , div
                            [ Attr.class "flex flex-auto flex-col justify-between p-6"
                            ]
                            [ dl
                                [ Attr.class "grid grid-cols-1 gap-x-6 gap-y-3 text-sm text-gray-700"
                                ]
                                [ dt
                                    [ Attr.class "col-end-1 font-semibold text-gray-900"
                                    ]
                                    [ Html.text "Phone" ]
                                , dd []
                                    [ Html.text "881-460-8515" ]
                                , dt
                                    [ Attr.class "col-end-1 font-semibold text-gray-900"
                                    ]
                                    [ Html.text "URL" ]
                                , dd
                                    [ Attr.class "truncate"
                                    ]
                                    [ Html.a
                                        [ Attr.href "https://example.com"
                                        , Attr.class "text-indigo-600 underline"
                                        ]
                                        [ Html.text "https://example.com" ]
                                    ]
                                , dt
                                    [ Attr.class "col-end-1 font-semibold text-gray-900"
                                    ]
                                    [ Html.text "Email" ]
                                , dd
                                    [ Attr.class "truncate"
                                    ]
                                    [ Html.a
                                        [ Attr.href "#"
                                        , Attr.class "text-indigo-600 underline"
                                        ]
                                        [ Html.text "tomcook@example.com" ]
                                    ]
                                ]
                            , button
                                [ Attr.type_ "button"
                                , Attr.class "mt-6 w-full rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                                ]
                                [ Html.text "Send message" ]
                            ]
                        ]
                    ]
                , div
                    [ Attr.class "px-6 py-14 text-center text-sm sm:px-14"
                    ]
                    [ svg
                        [ SvgAttr.class "mx-auto h-6 w-6 text-gray-400"
                        , SvgAttr.fill "none"
                        , SvgAttr.viewBox "0 0 24 24"
                        , SvgAttr.strokeWidth "1.5"
                        , SvgAttr.stroke "currentColor"
                        , Attr.attribute "aria-hidden" "true"
                        ]
                        [ Svg.path
                            [ SvgAttr.strokeLinecap "round"
                            , SvgAttr.strokeLinejoin "round"
                            , SvgAttr.d "M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"
                            ]
                            []
                        ]
                    , p
                        [ Attr.class "mt-4 font-semibold text-gray-900"
                        ]
                        [ Html.text "No people found" ]
                    , p
                        [ Attr.class "mt-2 text-gray-500"
                        ]
                        [ Html.text "We couldn’t find anything with that term. Please try again." ]
                    ]
                ]
            ]
        ]
