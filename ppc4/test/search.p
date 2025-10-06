(* search.p *)

const target = "abracadabra";

var i: integer; found: boolean;

begin
  i := 0; found := false;
  while not found do
    found := target[i] = 'd';
    i := i + 1
  end;
  print_num(i);
  newline()
end.

(*<<
7
>>*)

(*[[
MODULE Main 0 0
IMPORT Lib 0
ENDHDR

FUNC MAIN 0
! i := 0; found := false;
CONST 0
STGW _i
CONST 0
STGC _found
! while not found do
JUMP L2
LABEL L1
! found := target[i] = 'd';
GLOBAL __s1
LDGW _i
LDIC
CONST 100
EQ
STGC _found
! i := i + 1
LDGW _i
CONST 1
PLUS
STGW _i
LABEL L2
LDGC _found
JNEQZ L3
JUMP L1
LABEL L3
! print_num(i);
LDGW _i
CONST 0
GLOBAL lib.print_num
PCALL 1
! newline()
CONST 0
GLOBAL lib.newline
PCALL 0
RETURN
END

GLOVAR _i 4
GLOVAR _found 1
! String "abracadabra"
DEFINE __s1
STRING 6162726163616461627261
STRING 00
! End
]]*)
