open Rat
open Compilateur
open Exceptions

exception ErreurNonDetectee

(****************************************)
(** Chemin d'accès aux fichiers de test *)
(****************************************)

let pathFichiersRat = "../../../../../tests/type/sans_fonction/fichiersRat/"

(**********)
(*  TESTS *)
(**********)

let%test_unit "testDeclaration1" =
  let _ = compiler (pathFichiersRat ^ "testDeclaration1.rat") in
  ()

let%test_unit "testDeclaration2" =
  let _ = compiler (pathFichiersRat ^ "testDeclaration2.rat") in
  ()

let%test_unit "testDeclaration3" =
  let _ = compiler (pathFichiersRat ^ "testDeclaration3.rat") in
  ()

let%test_unit "testDeclaration4" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration4.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Bool, Int) -> ()

let%test_unit "testDeclaration5" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration5.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Bool, Rat) -> ()

let%test_unit "testDeclaration6" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration6.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Bool) -> ()

let%test_unit "testDeclaration7" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration7.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Rat) -> ()

let%test_unit "testDeclaration8" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration8.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Int) -> ()

let%test_unit "testDeclaration9" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration9.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Bool) -> ()

let%test_unit "testDeclaration10" =
  let _ = compiler (pathFichiersRat ^ "testDeclaration10.rat") in
  ()

let%test_unit "testDeclaration11" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration11.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Bool, Int) -> ()

let%test_unit "testDeclaration12" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration12.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Int) -> ()

let%test_unit "testDeclaration13" =
  let _ = compiler (pathFichiersRat ^ "testDeclaration13.rat") in
  ()

let%test_unit "testDeclaration14" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration14.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Bool, Pointeur Int) -> ()

let%test_unit "testDeclaration15" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration15.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Rat, Pointeur Int) -> ()

let%test_unit "testDeclaration16" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration16.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur (Pointeur Int), Pointeur Int) -> ()

let%test_unit "testDeclaration17" =
  let _ = compiler (pathFichiersRat ^ "testDeclaration17.rat") in
  ()

let%test_unit "testDeclaration18" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration18.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Int, Pointeur Bool) -> ()

let%test_unit "testDeclaration19" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration19.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Rat, Pointeur Bool) -> ()

let%test_unit "testDeclaration20" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration20.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur (Pointeur Bool), Pointeur Bool) -> ()

let%test_unit "testDeclaration21" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration21.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Int, Int) -> ()

let%test_unit "testDeclaration22" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration22.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Int, Bool) -> ()

let%test_unit "testDeclaration23" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration23.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Int, Rat) -> ()

let%test_unit "testDeclaration24" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration24.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Undefined, Bool) -> ()

let%test_unit "testDeclaration25" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration25.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Undefined, Int) -> ()

let%test_unit "testDeclaration26" =
  try
    let _ = compiler (pathFichiersRat ^ "testDeclaration26.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Undefined, Rat) -> ()

let%test_unit "testDeclaration27" =
  let _ = compiler (pathFichiersRat ^ "testDeclaration27.rat") in
  ()

let%test_unit "testDeclaration28" =
  let _ = compiler (pathFichiersRat ^ "testDeclaration28.rat") in
  ()

let%test_unit "testDeclaration29" =
  let _ = compiler (pathFichiersRat ^ "testDeclaration29.rat") in
  ()

let%test_unit "testDeclaration30" =
  let _ = compiler (pathFichiersRat ^ "testDeclaration30.rat") in
  ()

let%test_unit "testAffectation1" =
  let _ = compiler (pathFichiersRat ^ "testAffectation1.rat") in
  ()

let%test_unit "testAffectation2" =
  let _ = compiler (pathFichiersRat ^ "testAffectation2.rat") in
  ()

let%test_unit "testAffectation3" =
  let _ = compiler (pathFichiersRat ^ "testAffectation3.rat") in
  ()

let%test_unit "testAffectation4" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation4.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Rat) -> ()

let%test_unit "testAffectation5" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation5.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Bool, Int) -> ()

let%test_unit "testAffectation6" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation6.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Bool, Rat) -> ()

let%test_unit "testAffectation7" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation7.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Int) -> ()

let%test_unit "testAffectation8" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation8.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Bool) -> ()

let%test_unit "testAffectation9" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation9.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Bool) -> ()

let%test_unit "testAffectation14" =
  let _ = compiler (pathFichiersRat ^ "testAffectation14.rat") in
  ()

let%test_unit "testAffectation15" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation15.rat") in
    ()
  with TypeInattendu (Bool, Int) -> ()

let%test_unit "testAffectation16" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation16.rat") in
    ()
  with TypeInattendu (Rat, Int) -> ()

let%test_unit "testAffectation17" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation17.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Pointeur Int) -> ()

let%test_unit "testAffectation18" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation18.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Pointeur Bool) -> ()

let%test_unit "testAffectation19" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation19.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Pointeur Rat) -> ()

let%test_unit "testAffectation20" =
  let _ = compiler (pathFichiersRat ^ "testAffectation20.rat") in
  ()

let%test_unit "testAffectation21" =
  let _ = compiler (pathFichiersRat ^ "testAffectation21.rat") in
  ()

let%test_unit "testAffectation22" =
  let _ = compiler (pathFichiersRat ^ "testAffectation22.rat") in
  ()

let%test_unit "testAffectation23" =
  let _ = compiler (pathFichiersRat ^ "testAffectation23.rat") in
  ()

let%test_unit "testAffectation24" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation24.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Int, Int) -> ()

let%test_unit "testAffectation25" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation25.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Bool, Int) -> ()

let%test_unit "testAffectation26" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation26.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Rat, Int) -> ()

let%test_unit "testAffectation27" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation27.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Int, Bool) -> ()

let%test_unit "testAffectation28" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation28.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Bool, Bool) -> ()

let%test_unit "testAffectation29" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation29.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Rat, Bool) -> ()

let%test_unit "testAffectation30" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation30.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Int, Rat) -> ()

let%test_unit "testAffectation31" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation31.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Bool, Rat) -> ()

let%test_unit "testAffectation32" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation32.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Rat, Rat) -> ()

let%test_unit "testAffectation33" =
  let _ = compiler (pathFichiersRat ^ "testAffectation33.rat") in
  ()

let%test_unit "testAffectation34" =
  let _ = compiler (pathFichiersRat ^ "testAffectation34.rat") in
  ()

let%test_unit "testAffectation35" =
  let _ = compiler (pathFichiersRat ^ "testAffectation35.rat") in
  ()

let%test_unit "testAffectation36" =
  let _ = compiler (pathFichiersRat ^ "testAffectation36.rat") in
  ()

let%test_unit "testAffectation37" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation37.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Undefined, Int) -> ()

let%test_unit "testAffectation38" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation38.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Undefined, Bool) -> ()

let%test_unit "testAffectation39" =
  try
    let _ = compiler (pathFichiersRat ^ "testAffectation39.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Undefined, Rat) -> ()

let%test_unit "testConditionnelle1" =
  let _ = compiler (pathFichiersRat ^ "testConditionnelle1.rat") in
  ()

let%test_unit "testConditionnelle2" =
  try
    let _ = compiler (pathFichiersRat ^ "testConditionnelle2.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Bool) -> ()

let%test_unit "testConditionnelle3" =
  try
    let _ = compiler (pathFichiersRat ^ "testConditionnelle3.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Bool) -> ()

let%test_unit "testConditionnelle4" =
  let _ = compiler (pathFichiersRat ^ "testConditionnelle4.rat") in
  ()

let%test_unit "testConditionnelle5" =
  try
    let _ = compiler (pathFichiersRat ^ "testConditionnelle5.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Bool) -> ()

let%test_unit "testConditionnelle6" =
  try
    let _ = compiler (pathFichiersRat ^ "testConditionnelle6.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Bool) -> ()

let%test_unit "testConditionnelle7" =
  let _ = compiler (pathFichiersRat ^ "testConditionnelle7.rat") in
  ()

let%test_unit "testConditionnelle8" =
  try
    let _ = compiler (pathFichiersRat ^ "testConditionnelle8.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Bool) -> ()

let%test_unit "testConditionnelle9" =
  try
    let _ = compiler (pathFichiersRat ^ "testConditionnelle9.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Bool) -> ()

let%test_unit "testConditionnelle10" =
  try
    let _ = compiler (pathFichiersRat ^ "testConditionnelle10.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Int, Bool) -> ()

let%test_unit "testConditionnelle11" =
  try
    let _ = compiler (pathFichiersRat ^ "testConditionnelle11.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Bool, Bool) -> ()

let%test_unit "testConditionnelle12" =
  try
    let _ = compiler (pathFichiersRat ^ "testConditionnelle12.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Rat, Bool) -> ()

let%test_unit "testConditionnelle13" =
  try
    let _ = compiler (pathFichiersRat ^ "testConditionnelle13.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur (Pointeur Rat), Bool) -> ()

let%test_unit "testRepetition1" =
  let _ = compiler (pathFichiersRat ^ "testRepetition1.rat") in
  ()

let%test_unit "testRepetition2" =
  try
    let _ = compiler (pathFichiersRat ^ "testRepetition2.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Bool) -> ()

let%test_unit "testRepetition3" =
  try
    let _ = compiler (pathFichiersRat ^ "testRepetition3.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Bool) -> ()

let%test_unit "testRepetition4" =
  let _ = compiler (pathFichiersRat ^ "testRepetition4.rat") in
  ()

let%test_unit "testRepetition5" =
  try
    let _ = compiler (pathFichiersRat ^ "testRepetition5.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Bool) -> ()

let%test_unit "testRepetition6" =
  try
    let _ = compiler (pathFichiersRat ^ "testRepetition6.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Bool) -> ()

let%test_unit "testRepetition7" =
  try
    let _ = compiler (pathFichiersRat ^ "testRepetition7.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Bool) -> ()

let%test_unit "testRepetition8" =
  try
    let _ = compiler (pathFichiersRat ^ "testRepetition8.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Bool) -> ()

let%test_unit "testRepetition9" =
  let _ = compiler (pathFichiersRat ^ "testRepetition9.rat") in
  ()

let%test_unit "testRepetition10" =
  try
    let _ = compiler (pathFichiersRat ^ "testRepetition10.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur _, Bool) -> ()

let%test_unit "testPrint1" =
  let _ = compiler (pathFichiersRat ^ "testPrint1.rat") in
  ()

let%test_unit "testPrint2" =
  let _ = compiler (pathFichiersRat ^ "testPrint2.rat") in
  ()

let%test_unit "testPrint3" =
  let _ = compiler (pathFichiersRat ^ "testPrint3.rat") in
  ()

let%test_unit "testPrint4" =
  try
    let _ = compiler (pathFichiersRat ^ "testPrint4.rat") in
    raise ErreurNonDetectee
  with AffichageTypeNonSupporte -> ()

let%test_unit "testRationnel1" =
  let _ = compiler (pathFichiersRat ^ "testRationnel1.rat") in
  ()

let%test_unit "testRationnel2" =
  let _ = compiler (pathFichiersRat ^ "testRationnel2.rat") in
  ()

let%test_unit "testRationnel3" =
  try
    let _ = compiler (pathFichiersRat ^ "testRationnel3.rat") in
    raise ErreurNonDetectee
  with TypeBinaireInattendu (_, Int, Rat) -> ()

let%test_unit "testRationnel4" =
  try
    let _ = compiler (pathFichiersRat ^ "testRationnel4.rat") in
    raise ErreurNonDetectee
  with TypeBinaireInattendu (_, Bool, Int) -> ()

let%test_unit "testRationnel5" =
  try
    let _ = compiler (pathFichiersRat ^ "testRationnel5.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Int) -> ()

let%test_unit "testRationnel6" =
  try
    let _ = compiler (pathFichiersRat ^ "testRationnel6.rat") in
    raise ErreurNonDetectee
  with TypeBinaireInattendu (_, Pointeur Int, Int) -> ()

let%test_unit "testNumerateur1" =
  let _ = compiler (pathFichiersRat ^ "testNumerateur1.rat") in
  ()

let%test_unit "testNumerateur2" =
  let _ = compiler (pathFichiersRat ^ "testNumerateur2.rat") in
  ()

let%test_unit "testNumerateur3" =
  try
    let _ = compiler (pathFichiersRat ^ "testNumerateur3.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Bool, Rat) -> ()

let%test_unit "testNumerateur4" =
  try
    let _ = compiler (pathFichiersRat ^ "testNumerateur4.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Rat) -> ()

let%test_unit "testNumerateur5" =
  try
    let _ = compiler (pathFichiersRat ^ "testNumerateur5.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Bool) -> ()

let%test_unit "testNumerateur6" =
  try
    let _ = compiler (pathFichiersRat ^ "testNumerateur6.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Pointeur Int) -> ()

let%test_unit "testNumerateur7" =
  try
    let _ = compiler (pathFichiersRat ^ "testNumerateur7.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur _, Rat) -> ()

let%test_unit "testDenominateur1" =
  let _ = compiler (pathFichiersRat ^ "testDenominateur1.rat") in
  ()

let%test_unit "testDenominateur2" =
  let _ = compiler (pathFichiersRat ^ "testDenominateur2.rat") in
  ()

let%test_unit "testDenominateur3" =
  try
    let _ = compiler (pathFichiersRat ^ "testDenominateur3.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Bool, Rat) -> ()

let%test_unit "testDenominateur4" =
  try
    let _ = compiler (pathFichiersRat ^ "testDenominateur4.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Rat) -> ()

let%test_unit "testDenominateur5" =
  try
    let _ = compiler (pathFichiersRat ^ "testDenominateur5.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Bool) -> ()

let%test_unit "testDenominateur6" =
  try
    let _ = compiler (pathFichiersRat ^ "testDenominateur6.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Pointeur Int) -> ()

let%test_unit "testDenominateur7" =
  try
    let _ = compiler (pathFichiersRat ^ "testDenominateur7.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Bool, Rat) -> ()

let%test_unit "testIdent1" =
  let _ = compiler (pathFichiersRat ^ "testIdent1.rat") in
  ()

let%test_unit "testIdent2" =
  let _ = compiler (pathFichiersRat ^ "testIdent2.rat") in
  ()

let%test_unit "testIdent3" =
  let _ = compiler (pathFichiersRat ^ "testIdent3.rat") in
  ()

let%test_unit "testIdent4" =
  try
    let _ = compiler (pathFichiersRat ^ "testIdent4.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Int) -> ()

let%test_unit "testIdent5" =
  try
    let _ = compiler (pathFichiersRat ^ "testIdent5.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Bool) -> ()

let%test_unit "testIdent6" =
  try
    let _ = compiler (pathFichiersRat ^ "testIdent6.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Bool) -> ()

let%test_unit "testIdent7" =
  try
    let _ = compiler (pathFichiersRat ^ "testIdent7.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Rat) -> ()

let%test_unit "testIdent8" =
  try
    let _ = compiler (pathFichiersRat ^ "testIdent8.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Bool, Rat) -> ()

let%test_unit "testIdent9" =
  try
    let _ = compiler (pathFichiersRat ^ "testIdent9.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Bool, Int) -> ()

let%test_unit "testIdent10" =
  try
    let _ = compiler (pathFichiersRat ^ "testIdent10.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Bool, Int) -> ()

let%test_unit "testIdent11" =
  try
    let _ = compiler (pathFichiersRat ^ "testIdent11.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Int) -> ()

let%test_unit "testIdent12" =
  let _ = compiler (pathFichiersRat ^ "testIdent12.rat") in
  ()

let%test_unit "testIdent13" =
  let _ = compiler (pathFichiersRat ^ "testIdent13.rat") in
  ()

let%test_unit "testIdent14" =
  try
    let _ = compiler (pathFichiersRat ^ "testIdent14.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Bool, Pointeur Int) -> ()

let%test_unit "testIdent15" =
  try
    let _ = compiler (pathFichiersRat ^ "testIdent15.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Pointeur Rat, Pointeur Int) -> ()

let%test_unit "testDerefL1" =
  let _ = compiler (pathFichiersRat ^ "testDerefL1.rat") in
  ()

let%test_unit "testDerefL2" =
  try
    let _ = compiler (pathFichiersRat ^ "testDerefL2.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Bool) -> ()

let%test_unit "testDerefL3" =
  try
    let _ = compiler (pathFichiersRat ^ "testDerefL3.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Int, Rat) -> ()

let%test_unit "testDerefE1" =
  let _ = compiler (pathFichiersRat ^ "testDerefE1.rat") in
  ()

let%test_unit "testDerefE2" =
  try
    let _ = compiler (pathFichiersRat ^ "testDerefE2.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Bool, Int) -> ()

let%test_unit "testDerefE3" =
  try
    let _ = compiler (pathFichiersRat ^ "testDerefE3.rat") in
    raise ErreurNonDetectee
  with TypeInattendu (Rat, Int) -> ()

let%test_unit "testOperation1" =
  let _ = compiler (pathFichiersRat ^ "testOperation1.rat") in
  ()

let%test_unit "testOperation2" =
  let _ = compiler (pathFichiersRat ^ "testOperation2.rat") in
  ()

let%test_unit "testOperation3" =
  try
    let _ = compiler (pathFichiersRat ^ "testOperation3.rat") in
    raise ErreurNonDetectee
  with TypeBinaireInattendu (Plus, Bool, Bool) -> ()

let%test_unit "testOperation4" =
  try
    let _ = compiler (pathFichiersRat ^ "testOperation4.rat") in
    raise ErreurNonDetectee
  with TypeBinaireInattendu (Equ, Rat, Rat) -> ()

let%test_unit "testOperation5" =
  let _ = compiler (pathFichiersRat ^ "testOperation5.rat") in
  ()

let%test_unit "testOperation6" =
  let _ = compiler (pathFichiersRat ^ "testOperation6.rat") in
  ()

let%test_unit "testOperation7" =
  let _ = compiler (pathFichiersRat ^ "testOperation7.rat") in
  ()

let%test_unit "testOperation8" =
  let _ = compiler (pathFichiersRat ^ "testOperation8.rat") in
  ()

let%test_unit "testOperation9" =
  try
    let _ = compiler (pathFichiersRat ^ "testOperation9.rat") in
    raise ErreurNonDetectee
  with TypeBinaireInattendu (Mult, Bool, Bool) -> ()

let%test_unit "testOperation10" =
  try
    let _ = compiler (pathFichiersRat ^ "testOperation10.rat") in
    raise ErreurNonDetectee
  with TypeBinaireInattendu (Inf, Rat, Rat) -> ()

let%test_unit "testOperation11" =
  try
    let _ = compiler (pathFichiersRat ^ "testOperation11.rat") in
    raise ErreurNonDetectee
  with TypeBinaireInattendu (Inf, Bool, Bool) -> ()

let%test_unit "testOperation12" =
  let _ = compiler (pathFichiersRat ^ "testOperation12.rat") in
  ()

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
