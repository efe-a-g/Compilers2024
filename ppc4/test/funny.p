var a,b,c,d: integer;

proc p1(var a: integer; b: integer; var d: integer): integer;
  var c: integer;
begin
  c :=b+a;
  d :=b+1;
  a :=a-b;
  return (a+d)*b
end;

begin
  a:=5; b:=2; c:=3; d:=1;
  b := p1(b,d,a) + 1;
  print_string("A="); print_num(a);
  print_string(" B="); print_num(b);
  print_string(" C="); print_num(c);
  print_string(" D="); print_num(d);
  newline()
end.

(*<<
A=2 B=4 C=3 D=1
>>*)

(*[[
MODULE Main 0 0
IMPORT Lib 0
ENDHDR

FUNC _p1 4
! c :=b+a;
LDLW 20
LDLW 16
LOADW
PLUS
STLW -4
! d :=b+1;
LDLW 20
CONST 1
PLUS
LDLW 24
STOREW
! a :=a-b;
LDLW 16
LOADW
LDLW 20
MINUS
LDLW 16
STOREW
! return (a+d)*b
LDLW 16
LOADW
LDLW 24
LOADW
PLUS
LDLW 20
TIMES
RETURN
END

FUNC MAIN 0
! a:=5; b:=2; c:=3; d:=1;
CONST 5
STGW _a
CONST 2
STGW _b
CONST 3
STGW _c
CONST 1
STGW _d
! b := p1(b,d,a) + 1;
GLOBAL _a
LDGW _d
GLOBAL _b
CONST 0
GLOBAL _p1
PCALLW 3
CONST 1
PLUS
STGW _b
! print_string("A="); print_num(a);
CONST 3
GLOBAL __s1
CONST 0
GLOBAL lib.print_string
PCALL 2
LDGW _a
CONST 0
GLOBAL lib.print_num
PCALL 1
! print_string(" B="); print_num(b);
CONST 4
GLOBAL __s2
CONST 0
GLOBAL lib.print_string
PCALL 2
LDGW _b
CONST 0
GLOBAL lib.print_num
PCALL 1
! print_string(" C="); print_num(c);
CONST 4
GLOBAL __s3
CONST 0
GLOBAL lib.print_string
PCALL 2
LDGW _c
CONST 0
GLOBAL lib.print_num
PCALL 1
! print_string(" D="); print_num(d);
CONST 4
GLOBAL __s4
CONST 0
GLOBAL lib.print_string
PCALL 2
LDGW _d
CONST 0
GLOBAL lib.print_num
PCALL 1
! newline()
CONST 0
GLOBAL lib.newline
PCALL 0
RETURN
END

GLOVAR _a 4
GLOVAR _b 4
GLOVAR _c 4
GLOVAR _d 4
! String "A="
DEFINE __s1
STRING 413D
STRING 00
! String " B="
DEFINE __s2
STRING 20423D
STRING 00
! String " C="
DEFINE __s3
STRING 20433D
STRING 00
! String " D="
DEFINE __s4
STRING 20443D
STRING 00
! End
]]*)
