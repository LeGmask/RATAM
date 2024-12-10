(* Module de la passe de gestion des identifiants *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast
open Utils
open Tdd

type t1 = Ast.AstSyntax.programme
type t2 = Ast.AstTds.programme

(* analyse_tds_affectable -> tds -> AstSyntax.affectable *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre a : l'affectable à traiter *)
(* TODO DOC *)
let rec analyse_tds_affectable tds a en_ecriture =
  match a with
  | AstSyntax.Dereference a ->
      let na = analyse_tds_affectable tds a en_ecriture in
      AstTds.Dereference na
  | AstSyntax.Ident id -> (
      match chercherGlobalement tds id with
      | None -> raise (IdentifiantNonDeclare id)
      | Some ia -> (
          match !ia with
          | InfoFun _ -> raise (MauvaiseUtilisationIdentifiant id)
          | InfoVar _ -> AstTds.Ident ia
          | InfoConst (n, v) ->
              if en_ecriture then raise (MauvaiseUtilisationIdentifiant id)
              else AstTds.Ident ia))

(* analyse_tds_var : tds -> AstSyntax.var -> AstTds.var ?? *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre v : la variable globale à analyser *)
(* TODO DOC + commentaires *)
let rec analyse_tds_globale tds tdd (AstSyntax.Globale (t, n, e)) =
  match chercherGlobalement tds n with
  | None ->
      (* L'identifiant n'est pas trouvé dans la tds locale,
          il n'a donc pas encore été utilisé par une variable globale *)
      (* Vérification de la bonne utilisation des identifiants dans l'expression *)
      (* et obtention de l'expression transformée *)
      let ne = analyse_tds_expression tds tdd e in
      (* Création de l'information associée à l'identfiant *)
      let info = InfoVar (n, Undefined, 0, "") in
      (* Création du pointeur sur l'information *)
      let ia = ref info in
      (* Ajout de l'information (pointeur) dans la tds *)
      ajouter tds n ia;
      (* Renvoie de la nouvelle déclaration où le nom a été remplacé par l'information
          et l'expression remplacée par l'expression issue de l'analyse *)
      AstTds.Globale (t, ia, ne)
  | Some _ ->
      (* L'identifiant est trouvé dans la tds locale,
          il a donc déjà été déclaré dans le bloc courant *)
      raise (DoubleDeclaration n)

(* analyse_tds_expression : tds -> tdd -> AstSyntax.expression -> AstTds.expression *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre tdd : la table des défauts *)
(* Paramètre e : l'expression à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'expression
   en une expression de type AstTds.expression *)
(* Erreur si mauvaise utilisation des identifiants *)
and analyse_tds_expression (tds : tds) (tdd : tdd) (e : AstSyntax.expression) :
    AstTds.expression =
  match e with
  | AstSyntax.AppelFonction (id, le) -> (
      (* on recherche l'identidiant de la fonction *)
      match chercherGlobalement tds id with
      | None ->
          (* l'identifiant n'est pas déclaré *)
          raise (IdentifiantNonDeclare id)
      | Some info_ast -> (
          match !info_ast with
          | InfoFun _ ->
              (* traitement des paramètres ayant une valeur non par défaut *)
              let lne =
                List.map (fun e -> analyse_tds_expression tds tdd e) le
              in
              (* on recherche la liste des valeurs par défauts dans la tdd *)
              let defle = chercherTdd tdd id in

              (* on fusionne les expressions fournies avec celles par défauts*)
              let finalLne = mergeOptions lne defle in
              AstTds.AppelFonction (info_ast, finalLne)
          | _ ->
              (* l'identifiant existe mais ne correspond à une fonction *)
              raise (MauvaiseUtilisationIdentifiant id)))
  | AstSyntax.Affectable a -> (
      (* récupération de l'identifiant dans l'affectable *)
      let na = analyse_tds_affectable tds a false in
      match na with
      | AstTds.Ident ia -> (
          match !ia with
          | InfoConst (_, v) -> AstTds.Entier v
          | _ -> AstTds.Affectable na)
      | _ -> AstTds.Affectable na)
  | AstSyntax.Binaire (b, e1, e2) ->
      (*obtention de l'expression transformée*)
      let ne1 = analyse_tds_expression tds tdd e1 in
      (*obtention de l'expression transformée*)
      let ne2 = analyse_tds_expression tds tdd e2 in
      AstTds.Binaire (b, ne1, ne2)
  | AstSyntax.Unaire (op, e1) ->
      (*obtention de l'expression transformée*)
      let ne1 = analyse_tds_expression tds tdd e1 in
      AstTds.Unaire (op, ne1)
  | AstSyntax.Booleen b -> AstTds.Booleen b
  | AstSyntax.Entier i -> AstTds.Entier i
  | AstSyntax.PointeurNul -> AstTds.PointeurNul
  | AstSyntax.Nouveau t -> AstTds.Nouveau t
  | AstSyntax.Adresse n -> (
      match chercherGlobalement tds n with
      | None -> raise (IdentifiantNonDeclare n)
      | Some info -> (
          match !info with
          | InfoVar _ -> AstTds.Adresse info
          | _ -> raise (MauvaiseUtilisationIdentifiant n)))

(* analyse_tds_instruction : tds -> info_ast option -> AstSyntax.instruction -> AstTds.instruction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si l'instruction i est dans le bloc principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est l'instruction i sinon *)
(* Paramètre i : l'instruction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'instruction
   en une instruction de type AstTds.instruction *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_instruction tds tdd oia i =
  match i with
  | AstSyntax.Declaration (t, n, e) -> (
      match chercherLocalement tds n with
      | None ->
          (* L'identifiant n'est pas trouvé dans la tds locale,
             il n'a donc pas été déclaré dans le bloc courant *)
          (* Vérification de la bonne utilisation des identifiants dans l'expression *)
          (* et obtention de l'expression transformée *)
          let ne = analyse_tds_expression tds tdd e in
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
  | AstSyntax.StatiqueLocale (t, n, e) -> (
      (* On récupère l'information associée à la fonction dans laquelle on déclare *)
      match oia with
      (* Il n'y a pas d'information -> l'instruction est hors d'une fonction : erreur *)
      | None -> raise (VariableLocaleStatiqueHorsFonction n)
      (* Il y a une information -> l'instruction est dans une fonction *)
      | Some ia ->
          (* Analyse de l'expression *)
          let ne = analyse_tds_expression tds tdd e in
          (* Création de l'information associée à l'identfiant *)
          let info = InfoVar (n, Undefined, 0, "") in
          (* Création du pointeur sur l'information *)
          let info_ast = ref info in
          (* Ajout de l'information (pointeur) dans la tds *)
          ajouter tds n info_ast;
          AstTds.StatiqueLocale (t, info_ast, ne))
  | AstSyntax.Affectation (a, e) ->
      let na = analyse_tds_affectable tds a true in
      let ne = analyse_tds_expression tds tdd e in
      AstTds.Affectation (na, ne)
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
      let ne = analyse_tds_expression tds tdd e in
      (* Renvoie du nouvel affichage où l'expression remplacée par l'expression issue de l'analyse *)
      AstTds.Affichage ne
  | AstSyntax.Conditionnelle (c, t, e) ->
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds tdd c in
      (* Analyse du bloc then *)
      let tast = analyse_tds_bloc tds tdd oia t in
      (* Analyse du bloc else *)
      let east = analyse_tds_bloc tds tdd oia e in
      (* Renvoie la nouvelle structure de la conditionnelle *)
      AstTds.Conditionnelle (nc, tast, east)
  | AstSyntax.TantQue (c, b) ->
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds tdd c in
      (* Analyse du bloc *)
      let bast = analyse_tds_bloc tds tdd oia b in
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
          let ne = analyse_tds_expression tds tdd e in
          AstTds.Retour (ne, ia))

(* analyse_tds_bloc : tds -> info_ast option -> AstSyntax.bloc -> AstTds.bloc *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si le bloc li est dans le programme principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est le bloc li sinon *)
(* Paramètre li : liste d'instructions à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le bloc en un bloc de type AstTds.bloc *)
(* Erreur si mauvaise utilisation des identifiants *)
and analyse_tds_bloc tds tdd oia li =
  (* Entrée dans un nouveau bloc, donc création d'une nouvelle tds locale
     pointant sur la table du bloc parent *)
  let tdsbloc = creerTDSFille tds in
  (* Analyse des instructions du bloc avec la tds du nouveau bloc.
     Cette tds est modifiée par effet de bord *)
  let nli = List.map (analyse_tds_instruction tdsbloc tdd oia) li in
  (* afficher_locale tdsbloc ; *)
  (* décommenter pour afficher la table locale *)
  nli

(* analyse_tds_fonction : tds -> AstSyntax.fonction -> AstTds.fonction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre : la fonction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme la fonction
   en une fonction de type AstTds.fonction *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyse_tds_fonction maintds tdd (AstSyntax.Fonction (t, n, lp, li)) =
  match chercherGlobalement maintds n with
  | Some _ ->
      (* l'identifiant existe déjà => duplication*)
      raise (DoubleDeclaration n)
  | None ->
      (* On crée une tds pour la fonction a partir de la main tds **)
      let tdsFunc = creerTDSFille maintds in
      (* On extrait les types des paramètres a partir de la liste des paramètres*)
      let typesArgsList = List.map (fun (typ, _, _) -> typ) lp in
      (* On extrait les noms des paramètres a partir de la liste des paramètres*)
      let nomArgsList = List.map (fun (_, nom, _) -> nom) lp in
      (* On extrait les valeurs par défaut *)
      let defOpts = List.map (fun (_, _, e) -> e) lp in

      (* Fonction auxiliaire pour vérifier que la liste des expressions par défaut est bien formée *)
      (* check : expression option list -> bool -> bool *)
      (* Paramètre : el : liste d'option d'expressions *)
      (* Paramètre excepted : booléen indique si on s'attend à avoir une expression par défaut *)
      let rec check el excepted =
        match el with
        | [] ->
            () (* si on a atteint la fin de la liste c'est que tout est bon *)
        | Some e :: te ->
            (* si on s'attendait à avoir une valeur par défaut et que c'est le cas, alors on continue *)
            (* ou alors on a une valeur par défaut alors qu'on ne s'y attendais pas; il s'agit de la première *)
            (* on s'attend donc à ce qu'il y en ait jusqu'à la fin de la liste *)
            check te true
        | None :: te ->
            if excepted then
              (*si on s'attendais à avoir une valeur par défaut et qu'il n'y en a pas ERREUR *)
              failwith
                "TODO : add exceptions pour paramètre par défaut pas qu'en fin"
            else
              (* on n'a pas encore trouvé de valeur par défaut, on continue *)
              check te excepted
      in
      check defOpts false;

      (* Si on est encore vivant c'est que la liste des valeurs par défaut est bien formée *)

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

      (* traitement des expressions des valeurs par défaut *)
      let rec processDefaults expList =
        match expList with
        | [] -> []
        | None :: te -> None :: processDefaults te
        | Some e :: te ->
            Some (analyse_tds_expression maintds tdd e) :: processDefaults te
      in
      let lne = processDefaults defOpts in

      (* les expressions des valeurs par défaut ont été traitées l'association entre les éventuels id/affectables ayant déjà été fait
         on enregsitre ces expressions dans la TDD. Ainsi, elles pouront être injecté lorsque nécessaire
         dans les expressions AppelFonction de fonction *)
      ajouterTdd tdd n lne;

      (* Ajout de la fonction a la main tds *)
      let infoFun_ast = ref (InfoFun (n, t, typesArgsList)) in
      ajouter maintds n infoFun_ast;

      (* traitement des arguments de la fonction *)
      let typInfoList = List.map2 ajouterParam typesArgsList nomArgsList in

      (* Processing du body de la fonction *)
      (* A partir de la tds des paramètres on crée une seconde tds pour le body de la fonction*)
      let funBodyTds = creerTDSFille tdsFunc in

      (* On analyse le blody de la fonction*)
      let funBloc = analyse_tds_bloc funBodyTds tdd (Some infoFun_ast) li in
      (* on renvoit la fonction *)
      AstTds.Fonction (t, infoFun_ast, typInfoList, funBloc)

(* analyser : AstSyntax.programme -> AstTds.programme *)
(* Paramètre : le programme à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le programme
   en un programme de type AstTds.programme *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyser (AstSyntax.Programme (globales, fonctions, prog)) =
  let tds = creerTDSMere () in
  let tdd = creerTDD () in
  let ng = List.map (analyse_tds_globale tds tdd) globales in
  let nf = List.map (analyse_tds_fonction tds tdd) fonctions in
  let nb = analyse_tds_bloc tds tdd None prog in
  AstTds.Programme (ng, nf, nb)
