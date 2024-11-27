open Ast


(* Trouve l'identifiant dans un affectable *)
(* Paramètre sa : affectable *)
(* Renvoit l'identifiant*)
let rec trouver_id_racine (sa : AstSyntax.affectable) =
  match sa with 
  | Ident n -> n 
  | Dereference ssa -> trouver_id_racine ssa

  
  (* récupération de l'identifiant de l'affectable *)(* split ('a * 'b) list -> ('a list * 'b list )*)
(* Paramètre cl : la liste à traiter *)
(* Sépare une liste de couple en couple de liste *)
(* Conserve l'ordre des éléments *)
let split cl =
  List.fold_right (fun (a, b) (qa, qb) -> (a :: qa, b :: qb)) cl ([], [])

(* split 'c list -> (c' -> 'a * 'b) -> ('a list * 'b list )*)
(* Paramètre proc : le traitement à appliquer *)
(* Paramètre elems : la liste à traiter *)
(* Applique un traitement à une liste d'élements et renvoit un couple de
   liste contenant *)
(* Conserve l'ordre des éléments *)
let map_couple proc elems =
  List.fold_right
    (fun e (qa, qb) ->
      let a, b = proc e in
      (a :: qa, b :: qb))
    elems ([], [])
