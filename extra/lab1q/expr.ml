(* lab1q/expr.ml *)
(* Copyright (c) 2023 J. M. Spivey *)

open Keiko
open Codebuf

(* |expr| -- abstract syntax of expressions *)
type expr =
    Constant of int 
  | Variable of string
  | Monop of Keiko.op * expr 
  | Binop of Keiko.op * expr * expr

(* |gen_expr| -- generate code for an expression *)
let rec gen_expr =
  function
      Constant n -> gen [CONST n]
    | Variable x -> gen [LDGW x]
    | Monop (w, e1) ->
        gen_expr e1; gen [MONOP w]
    | Binop (w, e1, e2) ->
        gen_expr e1; gen_expr e2; gen [BINOP w]
  
(* |gen_cond| -- generate jumping code for a condition *)
let rec gen_cond e tlab flab =
  (* Jump to |tlab| if |e| is true and |flab| if it is false *)
  match e with
      Constant n ->
        if n <> 0 then gen [JUMP tlab] else gen [JUMP flab]
    | Binop ((Eq|Neq|Lt|Gt|Leq|Geq) as w, e1, e2) ->
        gen_expr e1; gen_expr e2; gen [JUMPC (w, tlab); JUMP flab]
    | Monop (Not, e1) ->
        gen_cond e1 flab tlab
    | Binop (And, e1, e2) ->
        let lab1 = label () in
        gen_cond e1 lab1 flab;
        gen [LABEL lab1];
        gen_cond e2 tlab flab
    | Binop (Or, e1, e2) ->
        let lab1 = label () in
        gen_cond e1 tlab lab1;
        gen [LABEL lab1];
        gen_cond e2 tlab flab
    | _ ->
        gen_expr e;
        gen [CONST 0; JUMPC (Neq, tlab); JUMP flab]
