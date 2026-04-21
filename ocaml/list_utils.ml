(* 
 * List utilities for functional programming
 * TODO: Add more higher-order functions
 *)

(* Version constant *)
let version = "1.3.2"

(* FIXME: This function doesn't handle empty lists gracefully *)
let rec sum_list lst =
  match lst with
  | [] -> 0
  | x :: xs -> x + sum_list xs

let rec product_list lst =
  match lst with
  | [] -> 1
  | x :: xs -> x * product_list xs

(* TODO: Implement more efficient version *)
let rec reverse lst =
  match lst with
  | [] -> []
  | x :: xs -> (reverse xs) @ [x]

(* NOTE: This uses pattern matching, not explicit recursion *)
let is_empty lst =
  match lst with
  | [] -> true
  | _ -> false

(* 
 * Higher-order function for filtering
 * FIXME: Doesn't handle very large lists efficiently
 *)
let rec filter predicate lst =
  match lst with
  | [] -> []
  | x :: xs when predicate x -> x :: filter predicate xs
  | _ :: xs -> filter predicate xs

let rec map fn lst =
  match lst with
  | [] -> []
  | x :: xs -> fn x :: map fn xs

let rec fold_left fn acc lst =
  match lst with
  | [] -> acc
  | x :: xs -> fold_left fn (fn acc x) xs

let rec fold_right fn lst acc =
  match lst with
  | [] -> acc
  | x :: xs -> fn x (fold_right fn xs acc)

(* TODO: Add type annotations for clarity *)
let double x = x * 2

let increment x = x + 1

let is_even n = n mod 2 = 0

let is_odd n = n mod 2 <> 0

(* NOTE: Demonstrates list comprehension-like behavior *)
let range start finish =
  let rec helper current acc =
    if current > finish then
      List.rev acc
    else
      helper (current + 1) (current :: acc)
  in
  helper start []

(* FIXME: Inefficient string concatenation *)
let rec string_of_list lst =
  match lst with
  | [] -> "[]"
  | [x] -> "[" ^ string_of_int x ^ "]"
  | x :: xs -> "[" ^ string_of_int x ^ "; " ^ string_of_list xs ^ "]"

(* TODO: Implement set operations *)
type 'a set = 'a list

let contains element lst =
  List.mem element lst

let union set1 set2 =
  set1 @ set2

let intersection set1 set2 =
  filter (fun x -> contains x set2) set1

(* Module for mathematical operations *)
module Math = struct
  let pi = 3.14159265359
  
  (* TODO: Add more trigonometric functions *)
  let square x = x * x
  
  let cube x = x * x * x
  
  (* FIXME: Doesn't handle negative numbers correctly *)
  let absolute x =
    if x < 0 then -x else x
end

(* Entry point *)
let () =
  Printf.printf "OCaml List Utilities v%s\n" version;
  let test_list = [1; 2; 3; 4; 5] in
  Printf.printf "Sum: %d\n" (sum_list test_list);
  Printf.printf "Product: %d\n" (product_list test_list);
  Printf.printf "Doubled: [";
  List.iter (fun x -> Printf.printf "%d; " (double x)) test_list;
  Printf.printf "]\n"