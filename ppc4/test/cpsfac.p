(* cpsfac.p *)

proc fac(n: integer; proc k(r: integer): integer): integer;
  proc k1(r: integer): integer;
    var r1: integer;
  begin
    return k(n * r)
  end;
begin 
  if n = 0 then
    return k(1)
  else
    return fac(n-1, k1)
  end
end;

proc id(r: integer): integer;
begin 
  return r 
end;

begin 
  print_num(fac(10, id));
  newline()
end.

(*<<
3628800
>>*)

(*[[
MODULE Main 0 0
IMPORT Lib 0
ENDHDR

FUNC _fac 0
! if n = 0 then
LDLW 16
JEQZ L1
JUMP L2
LABEL L1
! return k(1)
CONST 1
LDLW 24
LDLW 20
PCALLW 1
RETURN
LABEL L2
! return fac(n-1, k1)
LOCAL 0
GLOBAL _fac.k1
LDLW 16
CONST 1
MINUS
CONST 0
GLOBAL _fac
PCALLW 3
RETURN
END

FUNC _fac.k1 4
! return k(n * r)
LDLW 12
LDNW 16
LDLW 16
TIMES
LDLW 12
LDNW 24
LDLW 12
LDNW 20
PCALLW 1
RETURN
END

FUNC _id 0
! return r
LDLW 16
RETURN
END

FUNC MAIN 0
! print_num(fac(10, id));
CONST 0
GLOBAL _id
CONST 10
CONST 0
GLOBAL _fac
PCALLW 3
CONST 0
GLOBAL lib.print_num
PCALL 1
! newline()
CONST 0
GLOBAL lib.newline
PCALL 0
RETURN
END

! End
]]*)
