open Type
open Ast.AstSyntax

(* Exceptions pour la gestion des identificateurs *)
exception DoubleDeclaration of string
exception IdentifiantNonDeclare of string
exception MauvaiseUtilisationIdentifiant of string

(* Exceptions pour le typage *)
(* Le premier type est le type réel, le second est le type attendu *)
exception TypeInattendu of typ * typ
exception TypesParametresInattendus of typ list * typ list
exception TypeBinaireInattendu of binaire * typ * typ
(* les types sont les types réels non compatible avec les signatures connues de l'opérateur *)

(* Utilisation illégale de return dans le programme principal *)
exception RetourDansMain

(* Déclaration illégale de variables statiques locales hors d'une fonction *)
exception VariableLocaleStatiqueHorsFonction of string

(* Déréférencement d'un variable autre qu'un pointeur *)
exception DerefereceNonPointeur

(* Affichage d'un type non supporté *)
exception AffichageTypeNonSupporte
exception ValeurParametresDefautsDesordonnees of string
