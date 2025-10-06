(* lab1q/codebuf.mli *)
(* Copyright (c) 2023 J. M. Spivey *)

open Keiko

let codebuf = Growvect.create 100

(* |gen| -- generate an instruction or two *)
let gen x = List.iter (Growvect.append codebuf) x

(* |get_code| -- fetch generated code *)
let get_code () =
  SEQ (Growvect.to_list codebuf)
