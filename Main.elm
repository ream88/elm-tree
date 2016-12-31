module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random exposing (..)
import V1 exposing (..)


type Msg
    = InsertRandom
    | Insert Int



-- model


type alias Model =
    Set Int


model : Model
model =
    fromList [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InsertRandom ->
            ( model, Random.generate Insert (Random.int 1 100) )

        Insert item ->
            ( insert item model, Cmd.none )



-- view


renderTree : Model -> Html a
renderTree model =
    case model of
        Empty ->
            div [ style [ ( "flex", "1" ), ( "text-align", "center" ) ] ] [ text "" ]

        Tree head left right ->
            div [ style [ ( "display", "flex" ), ( "flex", "1" ), ( "flex-direction", "column" ), ( "background-color", "rgba(255, 0, 0, 0.1)" ) ] ]
                [ div [ style [ ( "flex", "1" ), ( "text-align", "center" ) ] ] [ text (toString head) ]
                , div [ style [ ( "display", "flex" ), ( "flex-direction", "row" ), ( "justify-content", "space-between" ) ] ]
                    [ renderTree left
                    , renderTree right
                    ]
                ]


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick InsertRandom ] [ text "Insert" ]
        , renderTree model
        ]



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- main


main : Program Never Model Msg
main =
    Html.program { init = init, update = update, view = view, subscriptions = subscriptions }
