(* lab1q/expr.mli *)
(* Copyright (c) 2023 J. M. Spivey *)

open Keiko

(* Although this compiler avoids building a tree for the entire
program, it still builds little trees for expressions, so that they
can soon after be translated for their value or as short-circuit
conditions.  The two functions |gen_expr| and |gen_cond| produce their
output code by calling |Codebuf.gen|. *)

(* |expr| -- abstract syntax of expressions *)
type expr =
    Constant of int 
  | Variable of string
  | Monop of op * expr 
  | Binop of op * expr * expr

(* |gen_expr| -- output code to evaluate expression *)
val gen_expr : expr -> unit

(* |gen_cond| -- translate expression as a short-circuit condition *)
val gen_cond : expr -> codelab -> codelab -> unit
