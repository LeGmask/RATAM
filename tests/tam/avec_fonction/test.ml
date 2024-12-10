open Rat
open Compilateur

(* Changer le chemin d'accès du jar. *)
let runtamcmde = "java -jar ../../../../../tests/runtam.jar"
(* let runtamcmde = "java -jar /mnt/n7fs/.../tools/runtam/runtam.jar" *)

(* Execute the TAM code obtained from the rat file and return the ouptut of this code *)
let runtamcode cmde ratfile =
  let tamcode = compiler ratfile in
  let tamfile, chan = Filename.open_temp_file "test" ".tam" in
  output_string chan tamcode;
  close_out chan;
  let ic = Unix.open_process_in (cmde ^ " " ^ tamfile) in
  let printed = input_line ic in
  close_in ic;
  Sys.remove tamfile;
  (* à commenter si on veut étudier le code TAM. *)
  String.trim printed

(* Compile and run ratfile, then print its output *)
let runtam ratfile = print_string (runtamcode runtamcmde ratfile)

(****************************************)
(** Chemin d'accès aux fichiers de test *)
(****************************************)

let pathFichiersRat = "../../../../../tests/tam/avec_fonction/fichiersRat/"

(**********)
(*  TESTS *)
(**********)

(* requires ppx_expect in jbuild, and `opam install ppx_expect` *)
let%expect_test "testfun1" =
  runtam (pathFichiersRat ^ "testfun1.rat");
  [%expect {| 1 |}]

let%expect_test "testfun2" =
  runtam (pathFichiersRat ^ "testfun2.rat");
  [%expect {| 7 |}]

let%expect_test "testfun3" =
  runtam (pathFichiersRat ^ "testfun3.rat");
  [%expect {| 10 |}]

let%expect_test "testfun4" =
  runtam (pathFichiersRat ^ "testfun4.rat");
  [%expect {| 10 |}]

let%expect_test "testfun5" =
  runtam (pathFichiersRat ^ "testfun5.rat");
  [%expect {| |}]

let%expect_test "testfun6" =
  runtam (pathFichiersRat ^ "testfun6.rat");
  [%expect {|truetrue|}]

let%expect_test "testfun8" =
  runtam (pathFichiersRat ^ "testfun8.rat");
  [%expect {| 15 |}]

let%expect_test "testfun9" =
  runtam (pathFichiersRat ^ "testfun9.rat");
  [%expect {| 1234 |}]

let%expect_test "testfun10" =
  runtam (pathFichiersRat ^ "testfun10.rat");
  [%expect {| 5116 |}]

let%expect_test "testfun11" =
  runtam (pathFichiersRat ^ "testfun11.rat");
  [%expect {| 5 |}]

let%expect_test "testfun12" =
  runtam (pathFichiersRat ^ "testfun12.rat");
  [%expect {| 1111151033 |}]

let%expect_test "testfuns" =
  runtam (pathFichiersRat ^ "testfuns.rat");
  [%expect {| 28 |}]

let%expect_test "factrec" =
  runtam (pathFichiersRat ^ "factrec.rat");
  [%expect {| 120 |}]
