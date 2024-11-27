open Ast


(* Trouve l'identifiant dans un affectable *)
(* Paramètre sa : affectable *)
(* Renvoit l'identifiant*)
let rec trouver_id_racine (sa : AstSyntax.affectable) =
  match sa with 
  | Ident n -> n 
  | Dereference ssa -> trouver_id_racine ssa
  (* récupération de l'identifiant de l'affectable *)