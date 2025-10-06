(* lab1q/lexer.ml *)
(* Copyright (c) 2017 J. M. Spivey *)

open Keiko

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

(* |kwtable| -- a little table to recognize keywords *)
let kwtable = 
  Util.make_hash 64
    [ ("begin", BEGIN); ("do", DO); ("if", IF ); ("else", ELSE); 
      ("end", END); ("then", THEN); ("while", WHILE); ("print", PRINT);
      ("newline", NEWLINE); ("and", MULOP And); ("div", MULOP Div); 
      ("or", ADDOP Or); ("not", MONOP Not); ("mod", MULOP Mod);
      ("true", NUMBER 1); ("false", NUMBER 0) ]

(* |idtable| -- table of all identifiers seen so far *)
let idtable = Hashtbl.create 64

(* |lookup| -- convert string to keyword or identifier *)
let lookup s = 
  try Hashtbl.find kwtable s with 
    Not_found -> 
      Hashtbl.replace idtable s ();
      IDENT s

(* |get_vars| -- get list of identifiers in the program *)
let get_vars () = 
  Hashtbl.fold (fun k () ks -> k::ks) idtable []

(* The lexer uses one character of look-ahead, stored in the
variable |ch|.  The parser reads the variable |lineno| to find
the line number of the most recent token; when the look-ahead
character is a newline, |currline| may be one greater. *)

let infile = ref stdin
let ch = ref '\000'
let currline = ref 1
let lineno = ref 1

(* |getch| -- get next input character in |ch| *)
let getch () =
  begin
    try ch := input_char !infile with
      End_of_file -> ch := '\000'
  end;
  if !ch = '\n' then begin
    incr currline;
    Source.note_line_pos !currline
  end

(* |set_file| -- select input file *)
let set_file inp = 
  infile := inp; getch ()

(* |token| -- scan a token *)
let rec token () =
  lineno := !currline;
  match !ch with
      'A'..'Z' | 'a'..'z' ->
        let buf = Buffer.create 16 in
        Buffer.add_char buf !ch; getch ();
        while match !ch with 'A'..'Z' | 'a'..'z' | '0'..'9' | '_' -> true
                | _ -> false do
          Buffer.add_char buf !ch; getch ()
        done;
        lookup (Buffer.contents buf)
    | '0'..'9' ->
        let buf = Buffer.create 16 in
        while match !ch with '0'..'9' -> true | _ -> false do
          Buffer.add_char buf !ch; getch ()
        done;
        NUMBER (int_of_string (Buffer.contents buf))
    | ';' -> getch (); SEMI
    | '.' -> getch (); DOT
    | ':' ->
        begin
          getch ();
          match !ch with
              '=' -> getch (); ASSIGN
            | _ -> COLON
        end
    | '(' ->
        begin
          getch ();
          match !ch with
              '*' ->
                getch ();
                let prev = ref !ch in
                getch ();
                while !prev <> '*' || !ch <> ')' do
                  prev := !ch; getch ();
                  if !ch = '\000' then
                    failwith "EOF in comment"
                done;
                getch ();
                token ()
            | _ -> LPAR
        end
    | ')' -> getch (); RPAR
    | ',' -> getch (); COMMA
    | '|' -> getch (); VBAR
    | '=' -> getch (); RELOP Eq
    | '+' -> getch (); ADDOP Plus
    | '-' -> getch (); MINUS
    | '*' -> getch (); MULOP Times
    | '<' ->
        begin
          getch ();
          match !ch with
              '=' -> getch (); RELOP Leq
            | '>' -> getch (); RELOP Neq
            | _ -> RELOP Lt
        end
    | '>' ->
        begin
          getch ();
          match !ch with
              '=' -> getch (); RELOP Geq
            | _ -> RELOP Gt
        end
    | ' ' | '\t' | '\r' | '\n' -> getch (); token ()
    | '\000' -> EOF
    | _ -> getch (); BADTOK

(* |show_tok| -- token as a string *)
let show_tok =
  function
      IDENT x -> x
    | MONOP w -> op_name w
    | MULOP w -> op_name w
    | ADDOP w -> op_name w
    | RELOP w -> op_name w
    | NUMBER n -> string_of_int n
    | SEMI -> ";" | DOT -> "." | COLON -> ":" | LPAR -> "(" | RPAR -> ")"
    | COMMA -> "," | MINUS -> "-" | VBAR -> "|" | ASSIGN -> ":="
    | BEGIN -> "begin" | DO -> "do" | ELSE -> "else" | END -> "end"
    | IF -> "if" | THEN -> "then" | WHILE -> "while" | PRINT -> "print"
    | NEWLINE -> "newline"
    | BADTOK -> "bad token"
    | EOF -> "end of file"
