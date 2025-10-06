(* lab1q/parser.ml *)
(* Copyright (c) 2023 J. M. Spivey *)

open Lexer
open Keiko
open Codebuf
open Expr

(* The parser uses recursive descent with a single token of
look-ahead, stored in the shared variable |tok|.  Each class in the
grammar becomes a parsing function with the same name; that function
expects the first token of its phrase in |tok| when it is called, and
returns with |tok| containing the first token after the phrase.  The
return value of each parsing function is a fragment of abstract syntax
tree.

The exception is the top-level function |program|, which doesn't
expect |tok| to have been set before it is called, and so begins
with a call to |scan| to set things rolling.  It returns, all being
well, with |tok| containing |EOF|. *)

(* |tok| -- current look-ahead token *)
let tok = ref EOF

(* |scan| -- move to next token *)
let scan () = tok := token ()

exception Parse_error of Lexer.token

let error () = raise (Parse_error !tok)

(* |eat| -- consume a specific token or signal an error *)
let eat t =
  if !tok = t then scan () else error ()

let rec program () =
  scan ();
  eat BEGIN; stmts (); eat END; eat DOT

and stmts () =
  stmt ();
  if !tok = SEMI then begin
    eat SEMI; stmts ()
  end

and stmt () =
  gen [LINE !Lexer.lineno];
  begin match !tok with
      IDENT x ->  
        eat (IDENT x); eat ASSIGN;
        gen_expr (expr ());
        gen [STGW ("_" ^ x)]
    | PRINT ->
        eat PRINT; gen_expr (expr ());
        gen [CONST 0; GLOBAL "lib.print"; PCALL 1]
    | NEWLINE ->
        eat NEWLINE;
        gen [CONST 0; GLOBAL "lib.newline"; PCALL 0]
    | IF ->
        let lab1 = label () and lab2 = label () and lab3 = label () in
        eat IF;
        gen_cond (expr ()) lab1 lab2;
        eat THEN;
        gen [LABEL lab1];
        stmts ();
        gen [JUMP lab3; LABEL lab2];
        if !tok = ELSE then begin
          eat ELSE; stmts ()
        end;
        eat END;
        gen [LABEL lab3]
    | WHILE ->
        let lab1 = label () and lab2 = label () and lab3 = label () in
        eat WHILE;
        gen [LABEL lab1];
        gen_cond (expr ()) lab2 lab3;
        eat DO;
        gen [LABEL lab2];
        stmts ();
        eat END;
        gen [JUMP lab1; LABEL lab3]
    | _ ->
        (* Empty statement *)
        ()
  end

(* To work with one token look-ahead, we must change the
expression grammar to

    expr -> simple expr_tail

    expr_tail -> empty | RELOP simple expr_tail

and similarly for simple expressions, terms and factors.  In order
to build the proper tree, with operators that associate to the left,
the parsing function for |expr_tail| takes as a parameter the tree
for the expression so far.

Because there are two translations for expressions -- as code to produce
a value and as a short-circuit condition, the parser builds a tree and
then feeds it to either |Expr.gen_expr| or |Expr.gen_cond|. *)

and expr () =
  let e1 = simple () in
  expr_tail e1

and expr_tail e1 =
  match !tok with
      RELOP w ->
        eat (RELOP w);
        let e2 = simple () in
        expr_tail (Binop (w, e1, e2))
    | _ -> e1
    
and simple () =
  let e1 = term () in
  simple_tail e1

and simple_tail e1 =
  match !tok with
      ADDOP w ->
        eat (ADDOP w);
        let e2 = term () in
        simple_tail (Binop (w, e1, e2))
    | MINUS ->
        eat MINUS;
        let e2 = term () in
        simple_tail (Binop (Minus, e1, e2))
    | _ -> e1

and term () =
  let e1 = factor () in
  term_tail e1

and term_tail e1 =
  match !tok with
      MULOP w ->
        eat (MULOP w);
        let e2 = factor () in
        term_tail (Binop (w, e1, e2))
    | _ -> e1

and factor () =
  match !tok with
      IDENT x ->
        eat (IDENT x); Variable ("_" ^ x)
    | NUMBER n ->
        eat (NUMBER n); Constant n
    | MONOP w ->
        eat (MONOP w); let e1 = factor () in Monop (w, e1)
    | MINUS ->
        eat MINUS; let e1 = factor () in Monop (Uminus, e1)
    | LPAR ->
        eat LPAR; let e = expr () in eat RPAR; e
    | _ -> error ()
