(* lab1q/main.ml *)
(* Copyright (c) 2017 J. M. Spivey *)

open Print

let optflag = ref false

(* |main| -- main program *)
let main () =
  (* Read the command line *)
  let dflag = ref 0 in
  let fns = ref [] in
  let usage =  "Usage: ppc [-d] file.p" in
  Arg.parse 
    [("-d", Arg.Unit (fun () -> incr dflag), " Print the tree for debugging");
      ("-O", Arg.Unit (fun () -> optflag := true), " Peephole optimiser")]
    (function s -> fns := !fns @ [s]) usage;
  if List.length !fns <> 1 then begin 
    fprintf stderr "$\n" [fStr usage]; exit 2 
  end;

  (* Open and parse the input *)
  let in_file = List.hd !fns in
  let in_chan = open_in in_file in
  Source.init in_file in_chan;
  Lexer.set_file in_chan;
  begin try Parser.program () with
    Parser.Parse_error t ->
      let tok = Lexer.show_tok t in
      Source.err_message "syntax error at token '$'" [fStr tok] !Lexer.lineno;
      exit 1
  end;

  (* Output the code *)
  let code = Codebuf.get_code () in
  printf "MODULE Main 0 0\n" [];
  printf "IMPORT Lib 0\n" [];
  printf "ENDHDR\n\n" [];

  printf "FUNC MAIN 0\n" [];
  Keiko.output (if !optflag then Peepopt.optimise code else code);
  printf "RETURN\n" [];
  printf "END\n\n" [];

  (* Reserve space for global variables *)
  List.iter 
    (fun x -> printf "GLOVAR _$ 4\n" [fStr x]) 
    (Lexer.get_vars ());

  exit 0

let ppc = main ()
