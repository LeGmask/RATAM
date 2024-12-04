(* Module de la passe de gestion des identifiants *)
(* doit être conforme à l'interface Passe *)
open Tds
open Ast
open Type
open Tam
open Code

type t1 = Ast.AstPlacement.programme
type t2 = string

let rec analyse_code_expression (e : AstPlacement.expression) : string = 
    match e with
    | AppelFonction (info, le) -> (
        let codeExpresssions = List.fold_left (fun acc e -> acc ^(analyse_code_expression e)) "" le in
        match !info with
        | InfoFun(nom, _, _) -> codeExpresssions ^ (call "SB" nom)
        | _ -> failwith "erreur interne")

    | Ident info -> (
        match !info with
        | InfoVar(_, typ, d, reg) -> load (getTaille typ) d reg
        | _ -> failwith "erreur interne")
    | Booleen b -> loadl_int (if b then 1 else 0) 
    | Entier i -> loadl_int i
    | Unaire (op, exp) -> (
        let ce = analyse_code_expression exp in 
        match op with
        | Numerateur -> ce ^ pop 0 1
        | Denominateur -> ce ^ pop 1 1
    )
    | Binaire (op, e1, e2) -> (
        let ce1 = analyse_code_expression e1 in 
        let ce2 = analyse_code_expression e2 in
        match op with
        | PlusInt -> ce1 ^ ce2 ^ subr "IAdd"
        | MultInt -> ce1 ^ ce2 ^ subr "IMul"
        | PlusRat -> ce1 ^ ce2 ^ call "SB" "RAdd"
        | MultRat -> ce1 ^ ce2 ^ call "SB" "RMul"
        | Fraction -> ce1 ^ ce2
        | EquInt -> ce1 ^ ce2 ^ subr "IEq"
        | EquBool -> (* = EXOR = (AND e1 e2) OR (not OR e1 e2)*)
        (* très moche, si ce1/ce2 a des effets de bords ça marche pas. *)
        (* va falloir dupliquer les variables en mémoire ? *)
            ce1 ^ ce2 ^ subr "BAnd" ^ ce1 ^ ce2 ^ subr "BOr" ^ subr "BNeg" ^ subr "BOr"
        | Inf -> ce1 ^ ce2 ^ subr "ILss")

let rec analyse_code_instruction (i : AstPlacement.instruction) = 
    match i with
    | Declaration (info, exp) -> (
        match !info with
        | InfoVar(_, typ, d, reg) ->         
            let ec = analyse_code_expression exp in
            let s = getTaille typ in 
            push s ^ ec ^ store s d reg
        | _ -> failwith "erreur interne")

    | Affectation (info, exp) -> (
        match !info with
        | InfoVar(_, typ, d, reg) ->         
            let ec = analyse_code_expression exp in
            let s = getTaille typ in 
            ec ^ store s d reg
        | _ -> failwith "erreur interne")
    | AffichageInt exp -> 
        let ce = analyse_code_expression exp in 
        ce ^ subr "IOut"
    | AffichageRat exp -> 
        let ce = analyse_code_expression exp in
        ce ^ call "SB" "ROut"
    | AffichageBool exp -> 
        let ce = analyse_code_expression exp in
        ce ^ subr "BOut"
    | Conditionnelle (exp, b1, b2) -> 
        let cc = analyse_code_expression exp in 
        let cb1 = analyse_code_bloc b1 in 
        let cb2 = analyse_code_bloc b2 in
        let labelElse = getEtiquette () in 
        let labelFin = getEtiquette () in
        cc ^ jumpif 0 labelElse ^ cb1 ^ jump labelFin  ^ (label labelElse) ^ cb2 ^ (label labelFin)
    | TantQue (exp, bloc) -> 
        let cc = analyse_code_expression exp in 
        let cb = analyse_code_bloc bloc in 
        let loopStart = getEtiquette () in 
        let loopEnd = getEtiquette () in 
        (label loopStart) ^ cc ^ jumpif 0 loopEnd ^ cb ^ jump loopStart ^ (label loopEnd)

    | Retour (exp, retSize, paramSize) -> 
        let ce = analyse_code_expression exp in 
        ce ^ return retSize paramSize
    | Empty -> ""

and analyse_code_bloc (li, taille) = 
    let sli = List.fold_left (fun acc i -> acc ^ (analyse_code_instruction i)) "" li in 
    sli ^ pop 0 taille

let analyse_code_fonction (AstPlacement.Fonction (info, parInfol, bloc)) =
    match !info with
    | InfoFun(nom, typ, argsType) -> "; fonction " ^ nom ^ "\n ; code début fonction\n" ^ (analyse_code_bloc bloc) ^ "; fin fonction\n"
    | _ -> failwith "erreur interne"

let analyser (AstPlacement.Programme (fonctions, prog)) = 
    let funsStr = List.fold_left (fun acc f -> acc ^ " " ^ (analyse_code_fonction f)) "" fonctions in 
    let blocStr = analyse_code_bloc prog in 
    getEntete () ^ funsStr ^ "main\n" ^ blocStr ^ halt