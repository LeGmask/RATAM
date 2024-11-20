(* Module de la passe de gestion des identifiants *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast

type t1 = Ast.AstSyntax.programme
type t2 = Ast.AstTds.programme

(* analyse_tds_expression : tds -> AstSyntax.expression -> AstTds.expression *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre e : l'expression à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'expression
   en une expression de type AstTds.expression *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_expression tds e =
  match e with
  | AstSyntax.AppelFonction (id, le) -> (
      (* on recherche l'identidiant de la fonction *)
      match chercherGlobalement tds id with
      | None ->
          (* l'identifiant n'est pas déclaré *)
          raise (IdentifiantNonDeclare id)
      | Some info_ast -> (
          let info = !info_ast in
          match info with
          | InfoFun _ ->
              let lne = List.map (fun e -> analyse_tds_expression tds e) le in
              AstTds.AppelFonction (info_ast, lne)
          | _ ->
              (* l'identifiant existe mais ne correspond à une fonction *)
              raise (MauvaiseUtilisationIdentifiant id)))
  | AstSyntax.Ident n -> (
      (* On cherche l'identifiant n dans la tds globale.*)
      match chercherGlobalement tds n with
      | None ->
          (* L'identifiant n'est pas trouvé dans la tds globale. *)
          raise (IdentifiantNonDeclare n)
      | Some info_ast -> (
          match !info_ast with
          | InfoVar _ ->
              (* on renvoit la variable trouvée *)
              AstTds.Ident info_ast
          | InfoConst (_, value) ->
              (* on remplace la constante par la valeur *)
              AstTds.Entier value
          | _ -> raise (MauvaiseUtilisationIdentifiant n)))
  | AstSyntax.Binaire (b, e1, e2) ->
      (*obtention de l'expression transformée*)
      let ne1 = analyse_tds_expression tds e1 in
      (*obtention de l'expression transformée*)
      let ne2 = analyse_tds_expression tds e2 in
      AstTds.Binaire (b, ne1, ne2)
  | AstSyntax.Unaire (op, e1) ->
      (*obtention de l'expression transformée*)
      let ne1 = analyse_tds_expression tds e1 in
      AstTds.Unaire (op, ne1)
  | AstSyntax.Booleen b -> AstTds.Booleen b
  | AstSyntax.Entier i -> AstTds.Entier i

(* analyse_tds_instruction : tds -> info_ast option -> AstSyntax.instruction -> AstTds.instruction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si l'instruction i est dans le bloc principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est l'instruction i sinon *)
(* Paramètre i : l'instruction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'instruction
   en une instruction de type AstTds.instruction *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_instruction tds oia i =
  match i with
  | AstSyntax.Declaration (t, n, e) -> (
      match chercherLocalement tds n with
      | None ->
          (* L'identifiant n'est pas trouvé dans la tds locale,
             il n'a donc pas été déclaré dans le bloc courant *)
          (* Vérification de la bonne utilisation des identifiants dans l'expression *)
          (* et obtention de l'expression transformée *)
          let ne = analyse_tds_expression tds e in
          (* Création de l'information associée à l'identfiant *)
          let info = InfoVar (n, Undefined, 0, "") in
          (* Création du pointeur sur l'information *)
          let ia = ref info in
          (* Ajout de l'information (pointeur) dans la tds *)
          ajouter tds n ia;
          (* Renvoie de la nouvelle déclaration où le nom a été remplacé par l'information
             et l'expression remplacée par l'expression issue de l'analyse *)
          AstTds.Declaration (t, ia, ne)
      | Some _ ->
          (* L'identifiant est trouvé dans la tds locale,
             il a donc déjà été déclaré dans le bloc courant *)
          raise (DoubleDeclaration n))
  | AstSyntax.Affectation (n, e) -> (
      match chercherGlobalement tds n with
      | None ->
          (* L'identifiant n'est pas trouvé dans la tds globale. *)
          raise (IdentifiantNonDeclare n)
      | Some info -> (
          (* L'identifiant est trouvé dans la tds globale,
             il a donc déjà été déclaré. L'information associée est récupérée. *)
          match !info with
          | InfoVar _ ->
              (* Vérification de la bonne utilisation des identifiants dans l'expression *)
              (* et obtention de l'expression transformée *)
              let ne = analyse_tds_expression tds e in
              (* Renvoie de la nouvelle affectation où le nom a été remplacé par l'information
                 et l'expression remplacée par l'expression issue de l'analyse *)
              AstTds.Affectation (info, ne)
          | _ ->
              (* Modification d'une constante ou d'une fonction *)
              raise (MauvaiseUtilisationIdentifiant n)))
  | AstSyntax.Constante (n, v) -> (
      match chercherLocalement tds n with
      | None ->
          (* L'identifiant n'est pas trouvé dans la tds locale,
             il n'a donc pas été déclaré dans le bloc courant *)
          (* Ajout dans la tds de la constante *)
          ajouter tds n (ref (InfoConst (n, v)));
          (* Suppression du noeud de déclaration des constantes devenu inutile *)
          AstTds.Empty
      | Some _ ->
          (* L'identifiant est trouvé dans la tds locale,
             il a donc déjà été déclaré dans le bloc courant *)
          raise (DoubleDeclaration n))
  | AstSyntax.Affichage e ->
      (* Vérification de la bonne utilisation des identifiants dans l'expression *)
      (* et obtention de l'expression transformée *)
      let ne = analyse_tds_expression tds e in
      (* Renvoie du nouvel affichage où l'expression remplacée par l'expression issue de l'analyse *)
      AstTds.Affichage ne
  | AstSyntax.Conditionnelle (c, t, e) ->
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds c in
      (* Analyse du bloc then *)
      let tast = analyse_tds_bloc tds oia t in
      (* Analyse du bloc else *)
      let east = analyse_tds_bloc tds oia e in
      (* Renvoie la nouvelle structure de la conditionnelle *)
      AstTds.Conditionnelle (nc, tast, east)
  | AstSyntax.TantQue (c, b) ->
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds c in
      (* Analyse du bloc *)
      let bast = analyse_tds_bloc tds oia b in
      (* Renvoie la nouvelle structure de la boucle *)
      AstTds.TantQue (nc, bast)
  | AstSyntax.Retour e -> (
      (* On récupère l'information associée à la fonction à laquelle le return est associée *)
      match oia with
      (* Il n'y a pas d'information -> l'instruction est dans le bloc principal : erreur *)
      | None ->
          raise RetourDansMain
          (* Il y a une information -> l'instruction est dans une fonction *)
      | Some ia ->
          (* Analyse de l'expression *)
          let ne = analyse_tds_expression tds e in
          AstTds.Retour (ne, ia))

(* analyse_tds_bloc : tds -> info_ast option -> AstSyntax.bloc -> AstTds.bloc *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si le bloc li est dans le programme principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est le bloc li sinon *)
(* Paramètre li : liste d'instructions à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le bloc en un bloc de type AstTds.bloc *)
(* Erreur si mauvaise utilisation des identifiants *)
and analyse_tds_bloc tds oia li =
  (* Entrée dans un nouveau bloc, donc création d'une nouvelle tds locale
     pointant sur la table du bloc parent *)
  let tdsbloc = creerTDSFille tds in
  (* Analyse des instructions du bloc avec la tds du nouveau bloc.
     Cette tds est modifiée par effet de bord *)
  let nli = List.map (analyse_tds_instruction tdsbloc oia) li in
  (* afficher_locale tdsbloc ; *)
  (* décommenter pour afficher la table locale *)
  nli

(* analyse_tds_fonction : tds -> AstSyntax.fonction -> AstTds.fonction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre : la fonction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme la fonction
   en une fonction de type AstTds.fonction *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyse_tds_fonction maintds (AstSyntax.Fonction (t, n, lp, li)) =
  match chercherGlobalement maintds n with
  | Some _ ->
      (* l'identifiant existe déjà => duplication*)
      raise (DoubleDeclaration n)
  | None ->
      (* On crée une tds pour la fonction a partir de la main tds **)
      let tdsFunc = creerTDSFille maintds in
      (* On extrait les types des paramètres a partir de la liste des paramètres*)
      let typesArgsList = List.map (fun (typ, _) -> typ) lp in
      (* On extrait les noms des paramètres a partir de la liste des paramètres*)
      let nomArgsList = List.map (fun (_, nom) -> nom) lp in

      (* Fonction auxilliaire pour rajouter un paramètre *)
      (* paramètre type: le type du paramètre*)
      (* paramètre id: le nom du paramètre*)
      (* renvoit le couple typ * info_ast pour la liste  des paramètre de la fonction **)
      let ajouterParam typ id =
        match chercherLocalement tdsFunc id with
        | Some _ ->
            (* l'identifiant existe déjà => duplication*)
            raise (DoubleDeclaration id)
        | None ->
            (* l'identifian est disponible, on l'ajoute *)
            (* on crée l'info_ast associé au paramètre*)
            let infoVar_ast = ref (InfoVar (id, typ, 0, "")) in
            (* on l'ajoute à la tds *)
            ajouter tdsFunc id infoVar_ast;
            (typ, infoVar_ast)
      in

      (* Ajout de la fonction a la main tds *)
      let infoFun_ast = ref (InfoFun (n, t, typesArgsList)) in
      ajouter maintds n infoFun_ast;

      (* traitement des arguments de la fonction *)
      let typInfoList = List.map2 ajouterParam typesArgsList nomArgsList in

      (* Processing du body de la fonction *)
      (* A partir de la tds des paramètres on crée une seconde tds pour le body de la fonction*)
      let funBodyTds = creerTDSFille tdsFunc in

      (* On analyse le blody de la fonction*)
      let funBloc = analyse_tds_bloc funBodyTds (Some infoFun_ast) li in
      (* on renvoit la fonction *)
      AstTds.Fonction (t, infoFun_ast, typInfoList, funBloc)

(* analyser : AstSyntax.programme -> AstTds.programme *)
(* Paramètre : le programme à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le programme
   en un programme de type AstTds.programme *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyser (AstSyntax.Programme (fonctions, prog)) =
  let tds = creerTDSMere () in
  let nf = List.map (analyse_tds_fonction tds) fonctions in
  let nb = analyse_tds_bloc tds None prog in
  AstTds.Programme (nf, nb)
