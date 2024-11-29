(* Module de la passe de gestion des identifiants *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast

type t1 = Ast.AstPlacement.programme
type t2 = string

let analyse_code_expression (e : AstPlacement.expression) = 
    match e with
    | AppelFonction (info, le) -> failwith "TODO"
    | Ident info -> failwith "TODO"
    | Booleen b -> failwith "TODO"
    | Entier i -> failwith "TODO"
    | Unaire (op, exp) -> failwith "TODO"
    | Binaire (op, e1, e2) -> failwith "TODO"

let rec analyse_code_instruction (i : AstPlacement.instruction) = 
    match i with
    | Declaration (info, exp) -> failwith "TODO"
    | Affectation (info, exp) -> failwith "TODO"
    | AffichageInt exp -> failwith "TODO"
    | AffichageRat exp -> failwith "TODO"
    | AffichageBool exp -> failwith "TODO"
    | Conditionnelle (exp, b1, b2) -> failwith "TODO"
    | TantQue (exp, bloc) -> failwith "TODO"
    | Retour (exp, retSize, paramSize) -> failwith "TODO"
    | Empty -> ""

and analyse_code_bloc (li, taille) = 
    let sli = List.fold_left (fun acc i -> acc ^ "\n" ^ (analyse_code_instruction i)) "" li in 
    (* code de nettoyage de bloc *)
    sli

let analyse_code_fonction (AstPlacement.Fonction (info, parInfol, bloc)) : t2 = failwith "TODO"

let analyser (AstPlacement.Programme (fonctions, prog)) = 
    let funsStr = List.fold_left (fun acc f -> acc ^ " " ^ (analyse_code_fonction f)) "" fonctions in 
    let blocStr = analyse_code_bloc prog in 
    funsStr ^ "\n" ^ blocStr ^ "\n" ^ "HALT"