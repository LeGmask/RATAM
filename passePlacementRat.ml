(* Module de la passe de placement mémoire *)
(* doit être conforme à l'interface Passe *)
open Tds
open Ast
open Type

type t1 = Ast.AstType.programme
type t2 = Ast.AstPlacement.programme

(* analyse_placement_instruction : AstType.instruction -> int -> string -> int -> (AstPlacement.instruction * int * int) *)
(* Paramètre i : l'instruction à analyser *)
(* Paramètre depl : le déplacement par rapport au début du registre *)
(* Paramètre reg : le registre *)
(* Paramètre d : le déplacement par rapport à SB causé par les variables statiques locales *)
(* Détermine la taille d'une instruction et la transforme en une AstPlacement.instruction *)
let rec analyse_placement_instruction i depl reg d =
  match i with
  | AstType.Declaration (info, e) -> (
      match !info with
      | InfoVar (_, typ, _, _) ->
          let taille = getTaille typ in
          modifier_adresse_variable depl reg info;
          (AstPlacement.Declaration (info, e), taille, 0)
      | _ ->
          failwith "erreur interne: analyse_placement_instruction@Declaration")
  | AstType.StatiqueLocale (info, e) -> (
      match !info with
      | InfoVar (_, typ, _, _) ->
          let taille = getTaille typ in
          modifier_adresse_variable d "SB" info;
          (AstPlacement.StatiqueLocale (info, e), 0, taille + getTaille Bool)
      | _ ->
          failwith
            "erreur interne: analyse_placement_instruction@StatiqueLocale")
  | AstType.Affectation (aff, e) -> (AstPlacement.Affectation (aff, e), 0, 0)
  | AstType.AffichageInt e -> (AstPlacement.AffichageInt e, 0, 0)
  | AstType.AffichageRat e -> (AstPlacement.AffichageRat e, 0, 0)
  | AstType.AffichageBool e -> (AstPlacement.AffichageBool e, 0, 0)
  | AstType.Conditionnelle (c, t, e) ->
      let nbt, delta = analyse_placement_bloc t depl reg d in
      let nbe, delta = analyse_placement_bloc e depl reg (d + delta) in
      (AstPlacement.Conditionnelle (c, nbt, nbe), 0, delta)
  | AstType.TantQue (c, b) ->
      let nb, delta = analyse_placement_bloc b depl reg d in
      (AstPlacement.TantQue (c, nb), 0, delta)
  | AstType.Retour (e, ia) -> (
      match !ia with
      | InfoFun (_, typret, argstyp) ->
          let tr = getTaille typret in
          let tp =
            List.fold_right (fun typ acc -> acc + getTaille typ) argstyp 0
          in
          (AstPlacement.Retour (e, tr, tp), 0, 0)
      | _ -> failwith "erreur interne: analyse_placement_instruction@Retour")
  | AstType.Empty -> (AstPlacement.Empty, 0, 0)

(* analyse_placement_bloc : AstType.bloc -> int -> string -> int -> (AstPlacement.bloc * int) *)
(* Paramètre li : liste d'instructions à analyser *)
(* Paramètre depml : déplacement au début du bloc *)
(* Paramètre reg : le registre mémoire *)
(* Paramètre d : le déplacement par rapport à SB causé par les variables statiques locales *)
(* Détermine la taille mémoire du bloc et
   le transforme en un AstPlacement.bloc *)
and analyse_placement_bloc li depml reg d =
  match li with
  | [] -> (([], 0), d)
  | i :: q ->
      let ni, ti, di = analyse_placement_instruction i depml reg d in
      let (nli, tb), db = analyse_placement_bloc q (depml + ti) reg (d + di) in
      ((ni :: nli, ti + tb), di + db)

(* analyse_placement_fonction : AstType.fonction -> AstPlacement.fonction *)
(* Paramètre : la fonction à analyser *)
(* Paramètre d : le déplacement par rapport à SB causé par les variables statiques locales *)
(* Place en mémoire les paramètres d'une fonction et
   la transforme en une AstPlacement.fonction *)
let analyse_placement_fonction (AstType.Fonction (info, lp, li)) d =
  (* get_taille_param : Tds.info_ast -> int *)
  (* Paramètre p : info_ast *)
  (* Retourne la taille d'un paramètre de Fonction *)
  let get_taille_param p =
    match !p with
    | InfoVar (_, typ, _, _) -> getTaille typ
    | _ -> failwith "erreur interne: analyse_placement_fonction"
  in

  (* Fonction auxiliaire de màj des adresse mémoire des paramètres d'une fonction *)
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
  let nb, delta = analyse_placement_bloc li 3 "LB" d in
  (AstPlacement.Fonction (info, lp, nb), delta)

(* analyse_placement_globale : AstType.globale -> int -> (AstPlacement.globale * int) *)
(* Paramètre  : la variable globale *)
(* Paramtère depl : déplacement par rapport au registre SB *)
(* Détermine la taille d'une variable globale, effectue le placement mémoire
   et la transforme en une AstPlacement.globale *)
let analyse_placement_globale (AstType.Globale (info, exp)) depl =
  match !info with
  | InfoVar (_, typ, _, _) ->
      let taille = getTaille typ in
      modifier_adresse_variable depl "SB" info;
      (AstPlacement.Globale (info, exp), taille)
  | _ -> failwith "erreur interne : analyse_placement_globale pas InfoVar"

(* analyser : AstType.programme -> AstPlacement.programme *)
(* Paramètre : le programme à analyser *)
(* Effectue le placement mémoire et transforme le programme
   en un programme de type AstPlacement.programme *)
(* Erreur si bug dans passes précédantes *)
let analyser (AstType.Programme (globales, fonctions, prog)) =
  let offset, ng =
    List.fold_left_map
      (fun depl g ->
        let ng, delta = analyse_placement_globale g depl in
        (depl + delta, ng))
      0 globales
  in
  let delta, nfs =
    List.fold_left_map
      (fun d fonction ->
        let nf, delta = analyse_placement_fonction fonction d in
        (d + delta, nf))
      offset fonctions
  in
  (* 0 car normalement il n'y a pas de déclaration de variable statique locales en dehors des fonctions
     ce qui a déjà été vérifié lors de la phase de gestion_id *)
  let np, _ = analyse_placement_bloc prog delta "SB" 0 in
  AstPlacement.Programme (ng, nfs, np, delta)
