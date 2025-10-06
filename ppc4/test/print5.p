begin
  print_string("five"); newline()
end.

(*<<
five
>>*)

(*[[
MODULE Main 0 0
IMPORT Lib 0
ENDHDR

FUNC MAIN 0
! print_string("five"); newline()
CONST 5
GLOBAL __s1
CONST 0
GLOBAL lib.print_string
PCALL 2
CONST 0
GLOBAL lib.newline
PCALL 0
RETURN
END

! String "five"
DEFINE __s1
STRING 66697665
STRING 00
! End
]]*)
