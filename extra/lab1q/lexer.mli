(* lab1q/lexer.mli *)
(* Copyright (c) 2017 J. M. Spivey *)

type token =
    IDENT of string
  | MONOP of Keiko.op
  | MULOP of Keiko.op
  | ADDOP of Keiko.op
  | RELOP of Keiko.op
  | NUMBER of int
  | SEMI | DOT | COLON | LPAR | RPAR | COMMA | MINUS | VBAR | ASSIGN 
  | BEGIN | DO | ELSE | END | IF | THEN | WHILE | PRINT | NEWLINE
  | BADTOK | EOF 

(* |set_file| -- select input file *)
val set_file : in_channel -> unit

(* |token| -- scan a token and return its code *)
val token : unit -> token

(* |lineno| -- number of current line *)
val lineno : int ref

(* |get_vars| -- list of identifiers used in program *)
val get_vars : unit -> string list

(* |show_tok| -- token as a string *)
val show_tok : token -> string
