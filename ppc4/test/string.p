(* hello.p *)
begin
  print_string("Hello world!");
  newline()
end.

(*<<
Hello world!
>>*)

(*[[
MODULE Main 0 0
IMPORT Lib 0
ENDHDR

FUNC MAIN 0
! print_string("Hello world!");
CONST 13
GLOBAL __s1
CONST 0
GLOBAL lib.print_string
PCALL 2
! newline()
CONST 0
GLOBAL lib.newline
PCALL 0
RETURN
END

! String "Hello world!"
DEFINE __s1
STRING 48656C6C6F20776F726C6421
STRING 00
! End
]]*)
