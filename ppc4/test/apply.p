proc apply(proc f(x: integer));
begin
  f(111)
end;

proc beta(y: integer);
  proc f(x: integer);
  begin
    print_num(x);
    newline();
  end;

  proc g(x:integer);
  begin
    print_num(y);
    newline();
  end;

begin
  apply(f);
  apply(g)
end;

begin
  beta(222)
end.

(*<<
111
222
>>*)

(*[[
MODULE Main 0 0
IMPORT Lib 0
ENDHDR

FUNC _apply 0
! f(111)
CONST 111
LDLW 20
LDLW 16
PCALL 1
RETURN
END

FUNC _beta 0
! apply(f);
LOCAL 0
GLOBAL _beta.f
CONST 0
GLOBAL _apply
PCALL 2
! apply(g)
LOCAL 0
GLOBAL _beta.g
CONST 0
GLOBAL _apply
PCALL 2
RETURN
END

FUNC _beta.f 0
! print_num(x);
LDLW 16
CONST 0
GLOBAL lib.print_num
PCALL 1
! newline();
CONST 0
GLOBAL lib.newline
PCALL 0
! end;
RETURN
END

FUNC _beta.g 0
! print_num(y);
LDLW 12
LDNW 16
CONST 0
GLOBAL lib.print_num
PCALL 1
! newline();
CONST 0
GLOBAL lib.newline
PCALL 0
! end;
RETURN
END

FUNC MAIN 0
! beta(222)
CONST 222
CONST 0
GLOBAL _beta
PCALL 1
RETURN
END

! End
]]*)
