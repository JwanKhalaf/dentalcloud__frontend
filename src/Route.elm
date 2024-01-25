module Route exposing (Route(..), fromUrl, toPath, toUrl)

import Url exposing (Url)
import Url.Builder
import Url.Parser as Parser exposing (Parser, oneOf, s)


type Route
    = Home
    | Calendar


subPath : String
subPath =
    "dentalcloud"


toUrl : Route -> String
toUrl route =
    case route of
        Home ->
            "/"

        Calendar ->
            "/calendar"


toPath : Url.Url -> Route -> String
toPath url route =
    let
        subPathOrNot =
            if String.contains subPath url.path then
                [ subPath ]

            else
                []

        pathSegments =
            subPathOrNot
                ++ [ case route of
                        Home ->
                            ""

                        Calendar ->
                            "calendar"
                   ]

        queryParameters =
            []
    in
    Url.Builder.absolute pathSegments queryParameters


parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map Home Parser.top
        , Parser.map Calendar (s "calendar")
        ]


normalizePath : String -> String
normalizePath path =
    let
        -- Github pages doesn't serve the site under the root of the domain, but under a path named after the project: https://domain/elm-examples-spa/
        -- Make it work when served under either the root or the path
        pathSegments =
            String.split "/" path
                |> List.filter (\x -> not (List.member x [ subPath, "" ]))

        queryParameters =
            []
    in
    Url.Builder.absolute pathSegments queryParameters


normalizeUrl : Url -> Url
normalizeUrl url =
    { url | path = normalizePath url.path }


fromUrl : Url -> Maybe Route
fromUrl url =
    Parser.parse parser <| normalizeUrl url
