open Ast

(* Table des défauts *)
type tdd

(* Cette table des défaut sert durant la passe d'analyse syntaxique / sémantique
   Elle sert à faire l'association entre un id de fonction et la liste des valeurs par défauts des paramètres.
   Cette table est peuplé lors de l'anaylse d'une fonction et est utilisé lors de l'analyse de l'expression AppelFonction. *)

(* Création d'une table des symboles à la racine *)
val creerTDD : unit -> tdd

(* Ajoute une liste de valeurs par défauts dans la table des défauts *)
(* tdd : la tdd *)
(* string : le nom de la fonction *)
(* info : l'information à associer *)
(* retour : unit *)
val ajouterTdd : tdd -> string -> AstTds.expression option list -> unit

(* Recherche la liste des valeurs par défaut d'une fonction *)
val chercherTdd : tdd -> string -> AstTds.expression option list
