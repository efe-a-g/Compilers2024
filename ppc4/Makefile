# ppc4/Makefile

all: ppc4

PPC = mach.cmo keiko.cmo dict.cmo tree.cmo \
	lexer.cmo parser.cmo check.cmo peepopt.cmo kgen.cmo main.cmo

ppc4: $(PPC)
	ocamlc -g ../lib/common.cma $^ -o $@ 

parser.ml parser.mli: parser.mly
	ocamlyacc -v parser.mly

lexer.ml: lexer.mll
	ocamllex lexer.mll

%.cmi: %.mli
	ocamlc -c -g -I ../lib $<

%.cmo: %.ml
	ocamlc -c -g -I ../lib $<

KEIKO = ../keiko
TESTSRC := $(wildcard test/*.p)

ppp : $(KEIKO)/lib.k ppp.k
pprolog : $(KEIKO)/lib.k pprolog.k

pprolog ppp :
	$(KEIKO)/pplink -i `cd ..; pwd`/keiko/ppx -nostdlib $^ -o $@
	chmod +x $@

%.k : %.p
	./ppc4 -O $< >$@

pprolog.p : pprolog.x ppp
	./ppp <$< | sed -e 's/{/(*/g' -e 's/}/*)/g' >$@

test : $(TESTSRC:test/%.p=test-%)

test-%: force
	@echo "*** Test $*.p"
	./ppc4 -O test/$*.p >a.k
	-sed -n -e '1,/^(\*\[\[/d' -e '/^]]\*)/q' -e p test/$*.p | diff -b - a.k
	$(KEIKO)/pplink -nostdlib $(KEIKO)/lib.k a.k -o a.x >/dev/null
	-$(KEIKO)/ppx ./a.x >a.test 2>&1
	sed -n -e '1,/^(\*<</d' -e '/^>>\*)/q' -e p test/$*.p | diff - a.test
	@echo "*** Passed"; echo

promote: $(TESTSRC:test/%.p=promote-%)

promote-%: force
	./ppc4 -O test/$*.p >a.k
	$(KEIKO)/pplink -nostdlib $(KEIKO)/lib.k a.k -o a.x >/dev/null
	-$(KEIKO)/ppx ./a.x >a.test 2>&1
	sed -f promote.sed test/$*.p >test/$*.new
	mv test/$*.new test/$*.p

force:

MLGEN = parser.mli parser.ml lexer.ml 

ML = $(MLGEN) check.ml check.mli dict.ml dict.mli \
	lexer.mli mach.ml mach.mli main.ml keiko.mli keiko.ml \
	kgen.mli kgen.ml tree.ml tree.mli peepopt.mli peepopt.ml

clean: force
	rm -f *.cmi *.cmo *.output $(MLGEN) \
		ppc4 a.out a.k a.x a.test \
		pprolog.k pprolog.p pprolog ppp.k ppp

depend: $(ML) force
	(sed '/^###/q' Makefile; echo; ocamldep $(ML)) >new
	mv new Makefile

###

check.cmo : \
    tree.cmi \
    mach.cmi \
    lexer.cmi \
    keiko.cmi \
    dict.cmi \
    check.cmi
check.cmx : \
    tree.cmx \
    mach.cmx \
    lexer.cmx \
    keiko.cmx \
    dict.cmx \
    check.cmi
check.cmi : \
    tree.cmi
dict.cmo : \
    mach.cmi \
    keiko.cmi \
    dict.cmi
dict.cmx : \
    mach.cmx \
    keiko.cmx \
    dict.cmi
dict.cmi : \
    mach.cmi \
    keiko.cmi
keiko.cmo : \
    keiko.cmi
keiko.cmx : \
    keiko.cmi
keiko.cmi :
kgen.cmo : \
    tree.cmi \
    peepopt.cmi \
    mach.cmi \
    lexer.cmi \
    keiko.cmi \
    dict.cmi \
    kgen.cmi
kgen.cmx : \
    tree.cmx \
    peepopt.cmx \
    mach.cmx \
    lexer.cmx \
    keiko.cmx \
    dict.cmx \
    kgen.cmi
kgen.cmi : \
    tree.cmi
lexer.cmo : \
    parser.cmi \
    keiko.cmi \
    dict.cmi \
    lexer.cmi
lexer.cmx : \
    parser.cmx \
    keiko.cmx \
    dict.cmx \
    lexer.cmi
lexer.cmi : \
    parser.cmi \
    keiko.cmi \
    dict.cmi
mach.cmo : \
    mach.cmi
mach.cmx : \
    mach.cmi
mach.cmi :
main.cmo : \
    tree.cmi \
    peepopt.cmi \
    parser.cmi \
    mach.cmi \
    lexer.cmi \
    kgen.cmi \
    check.cmi
main.cmx : \
    tree.cmx \
    peepopt.cmx \
    parser.cmx \
    mach.cmx \
    lexer.cmx \
    kgen.cmx \
    check.cmx
parser.cmo : \
    tree.cmi \
    lexer.cmi \
    keiko.cmi \
    dict.cmi \
    parser.cmi
parser.cmx : \
    tree.cmx \
    lexer.cmx \
    keiko.cmx \
    dict.cmx \
    parser.cmi
parser.cmi : \
    tree.cmi \
    keiko.cmi \
    dict.cmi
peepopt.cmo : \
    keiko.cmi \
    peepopt.cmi
peepopt.cmx : \
    keiko.cmx \
    peepopt.cmi
peepopt.cmi : \
    keiko.cmi
tree.cmo : \
    keiko.cmi \
    dict.cmi \
    tree.cmi
tree.cmx : \
    keiko.cmx \
    dict.cmx \
    tree.cmi
tree.cmi : \
    keiko.cmi \
    dict.cmi
