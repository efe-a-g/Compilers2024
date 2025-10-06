type string = array 11 of char;

type rec = record name: string; age: integer end;

var 
  db: array 20 of rec;
  N: integer;

proc equal(x, y: string): boolean;
  var i: integer;
begin
  i := 0;
  while i < 10 do
    if x[i] <> y[i] then
      return false
    end;
    i := i+1
  end;
  return true
end;

proc store(n: string; a: integer);
begin
  db[N].name := n;
  db[N].age := a;
  N := N+1
end;

proc recall(n: string): integer;
  var i: integer;
begin
  i := 0;
  while i < N do
    if equal(db[i].name, n) then
      return db[i].age
    end;
    i := i+1
  end;
  return 999
end;

begin
  N := 0;

  store("bill      ", 23);
  store("george    ", 34);

  print_num(recall("george    ")); newline();
  print_num(recall("fred      ")); newline()
end.

(*<<
34
999
>>*)

(*[[
MODULE Main 0 0
IMPORT Lib 0
ENDHDR

FUNC _equal 4
! i := 0;
CONST 0
STLW -4
! while i < 10 do
JUMP L2
LABEL L1
! if x[i] <> y[i] then
LDLW 16
LDLW -4
LDIC
LDLW 20
LDLW -4
LDIC
JEQ L6
! return false
CONST 0
RETURN
LABEL L6
! i := i+1
LDLW -4
CONST 1
PLUS
STLW -4
LABEL L2
LDLW -4
CONST 10
JLT L1
! return true
CONST 1
RETURN
END

FUNC _store 0
! db[N].name := n;
GLOBAL _db
LDGW _N
CONST 16
TIMES
OFFSET
LDLW 16
CONST 11
FIXCOPY
! db[N].age := a;
LDLW 20
GLOBAL _db
LDGW _N
CONST 16
TIMES
OFFSET
STNW 12
! N := N+1
LDGW _N
CONST 1
PLUS
STGW _N
RETURN
END

FUNC _recall 4
! i := 0;
CONST 0
STLW -4
! while i < N do
JUMP L8
LABEL L7
! if equal(db[i].name, n) then
LDLW 16
GLOBAL _db
LDLW -4
CONST 16
TIMES
OFFSET
CONST 0
GLOBAL _equal
PCALLW 2
JNEQZ L10
JUMP L12
LABEL L10
! return db[i].age
GLOBAL _db
LDLW -4
CONST 16
TIMES
OFFSET
LDNW 12
RETURN
LABEL L12
! i := i+1
LDLW -4
CONST 1
PLUS
STLW -4
LABEL L8
LDLW -4
LDGW _N
JLT L7
! return 999
CONST 999
RETURN
END

FUNC MAIN 0
! N := 0;
CONST 0
STGW _N
! store("bill      ", 23);
CONST 23
GLOBAL __s1
CONST 0
GLOBAL _store
PCALL 2
! store("george    ", 34);
CONST 34
GLOBAL __s2
CONST 0
GLOBAL _store
PCALL 2
! print_num(recall("george    ")); newline();
GLOBAL __s3
CONST 0
GLOBAL _recall
PCALLW 1
CONST 0
GLOBAL lib.print_num
PCALL 1
CONST 0
GLOBAL lib.newline
PCALL 0
! print_num(recall("fred      ")); newline()
GLOBAL __s4
CONST 0
GLOBAL _recall
PCALLW 1
CONST 0
GLOBAL lib.print_num
PCALL 1
CONST 0
GLOBAL lib.newline
PCALL 0
RETURN
END

GLOVAR _db 320
GLOVAR _N 4
! String "bill      "
DEFINE __s1
STRING 62696C6C202020202020
STRING 00
! String "george    "
DEFINE __s2
STRING 67656F72676520202020
STRING 00
! String "george    "
DEFINE __s3
STRING 67656F72676520202020
STRING 00
! String "fred      "
DEFINE __s4
STRING 66726564202020202020
STRING 00
! End
]]*)
