open Hashtbl
open Ast

(* TODO  : TESTS *)

(* Table des symboles hiérarchique *)
(* Les tables locales sont codées à l'aide d'une hashtable *)
type tdd = (string, AstTds.expression option list) Hashtbl.t

(* creerTDD : () -> tdd *)
(* Créer une TDD vide *)
let creerTDD () = Hashtbl.create 100

(* ajouterTdd : tdd -> string -> AstTds.expression option list -> () *)
(* Paramètre tdd : la tdd *)
(* Paramètre nom : identifiant de la fonction *)
(* Paramètre info : la liste des options d'expressions par défauts *)
(* Enregistre l'identifiant de la fonction dans la TDD et y associe la liste des valeurs par défauts
   de ses paramètres *)
let ajouterTdd tdd nom info = Hashtbl.add tdd nom info

(* chercherTdd : tdd -> string -> AstTds.expressio option list *)
(* Paramètre tdd : la tdd *)
(* Paramètre nom : l'identifiant de la fonction *)
(* Recherche dans la TDD la liste des valeurs par défauts associé à une fonction *)
let chercherTdd (tdd : tdd) (nom : string) =
  match find_opt tdd nom with
  | None -> failwith "erreur interne 13"
  | Some e -> e
