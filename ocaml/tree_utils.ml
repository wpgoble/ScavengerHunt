(*
 * Binary Search Tree implementation
 * TODO: Add balancing for AVL tree
 *)

(* Tree data structure *)
type 'a tree =
  | Empty
  | Node of 'a * 'a tree * 'a tree

(* Version *)
let tree_version = "2.0.1"

(* Basic tree operations *)
let rec insert value tree =
  match tree with
  | Empty -> Node (value, Empty, Empty)
  | Node (x, left, right) ->
      if value < x then
        Node (x, insert value left, right)
      else if value > x then
        Node (x, left, insert value right)
      else
        tree

let rec search target tree =
  match tree with
  | Empty -> false
  | Node (x, left, right) ->
      if target = x then true
      else if target < x then search target left
      else search target right

(* TODO: Implement in-order traversal *)
let rec in_order tree =
  match tree with
  | Empty -> []
  | Node (x, left, right) ->
      (in_order left) @ [x] @ (in_order right)

(* Pre-order traversal *)
let rec pre_order tree =
  match tree with
  | Empty -> []
  | Node (x, left, right) ->
      x :: (pre_order left) @ (pre_order right)

(* Post-order traversal *)
let rec post_order tree =
  match tree with
  | Empty -> []
  | Node (x, left, right) ->
      (post_order left) @ (post_order right) @ [x]

(* FIXME: This doesn't handle unbalanced trees efficiently *)
let rec height tree =
  match tree with
  | Empty -> 0
  | Node (_, left, right) ->
      1 + max (height left) (height right)

(* Count nodes *)
let rec count_nodes tree =
  match tree with
  | Empty -> 0
  | Node (_, left, right) ->
      1 + count_nodes left + count_nodes right

(* NOTE: Recursive tree deletion *)
let rec delete value tree =
  match tree with
  | Empty -> Empty
  | Node (x, left, right) ->
      if value < x then
        Node (x, delete value left, right)
      else if value > x then
        Node (x, left, delete value right)
      else
        match (left, right) with
        | (Empty, Empty) -> Empty
        | (Empty, r) -> r
        | (l, Empty) -> l
        | (l, r) ->
            let rec find_min tree =
              match tree with
              | Empty -> raise (Failure "Empty tree")
              | Node (x, Empty, _) -> x
              | Node (_, l, _) -> find_min l
            in
            let min_val = find_min r in
            Node (min_val, l, delete min_val r)

(* TODO: Add tree validation *)
let is_valid_bst tree =
  let rec check min_val max_val tree =
    match tree with
    | Empty -> true
    | Node (x, left, right) ->
        x > min_val && x < max_val &&
        check min_val x left &&
        check x max_val right
  in
  check Int.min_int Int.max_int tree

(* Print tree structure *)
let rec string_of_tree tree =
  match tree with
  | Empty -> "."
  | Node (x, left, right) ->
      "(" ^ string_of_tree left ^ " " ^ 
      string_of_int x ^ " " ^ 
      string_of_tree right ^ ")"

(* FIXME: Mirror operation not fully tested *)
let rec mirror tree =
  match tree with
  | Empty -> Empty
  | Node (x, left, right) ->
      Node (x, mirror right, mirror left)

(* Test the tree *)
let () =
  Printf.printf "OCaml Binary Tree v%s\n" tree_version;
  let tree = Empty in
  let tree = insert 5 tree in
  let tree = insert 3 tree in
  let tree = insert 7 tree in
  let tree = insert 2 tree in
  let tree = insert 4 tree in
  Printf.printf "Tree: %s\n" (string_of_tree tree);
  Printf.printf "Height: %d\n" (height tree);
  Printf.printf "Nodes: %d\n" (count_nodes tree);
  Printf.printf "In-order: ";
  List.iter (Printf.printf "%d ") (in_order tree);
  Printf.printf "\n"