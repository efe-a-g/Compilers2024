proc foo();
begin
  while true do newline() end
end;

begin end.

(*[[
MODULE Main 0 0
IMPORT Lib 0
ENDHDR

FUNC _foo 0
LABEL L1
! while true do newline() end
CONST 0
GLOBAL lib.newline
PCALL 0
JUMP L1
END

FUNC MAIN 0
! begin end.
RETURN
END

! End
]]*)
