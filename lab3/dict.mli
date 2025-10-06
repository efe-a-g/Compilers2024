(* lab3/dict.mli *)
(* Copyright (c) 2017 J. M. Spivey *)

type ident = string

(* |def| -- definitions in environment *)
type def = 
  { d_tag : ident;              (* Name *)
    d_kind : def_kind;          (* Definition *)
    d_level : int;              (* Nesting level *)
    d_label : string;           (* Label if global *)
    d_offset : int }            (* Offset if local *)

and def_kind =
    VarDef                      (* Variable *)
  | ProcDef of int              (* Procedure (nparams) *)

type environment

(* |define| -- add a definition, raise Exit if already declared *)
val define : def -> environment -> environment

(* |lookup| -- search an environment or raise Not_found *)
val lookup : ident -> environment -> def

(* |new_block| -- add new block to top of environment *)
val new_block : environment -> environment

(* |empty| -- initial empty environment *)
val empty : environment

