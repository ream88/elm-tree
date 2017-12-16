module V2 exposing (..)


type Set comparable
    = Empty
    | Tree Int comparable (Set comparable) (Set comparable)


empty : Set comparable
empty =
    Empty


tree : comparable -> Set comparable -> Set comparable -> Set comparable
tree head left right =
    let
        newHeight =
            max (height left) (height right) + 1
    in
        Tree newHeight head left right


singleton : comparable -> Set comparable
singleton item =
    tree item empty empty


insert : comparable -> Set comparable -> Set comparable
insert item set =
    case set of
        Empty ->
            singleton item

        Tree _ head left right ->
            if item < head then
                tree head (insert item left) right
            else if item > head then
                tree head left (insert item right)
            else
                set


rotl : Set comparable -> Set comparable
rotl set =
    case set of
        Tree _ head smaller (Tree _ newHead between greater) ->
            tree newHead (tree head smaller between) greater

        _ ->
            set


rotr : Set comparable -> Set comparable
rotr set =
    case set of
        Tree _ head (Tree _ newHead smaller between) greater ->
            tree newHead smaller (tree head between greater)

        _ ->
            set


fromList : List comparable -> Set comparable
fromList list =
    List.foldl insert empty list


height : Set comparable -> Int
height set =
    case set of
        Empty ->
            0

        Tree height _ _ _ ->
            height
