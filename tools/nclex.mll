(* nclex.mll *)
(* Copyright (c) 2017 J. M. Spivey *)

{
open Ncparse 
open String 
open Lexing
open Print

let line_no = ref 1
}

rule token =
  parse
      "<"(['A'-'Z''a'-'z']+|'('[^')']+')' as s)  { OPEN s }
    | "#<"(['A'-'Z''a'-'z']+|'('[^')']+')' as s)  { GOPEN s }
    | [^'<''>''('')'',''@'' ''#''\n']+ as s  { WORD s }
    | "(*"[^'\n']*"*)" as s     { WORD s }
    | "->" as s                 { WORD s }
    | ">"                       { CLOSE }
    | "("                       { LPAREN }
    | ")"                       { RPAREN }
    | ","" "* as s              { COMMA s }
    | "@"                       { ATSIGN }
    | "\n"                      { incr line_no; NL }
    | _ as c                    { CHAR c }
    | eof                       { EOF }

