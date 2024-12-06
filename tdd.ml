open Hashtbl
open Ast

(* TODO : tests & commentaires *)

(* Table des symboles hiérarchique *)
(* Les tables locales sont codées à l'aide d'une hashtable *)
type tdd = (string, AstTds.expression option list) Hashtbl.t

let creerTDD () = Hashtbl.create 100
let ajouterTdd tdd nom info = Hashtbl.add tdd nom info

let chercherTdd (tdd : tdd) (nom : string) =
  match find_opt tdd nom with
  | None -> failwith "erreur interne 13"
  | Some e -> e
