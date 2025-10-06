(* foo.p *)

proc gcd(u, v: integer): integer;
  var x, y: integer;
begin
  x := u; y := v;
  while x <> y do
    if x < y then
      y := y - x
    else
      x := x - y
    end
  end;
  return x
end;
  
var z: integer;
begin
  z := gcd(3*37, 5*37);
  print_string("The final answer is calculated as ");
  print_num(z); newline()
end.

(*<<
The final answer is calculated as 37
>>*)

(*[[
MODULE Main 0 0
IMPORT Lib 0
ENDHDR

FUNC _gcd 8
! x := u; y := v;
LDLW 16
STLW -4
LDLW 20
STLW -8
! while x <> y do
JUMP L2
LABEL L1
! if x < y then
LDLW -4
LDLW -8
JGEQ L5
! y := y - x
LDLW -8
LDLW -4
MINUS
STLW -8
JUMP L2
LABEL L5
! x := x - y
LDLW -4
LDLW -8
MINUS
STLW -4
LABEL L2
LDLW -4
LDLW -8
JNEQ L1
! return x
LDLW -4
RETURN
END

FUNC MAIN 0
! z := gcd(3*37, 5*37);
CONST 185
CONST 111
CONST 0
GLOBAL _gcd
PCALLW 2
STGW _z
! print_string("The final answer is calculated as ");
CONST 35
GLOBAL __s1
CONST 0
GLOBAL lib.print_string
PCALL 2
! print_num(z); newline()
LDGW _z
CONST 0
GLOBAL lib.print_num
PCALL 1
CONST 0
GLOBAL lib.newline
PCALL 0
RETURN
END

GLOVAR _z 4
! String "The final answer is calculated as "
DEFINE __s1
STRING 5468652066696E616C20616E737765722069732063616C63756C617465642061
STRING 7320
STRING 00
! End
]]*)
