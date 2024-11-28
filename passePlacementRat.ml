(* Module de la passe de gestion des identifiants *)
(* doit être conforme à l'interface Passe *)
open Tds
open Ast
open Type

type t1 = Ast.AstType.programme
type t2 = Ast.AstPlacement.programme

(* analyse_placement_instruction : AstType.instruction -> AstPlacement.instruction *)
(* Paramètre i : l'instruction à analyser *)
(* Paramètre depl : le déplacement par rapport au début du registre *)
(* Paramètre reg : le registre *)
(* Détermine la taille d'une instruction et la transforme en une AstPlacement.instruction *)
let rec analyse_placement_instruction i depl reg =
  match i with
  | AstType.Declaration (info, e) -> (
      match !info with
      | InfoVar (_, typ, _, _) ->
          let taille = getTaille typ in
          modifier_adresse_variable depl reg info;
          (AstPlacement.Declaration (info, e), taille)
      | _ -> failwith "erreur interne")
  | AstType.Affectation (info, e) -> (AstPlacement.Affectation (info, e), 0)
  | AstType.AffichageInt e -> (AstPlacement.AffichageInt e, 0)
  | AstType.AffichageRat e -> (AstPlacement.AffichageRat e, 0)
  | AstType.AffichageBool e -> (AstPlacement.AffichageBool e, 0)
  | AstType.Conditionnelle (c, t, e) ->
      let nbt = analyse_placement_bloc t depl reg in
      let nbe = analyse_placement_bloc e depl reg in
      (AstPlacement.Conditionnelle (c, nbt, nbe), 0)
  | AstType.TantQue (c, b) ->
      let nb = analyse_placement_bloc b depl reg in
      (AstPlacement.TantQue (c, nb), 0)
  | AstType.Retour (e, ia) -> (
      match !ia with
      | InfoFun (_, typret, argstyp) ->
          let tr = getTaille typret in
          let tp =
            List.fold_right (fun typ acc -> acc + getTaille typ) argstyp 0
          in
          (AstPlacement.Retour (e, tr, tp), 0)
      | _ -> failwith "erreur interne")
  | AstType.Empty -> (AstPlacement.Empty, 0)

(* analyse_placement_bloc : AstType.bloc -> AstPlacement.bloc *)
(* Paramètre li : liste d'instructions à analyser *)
(* Paramètre depml : déplacement au début du bloc *)
(* Paramètre reg : le registre mémoire *)
(* Détermine la taille mémoire du bloc et
   le transforme en un AstPlacement.bloc *)
and analyse_placement_bloc li depml reg =
  match li with
  | [] -> ([], 0)
  | i :: q ->
      let ni, ti = analyse_placement_instruction i depml reg in
      let nli, tb = analyse_placement_bloc q (depml + ti) reg in
      (ni :: nli, ti + tb)

(* analyse_placement_fonction : AstType.fonction -> AstPlacement.fonction *)
(* Paramètre : la fonction à analyser *)
(* Place en mémoire les paramètres d'une fonction et
   la transforme en une AstPlacement.fonction *)
let analyse_placement_fonction (AstType.Fonction (info, lp, li)) =
  (* get_taille_param : Tds.info_ast -> int*)
  (* Paramètre p  infos_ast *)
  (* Retourne la taille d'un paramètre de Fonction *)
  let get_taille_param p =
    match !p with
    | InfoVar (_, typ, _, _) -> getTaille typ
    | _ -> failwith "erreur interne"
    (* analyse des paramètres *)
  in

  let rec process_params pl =
    match pl with
    | [] -> 0
    | p :: q ->
        let taille = get_taille_param p in
        let depq = process_params q in
        let curDep = depq - taille in
        modifier_adresse_variable curDep "LB" p;
        curDep
  in
  ignore (process_params lp);
  let nb = analyse_placement_bloc li 3 "LB" in
  AstPlacement.Fonction (info, lp, nb)

(* analyser : AstType.programme -> AstPlacement.programme *)
(* Paramètre : le programme à analyser *)
(* Effectue le placement mémoire et transforme le programme
   en un programme de type AstPlacement.programme *)
(* Erreur si bug dans passes précédantes *)
let analyser (AstType.Programme (fonctions, prog)) =
  let nfs = List.map analyse_placement_fonction fonctions in
  let np = analyse_placement_bloc prog 0 "SB" in
  AstPlacement.Programme (nfs, np)
