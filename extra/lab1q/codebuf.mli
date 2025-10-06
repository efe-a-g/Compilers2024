(* lab1q/codebuf.mli *)
(* Copyright (c) 2023 J. M. Spivey *)

(* The parser generates code as a side effect as it reads the source
program, by adding instructions to this buffer.  The instructions are
not output immediately, but optionally improved later by the peephole
optimiser. *)

(* |gen| -- add instrucitions to the buffer *)
val gen : Keiko.code list -> unit

(* |get_code| -- fetch the buffer contents *)
val get_code : unit -> Keiko.code
