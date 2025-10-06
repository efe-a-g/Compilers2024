(* lab1q/parser.ml *)
(* Copyright (c) 2023 J. M. Spivey *)

(* |program| -- parse a program and generate code for it *)
val program : unit -> unit

(* |Parse_error| -- raised on syntax error *)
exception Parse_error of Lexer.token
