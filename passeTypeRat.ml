(* Module de la passe de gestion des identifiants *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast
open Type
open Utils

type t1 = Ast.AstTds.programme
type t2 = Ast.AstType.programme

(* analyse_type_expression : AstTds.expression -> AstType.expression *)
(* Paramètre e : l'expression à analyser *)
(* Vérifie le bon typage de l'expression et tranforme l'expression
   en une expression de type AstType.expression couplé à son type *)
(* Erreur si mauvais typage *)
let rec analyse_type_expression e =
  match e with
  | AstTds.AppelFonction (info, le) -> (
      match !info with
      | InfoFun (_, typ, argstyp) ->
          (* analyse des expressions et récupérations de leurs types *)
          (* lne = liste des nouvelles expressions après analyse *)
          (* lte = liste des types des expressions après analyse *)
          let lne, lte = map_couple analyse_type_expression le in
          if est_compatible_list lte argstyp then
            (AstType.AppelFonction (info, lne), typ)
          else raise (TypesParametresInattendus (lte, argstyp))
      | _ -> failwith "erreur interne")
  | AstTds.Ident info -> (
      match !info with
      | InfoVar (_, typ, _, _) -> (AstType.Ident info, typ)
      | _ -> failwith "erreur interne")
  | AstTds.Unaire (op, e1) -> (
      let ne1, te1 = analyse_type_expression e1 in
      match te1 with
      | Rat ->
          let nop =
            match op with
            | Numerateur -> AstType.Numerateur
            | Denominateur -> AstType.Denominateur
          in
          (AstType.Unaire (nop, ne1), Int)
      | _ -> raise (TypeInattendu (te1, Rat)))
  | AstTds.Binaire (op, e1, e2) -> (
      let ne1, te1 = analyse_type_expression e1 in
      let ne2, te2 = analyse_type_expression e2 in
      match (op, te1, te2) with
      | Plus, Int, Int -> (AstType.Binaire (PlusInt, ne1, ne2), Int)
      | Plus, Rat, Rat -> (AstType.Binaire (PlusRat, ne1, ne2), Rat)
      | Mult, Int, Int -> (AstType.Binaire (MultInt, ne1, ne2), Int)
      | Mult, Rat, Rat -> (AstType.Binaire (MultRat, ne1, ne2), Rat)
      | Fraction, Int, Int -> (AstType.Binaire (Fraction, ne1, ne2), Rat)
      | Equ, Int, Int -> (AstType.Binaire (EquInt, ne1, ne2), Bool)
      | Equ, Bool, Bool -> (AstType.Binaire (EquBool, ne1, ne2), Bool)
      | Inf, Int, Int -> (AstType.Binaire (Inf, ne1, ne2), Bool)
      | _ -> raise (TypeBinaireInattendu (op, te1, te2)))
  | AstTds.Booleen b -> (AstType.Booleen b, Bool)
  | AstTds.Entier i -> (AstType.Entier i, Int)

(* analyse_type_instruction : AstTds.instruction -> AstType.instruction *)
(* Paramètre i : l'instruction à analyser *)
(* Vérifie le bon typage de l'instruction et tranforme l'instruction en une instruction de type AstType.instruction *)
(* Erreur si mauvais typage de l'expression *)
let rec analyse_type_instruction i =
  match i with
  | AstTds.Declaration (t, info, e) -> (
      (* traitement de l'expression *)
      let ne, netyp = analyse_type_expression e in
      if netyp <> t then
        (* les types sont imcompatibles *)
        raise (TypeInattendu (netyp, t))
      else
        (* les types sont compatibles *)
        (* ajout de l'information de type dans l'info_ast *)
        match !info with
        | InfoVar _ ->
            modifier_type_variable t info;
            AstType.Declaration (info, ne)
        | _ -> failwith "erreur interne")
  | AstTds.Affectation (info, e) -> (
      let ne, netyp = analyse_type_expression e in
      match !info with
      | InfoVar (_, typ, _, _) ->
          if typ = netyp then AstType.Affectation (info, ne)
          else raise (TypeInattendu (netyp, typ))
      | _ -> failwith "erreur interne"
      (* on compare t et tid, si différents alors erreur *)
      (* AstType.Affectation(i,ne) *))
  | AstTds.Affichage e -> (
      let ne, netyp = analyse_type_expression e in
      match netyp with
      | Int -> AstType.AffichageInt ne
      | Bool -> AstType.AffichageBool ne
      | Rat -> AstType.AffichageRat ne
      | _ -> failwith "erreur interne" (*car ne devrait pas être possible *))
  | AstTds.Conditionnelle (c, t, e) ->
      let nc, nctyp = analyse_type_expression c in
      if nctyp = Bool then
        let nbt = analyse_type_bloc t in
        let nbe = analyse_type_bloc e in
        AstType.Conditionnelle (nc, nbt, nbe)
      else raise (TypeInattendu (nctyp, Bool))
  | AstTds.TantQue (c, b) ->
      let nc, nctyp = analyse_type_expression c in
      if nctyp = Bool then AstType.TantQue (nc, analyse_type_bloc b)
      else raise (TypeInattendu (nctyp, Bool))
  | AstTds.Retour (e, ia) -> (
      let ne, netyp = analyse_type_expression e in
      match !ia with
      | InfoFun (_, typret, _) ->
          if typret <> netyp then raise (TypeInattendu (netyp, typret))
          else AstType.Retour (ne, ia)
      | _ -> failwith "erreur interne")
  | AstTds.Empty -> AstType.Empty

(* analyse_type_bloc : AstTds.bloc -> AstType.bloc *)
(* Paramètre li : liste d'instructions à analyser *)
(* Vérifie le bon typage et transforme le bloc en un bloc de type AstType.bloc *)
(* Erreur si types imcompatibles *)
and analyse_type_bloc li = List.map analyse_type_instruction li

(* analyse_type_fonction : AstTds.fonction -> AstType.fonction *)
(* Paramètre : la fonction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme la fonction
   en une fonction de type AstType.fonction *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyse_type_fonction (AstTds.Fonction (t, info, lp, li)) =
  (* récupérations des types et les infos des paramètres de la fonction *)
  let typeList, infosList = split lp in
  (* ajouter les types des paramètres dans leurs info_asts*)
  List.iter2 modifier_type_variable typeList infosList;
  (* ajouter t et [t1;...;tn] à i *)
  modifier_type_fonction t typeList info;
  (* analyse de li -> mli *)
  let nli = analyse_type_bloc li in
  AstType.Fonction (info, infosList, nli)

(* analyse_type_fonctions -> AstTds.fonction list -> AstType.fonction list *)
(* Paramètre lf : la liste des fonctions à analyser *)
(* Analyse les fonctions d'une liste de AstTds.fonction, et les transforme en une liste de AstTye.fonction *)
let analyse_type_fonctions lf = List.map analyse_type_fonction lf

(* analyser : AstTds.programme -> AstType.programme *)
(* Paramètre : le programme à analyser *)
(* Vérifie le bon typage et transforme le programme en un programme de type AstType.programme *)
(* Erreur si types imcompatibles *)
let analyser (AstTds.Programme (fonctions, prog)) =
  let nfs = analyse_type_fonctions fonctions in
  let np = analyse_type_bloc prog in
  AstType.Programme (nfs, np)
