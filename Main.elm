module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random exposing (..)
import V2 exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    Set Int


initModel : Model
initModel =
    fromList [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )


type Msg
    = InsertRandom
    | Insert Int
    | RotateLeft
    | RotateRight


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InsertRandom ->
            ( model, Random.generate Insert (Random.int 1 100) )

        Insert item ->
            ( insert item model, Cmd.none )

        RotateLeft ->
            ( rotl model, Cmd.none )

        RotateRight ->
            ( rotr model, Cmd.none )


renderTree : Model -> Html Msg
renderTree model =
    case model of
        Empty ->
            div [ style [ ( "flex", "1" ), ( "text-align", "center" ) ] ] [ text "" ]

        Tree _ head left right ->
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
        , button [ onClick RotateLeft ] [ text "Rotate left" ]
        , button [ onClick RotateRight ] [ text "Rotate right" ]
        , renderTree model
        ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
