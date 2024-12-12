(* split ('a * 'b) list -> ('a list * 'b list )*)
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

(* mergeOptions : 'a list -> 'a option list -> 'a list *)
(* Paramètre l1 : la liste des expressions explicites des paramètres *)
(* Paramètre l2 : la liste des options d'expressions par défauts des paramètres *)
(* Réalise la fusion entre les expressions explicitement fournies lors d'un appel de fonction
   et la liste des options des expressions par défaut de la fonction *)
let rec mergeOptions l1 l2 =
  match (l1, l2) with
  | e :: q1, _ :: q2 ->
      e :: mergeOptions q1 q2
      (* on préfère la valeur explicitement fournie à celle par défaut *)
  | [], Some e :: q2 ->
      e
      :: mergeOptions []
           q2 (* on utilise la valeur par défaut si pas de valeur explicite *)
  | [], None :: _ ->
      []
      (* ce cas correspond à une erreur de programmation (pas assez de paramètre & pas de valeur par défaut pour les paramètres manquants)*)
  | _, [] -> l1
(* ce cas correspond à une erreur de programmation (plus de paramètre explicitements fournies que demandé)*)
