(* mutual.p *)

proc flip(i: integer): integer;
  var r: integer;
begin
  if i = 0 then 
    r := 1
  else 
    r := 2 * flop(i-1)
  end;
  print_string("flip("); print_num(i); 
  print_string(") = "); print_num(r);
  newline();
  return r
end;

proc flop(i: integer): integer;
  var r: integer;
begin
  if i = 0 then 
    r := 1
  else 
    r := flip(i-1) + k
  end;
  print_string("flop("); print_num(i); 
  print_string(") = "); print_num(r);
  newline();
  return r
end;

const k = 5;

begin
  print_num(flip(5));
  newline()
end.

(*<<
flop(0) = 1
flip(1) = 2
flop(2) = 7
flip(3) = 14
flop(4) = 19
flip(5) = 38
38
>>*)

(*[[
MODULE Main 0 0
IMPORT Lib 0
ENDHDR

FUNC _flip 4
! if i = 0 then
LDLW 16
JEQZ L1
JUMP L2
LABEL L1
! r := 1
CONST 1
STLW -4
JUMP L3
LABEL L2
! r := 2 * flop(i-1)
CONST 2
LDLW 16
CONST 1
MINUS
CONST 0
GLOBAL _flop
PCALLW 1
TIMES
STLW -4
LABEL L3
! print_string("flip("); print_num(i);
CONST 6
GLOBAL __s1
CONST 0
GLOBAL lib.print_string
PCALL 2
LDLW 16
CONST 0
GLOBAL lib.print_num
PCALL 1
! print_string(") = "); print_num(r);
CONST 5
GLOBAL __s2
CONST 0
GLOBAL lib.print_string
PCALL 2
LDLW -4
CONST 0
GLOBAL lib.print_num
PCALL 1
! newline();
CONST 0
GLOBAL lib.newline
PCALL 0
! return r
LDLW -4
RETURN
END

FUNC _flop 4
! if i = 0 then
LDLW 16
JEQZ L4
JUMP L5
LABEL L4
! r := 1
CONST 1
STLW -4
JUMP L6
LABEL L5
! r := flip(i-1) + k
LDLW 16
CONST 1
MINUS
CONST 0
GLOBAL _flip
PCALLW 1
CONST 5
PLUS
STLW -4
LABEL L6
! print_string("flop("); print_num(i);
CONST 6
GLOBAL __s3
CONST 0
GLOBAL lib.print_string
PCALL 2
LDLW 16
CONST 0
GLOBAL lib.print_num
PCALL 1
! print_string(") = "); print_num(r);
CONST 5
GLOBAL __s4
CONST 0
GLOBAL lib.print_string
PCALL 2
LDLW -4
CONST 0
GLOBAL lib.print_num
PCALL 1
! newline();
CONST 0
GLOBAL lib.newline
PCALL 0
! return r
LDLW -4
RETURN
END

FUNC MAIN 0
! print_num(flip(5));
CONST 5
CONST 0
GLOBAL _flip
PCALLW 1
CONST 0
GLOBAL lib.print_num
PCALL 1
! newline()
CONST 0
GLOBAL lib.newline
PCALL 0
RETURN
END

! String "flip("
DEFINE __s1
STRING 666C697028
STRING 00
! String ") = "
DEFINE __s2
STRING 29203D20
STRING 00
! String "flop("
DEFINE __s3
STRING 666C6F7028
STRING 00
! String ") = "
DEFINE __s4
STRING 29203D20
STRING 00
! End
]]*)
