type 
  tree = pointer to node;
  node = record left, right: tree end;

proc build(n: integer): tree;
  var t: tree;
begin
  if n <= 1 then
    return nil
  else
    new(t);
    t^.left := build(n-2);
    t^.right := build(n-1);
    return t
  end
end;

proc print(t:tree);
begin
  if t = nil then
    print_char('.')
  else
    print_char('(');
    print(t^.left);
    print(t^.right);
    print_char(')')
  end
end;

proc display(t: tree);
  var buf: array 20 of char;

  proc indent(i: integer);
    var j: integer;
  begin
    j := 0;
    while j <= i do print_char(' '); print_char(buf[j]); j := j+1 end
  end;

  proc disp(i: integer; t: tree);
  begin
    if t = nil then
      print_char('$');
      newline()
    else
      print_char('+'); print_char('-');
      buf[i] := '|';
      disp(i+1, t^.right);
      indent(i-1);
      print_char(' '); print_char(' '); print_char('\');
      newline();
      buf[i] := ' ';
      indent(i); print_char(' ');
      disp(i+1, t^.left)
    end
  end;

begin
  print_char('-'); disp(0, t)
end;

proc count(t:tree): integer;
begin
  if t = nil then
    return 1
  else
    return count(t^.left) + count(t^.right)
  end
end;

var p: tree;

begin 
  p := build(7);
  print(p); newline();
  (* newline(); display(p); newline(); *)
  print_string("Count = "); print_num(count(p)); newline()
end.

(*<<
(((.(..))((..)(.(..))))(((..)(.(..)))((.(..))((..)(.(..))))))
Count = 21
>>*)

(*[[
MODULE Main 0 0
IMPORT Lib 0
ENDHDR

FUNC _build 4
! if n <= 1 then
LDLW 16
CONST 1
JGT L2
! return nil
CONST 0
RETURN
LABEL L2
! new(t);
CONST 8
CONST 0
GLOBAL lib.new
PCALLW 1
STLW -4
! t^.left := build(n-2);
LDLW 16
CONST 2
MINUS
CONST 0
GLOBAL _build
PCALLW 1
LDLW -4
STOREW
! t^.right := build(n-1);
LDLW 16
CONST 1
MINUS
CONST 0
GLOBAL _build
PCALLW 1
LDLW -4
STNW 4
! return t
LDLW -4
RETURN
END

FUNC _print 0
! if t = nil then
LDLW 16
JEQZ L4
JUMP L5
LABEL L4
! print_char('.')
CONST 46
CONST 0
GLOBAL lib.print_char
PCALL 1
JUMP L6
LABEL L5
! print_char('(');
CONST 40
CONST 0
GLOBAL lib.print_char
PCALL 1
! print(t^.left);
LDLW 16
LOADW
CONST 0
GLOBAL _print
PCALL 1
! print(t^.right);
LDLW 16
LDNW 4
CONST 0
GLOBAL _print
PCALL 1
! print_char(')')
CONST 41
CONST 0
GLOBAL lib.print_char
PCALL 1
LABEL L6
RETURN
END

FUNC _display 20
! print_char('-'); disp(0, t)
CONST 45
CONST 0
GLOBAL lib.print_char
PCALL 1
LDLW 16
CONST 0
LOCAL 0
GLOBAL _display.disp
PCALL 2
RETURN
END

FUNC _display.indent 4
! j := 0;
CONST 0
STLW -4
! while j <= i do print_char(' '); print_char(buf[j]); j := j+1 end
JUMP L8
LABEL L7
CONST 32
CONST 0
GLOBAL lib.print_char
PCALL 1
LDLW 12
CONST -20
OFFSET
LDLW -4
LDIC
CONST 0
GLOBAL lib.print_char
PCALL 1
LDLW -4
CONST 1
PLUS
STLW -4
LABEL L8
LDLW -4
LDLW 16
JLEQ L7
RETURN
END

FUNC _display.disp 0
! if t = nil then
LDLW 20
JEQZ L10
JUMP L11
LABEL L10
! print_char('$');
CONST 36
CONST 0
GLOBAL lib.print_char
PCALL 1
! newline()
CONST 0
GLOBAL lib.newline
PCALL 0
JUMP L12
LABEL L11
! print_char('+'); print_char('-');
CONST 43
CONST 0
GLOBAL lib.print_char
PCALL 1
CONST 45
CONST 0
GLOBAL lib.print_char
PCALL 1
! buf[i] := '|';
CONST 124
LDLW 12
CONST -20
OFFSET
LDLW 16
STIC
! disp(i+1, t^.right);
LDLW 20
LDNW 4
LDLW 16
CONST 1
PLUS
LDLW 12
GLOBAL _display.disp
PCALL 2
! indent(i-1);
LDLW 16
CONST 1
MINUS
LDLW 12
GLOBAL _display.indent
PCALL 1
! print_char(' '); print_char(' '); print_char('\');
CONST 32
CONST 0
GLOBAL lib.print_char
PCALL 1
CONST 32
CONST 0
GLOBAL lib.print_char
PCALL 1
CONST 92
CONST 0
GLOBAL lib.print_char
PCALL 1
! newline();
CONST 0
GLOBAL lib.newline
PCALL 0
! buf[i] := ' ';
CONST 32
LDLW 12
CONST -20
OFFSET
LDLW 16
STIC
! indent(i); print_char(' ');
LDLW 16
LDLW 12
GLOBAL _display.indent
PCALL 1
CONST 32
CONST 0
GLOBAL lib.print_char
PCALL 1
! disp(i+1, t^.left)
LDLW 20
LOADW
LDLW 16
CONST 1
PLUS
LDLW 12
GLOBAL _display.disp
PCALL 2
LABEL L12
RETURN
END

FUNC _count 0
! if t = nil then
LDLW 16
JEQZ L13
JUMP L14
LABEL L13
! return 1
CONST 1
RETURN
LABEL L14
! return count(t^.left) + count(t^.right)
LDLW 16
LOADW
CONST 0
GLOBAL _count
PCALLW 1
LDLW 16
LDNW 4
CONST 0
GLOBAL _count
PCALLW 1
PLUS
RETURN
END

FUNC MAIN 0
! p := build(7);
CONST 7
CONST 0
GLOBAL _build
PCALLW 1
STGW _p
! print(p); newline();
LDGW _p
CONST 0
GLOBAL _print
PCALL 1
CONST 0
GLOBAL lib.newline
PCALL 0
! print_string("Count = "); print_num(count(p)); newline()
CONST 9
GLOBAL __s1
CONST 0
GLOBAL lib.print_string
PCALL 2
LDGW _p
CONST 0
GLOBAL _count
PCALLW 1
CONST 0
GLOBAL lib.print_num
PCALL 1
CONST 0
GLOBAL lib.newline
PCALL 0
RETURN
END

GLOVAR _p 4
! String "Count = "
DEFINE __s1
STRING 436F756E74203D20
STRING 00
! End
]]*)
