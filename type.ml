type typ = Bool | Int | Rat | Pointeur of typ | Undefined

let rec string_of_type t =
  match t with
  | Bool -> "Bool"
  | Int -> "Int"
  | Rat -> "Rat"
  | Pointeur st -> "Pointeur de " ^ string_of_type st
  | Undefined -> "Undefined"

let est_compatible t1 t2 =
  match (t1, t2) with
  | Bool, Bool -> true
  | Int, Int -> true
  | Rat, Rat -> true
  | Pointeur _, Pointeur Undefined -> true
  | Pointeur Undefined, Pointeur _ -> true
  | Pointeur a, Pointeur b -> a = b
  | _ -> false

let%test _ = est_compatible Bool Bool
let%test _ = est_compatible Int Int
let%test _ = est_compatible Rat Rat
let%test _ = est_compatible (Pointeur Int) (Pointeur Int)
let%test _ = est_compatible (Pointeur Bool) (Pointeur Bool)
let%test _ = est_compatible (Pointeur Rat) (Pointeur Rat)
let%test _ = est_compatible (Pointeur Int) (Pointeur Undefined)
let%test _ = est_compatible (Pointeur Rat) (Pointeur Undefined)
let%test _ = est_compatible (Pointeur Bool) (Pointeur Undefined)
let%test _ = est_compatible (Pointeur Undefined) (Pointeur Int)
let%test _ = est_compatible (Pointeur Undefined) (Pointeur Rat)
let%test _ = est_compatible (Pointeur Undefined) (Pointeur Bool)
let%test _ = not (est_compatible Int Bool)
let%test _ = not (est_compatible Bool Int)
let%test _ = not (est_compatible Int Rat)
let%test _ = not (est_compatible Rat Int)
let%test _ = not (est_compatible Bool Rat)
let%test _ = not (est_compatible Rat Bool)
let%test _ = not (est_compatible Undefined Int)
let%test _ = not (est_compatible Int Undefined)
let%test _ = not (est_compatible Rat Undefined)
let%test _ = not (est_compatible Bool Undefined)
let%test _ = not (est_compatible Undefined Int)
let%test _ = not (est_compatible Undefined Rat)
let%test _ = not (est_compatible Undefined Bool)
let%test _ = not (est_compatible (Pointeur Int) (Pointeur Rat))
let%test _ = not (est_compatible (Pointeur Int) (Pointeur Bool))
let%test _ = not (est_compatible (Pointeur Bool) (Pointeur Int))
let%test _ = not (est_compatible (Pointeur Bool) (Pointeur Rat))
let%test _ = not (est_compatible (Pointeur Rat) (Pointeur Int))
let%test _ = not (est_compatible (Pointeur Rat) (Pointeur Bool))
let%test _ = not (est_compatible (Pointeur Int) Undefined)
let%test _ = not (est_compatible (Pointeur Rat) Undefined)
let%test _ = not (est_compatible (Pointeur Bool) Undefined)

let est_compatible_list lt1 lt2 =
  try List.for_all2 est_compatible lt1 lt2 with Invalid_argument _ -> false

let%test _ = est_compatible_list [] []
let%test _ = est_compatible_list [ Int; Rat ] [ Int; Rat ]
let%test _ = est_compatible_list [ Bool; Rat; Bool ] [ Bool; Rat; Bool ]
let%test _ = not (est_compatible_list [ Int ] [ Int; Rat ])
let%test _ = not (est_compatible_list [ Int ] [ Rat; Int ])
let%test _ = not (est_compatible_list [ Int; Rat ] [ Rat; Int ])

let%test _ =
  not (est_compatible_list [ Bool; Rat; Bool ] [ Bool; Rat; Bool; Int ])

let getTaille t =
  match t with
  | Int -> 1
  | Bool -> 1
  | Rat -> 2
  | Pointeur _ -> 1
  | Undefined -> 0

let%test _ = getTaille Int = 1
let%test _ = getTaille Bool = 1
let%test _ = getTaille Rat = 2
