open Rat
open Compilateur
open Exceptions

exception ErreurNonDetectee

(****************************************)
(** Chemin d'accès aux fichiers de test *)
(****************************************)

let pathFichiersRat =
  "../../../../../tests/gestion_id/sans_fonction/fichiersRat/"

(**********)
(*  TESTS *)
(**********)

let%test_unit "testAffectation1" =
  let _ = compiler (pathFichiersRat ^ "testAffectation1.rat") in
  ()

let%test_unit "testAffectation2" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation2.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "y" -> ()

let%test_unit "testAffectation3" =
  let _ = compiler (pathFichiersRat ^ "testAffectation3.rat") in
  ()

let%test_unit "testAffectation4" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation4.rat") in
    raise ErreurNonDetectee
  with MauvaiseUtilisationIdentifiant "x" -> ()

let%test_unit "testAffectation5" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation5.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "y" -> ()

let%test_unit "testUtilisation1" =
  let _ = compiler (pathFichiersRat ^ "testUtilisation1.rat") in
  ()

let%test_unit "testUtilisation2" =
  let _ = compiler (pathFichiersRat ^ "testUtilisation2.rat") in
  ()

let%test_unit "testUtilisation3" =
  try
    let _ = compiler (pathFichiersRat ^ "testUtilisation3.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "y" -> ()

let%test_unit "testUtilisation10" =
  try
    let _ = compiler (pathFichiersRat ^ "testUtilisation10.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "x" -> ()

let%test_unit "testUtilisation11" =
  try
    let _ = compiler (pathFichiersRat ^ "testUtilisation11.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "z" -> ()

let%test_unit "testUtilisation12" =
  try
    let _ = compiler (pathFichiersRat ^ "testUtilisation12.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "z" -> ()

let%test_unit "testUtilisation13" =
  try
    let _ = compiler (pathFichiersRat ^ "testUtilisation13.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "z" -> ()

let%test_unit "testUtilisation14" =
  try
    let _ = compiler (pathFichiersRat ^ "testUtilisation14.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "z" -> ()

let%test_unit "testUtilisation15" =
  try
    let _ = compiler (pathFichiersRat ^ "testUtilisation15.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "z" -> ()

let%test_unit "testUtilisation16" =
  try
    let _ = compiler (pathFichiersRat ^ "testUtilisation16.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "y" -> ()

let%test_unit "testUtilisation17" =
  try
    let _ = compiler (pathFichiersRat ^ "testUtilisation17.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "y" -> ()

let%test_unit "testUtilisation18" =
  try
    let _ = compiler (pathFichiersRat ^ "testUtilisation18.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "y" -> ()

let%test_unit "testUtilisation19" =
  try
    let _ = compiler (pathFichiersRat ^ "testUtilisation19.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "y" -> ()

let%test_unit "testUtilisation20" =
  try
    let _ = compiler (pathFichiersRat ^ "testUtilisation20.rat") in
    raise ErreurNonDetectee
  with VariableLocaleStatiqueHorsFonction "id" -> ()

let%test_unit "testRecursiviteVariable" =
  try
    let _ = compiler (pathFichiersRat ^ "testRecursiviteVariable.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "x" -> ()

let%test_unit "testGlobales1" =
  let _ = compiler (pathFichiersRat ^ "testGlobales1.rat") in
  ()

let%test_unit "testGlobales2" =
  try
    let _ = compiler (pathFichiersRat ^ "testGlobales2.rat") in
    raise ErreurNonDetectee
  with VariableLocaleStatiqueHorsFonction "x" -> ()

let%test_unit "testGlobales3" =
  try
    let _ = compiler (pathFichiersRat ^ "testGlobales3.rat") in
    raise ErreurNonDetectee
  with DoubleDeclaration "x" -> ()

let%test_unit "testDerefLecture1" =
  try
    let _ = compiler (pathFichiersRat ^ "testDerefLecture1.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "y" -> ()

let%test_unit "testDerefLecture2" =
  let _ = compiler (pathFichiersRat ^ "testDerefLecture2.rat") in
  ()

let%test_unit "testDerefEcriture1" =
  try
    let _ = compiler (pathFichiersRat ^ "testDerefEcriture1.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "y" -> ()

let%test_unit "testDerefEcriture2" =
  let _ = compiler (pathFichiersRat ^ "testDerefEcriture2.rat") in
  ()

let%test_unit "testReference2" =
  try
    let _ = compiler (pathFichiersRat ^ "testReference2.rat") in
    raise ErreurNonDetectee
  with IdentifiantNonDeclare "y" -> ()

let%test_unit "testReference1" =
  let _ = compiler (pathFichiersRat ^ "testReference1.rat") in
  ()

let%test_unit "testDerefNonPointeur1" =
  try
    let _ = compiler (pathFichiersRat ^ "testDerefNonPointeur1.rat") in
    raise ErreurNonDetectee
  with DerefereceNonPointeur -> ()

let%test_unit "testDerefNonPointeur2" =
  try
    let _ = compiler (pathFichiersRat ^ "testDerefNonPointeur2.rat") in
    raise ErreurNonDetectee
  with DerefereceNonPointeur -> ()

let%test_unit "testDerefNonPointeur3" =
  try
    let _ = compiler (pathFichiersRat ^ "testDerefNonPointeur3.rat") in
    raise ErreurNonDetectee
  with DerefereceNonPointeur -> ()

(* Fichiers de tests de la génération de code -> doivent passer la TDS *)
open Unix
open Filename

let rec test d p_tam =
  try
    let file = readdir d in
    if check_suffix file ".rat" then (
      try
        let _ = compiler (p_tam ^ file) in
        ()
      with e ->
        print_string (p_tam ^ file);
        print_newline ();
        raise e)
    else ();
    test d p_tam
  with End_of_file -> ()

let%test_unit "all_tam" =
  let p_tam = "../../../../../tests/tam/sans_fonction/fichiersRat/" in
  let d = opendir p_tam in
  test d p_tam
