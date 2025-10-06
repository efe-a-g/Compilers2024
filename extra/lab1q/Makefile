# lab1/Makefile

## Add your own test cases to this list
TEST = gcd

KEIKO = ../keiko
LIB = ../lib

all: ppc1

PPC = keiko.cmo codebuf.cmo lexer.cmo expr.cmo parser.cmo peepopt.cmo main.cmo

ppc1: $(LIB)/common.cma $(PPC)
	ocamlc $^ -o $@ 

%.cmi : %.mli
	ocamlc $(MLFLAGS) -c $<

%.cmo : %.ml
	ocamlc $(MLFLAGS) -c $<

MLFLAGS = -I ../lib


# TESTING

test : force
	$(MAKE) $(TEST:%=test-%)

test-%: $(KEIKO)/pplink $(KEIKO)/ppx force
	@echo "*** Test $*.p"
	./ppc1 $*.p >a.k
	$(KEIKO)/pplink -nostdlib $(KEIKO)/lib.k a.k -o a.x >/dev/null
	$(KEIKO)/ppx ./a.x >a.test
	sed -n -e '1,/^(\*<</d' -e '/^>>\*)/q' -e p $*.p | diff - a.test
	@echo "*** Passed"; echo

# REMOTE DEPENDENCIES

$(LIB)/common.cma:
	$(MAKE) -C $(@D) $(@F)

$(KEIKO)/pplink $(KEIKO)/ppx:
	$(MAKE) -C $(KEIKO) build


# DEPENDENCIES

ML = keiko.ml keiko.mli expr.ml expr.mli lexer.mli \
	lexer.ml main.ml parser.mli parser.ml \
	peepopt.mli peepopt.ml codebuf.mli codebuf.ml

depend : $(ML) force
	(sed '/^###/q' Makefile; echo; ocamldep $(ML)) >new
	mv new Makefile

realclean: clean


# CLEANUP

clean: force
	rm -f ppc1 *.cma *.cmo *.cmi
	rm -f a.k a.out a.x a.test

force:

###

codebuf.cmo : \
    keiko.cmi \
    codebuf.cmi
codebuf.cmx : \
    keiko.cmx \
    codebuf.cmi
codebuf.cmi : \
    keiko.cmi
expr.cmo : \
    keiko.cmi \
    codebuf.cmi \
    expr.cmi
expr.cmx : \
    keiko.cmx \
    codebuf.cmx \
    expr.cmi
expr.cmi : \
    keiko.cmi
keiko.cmo : \
    keiko.cmi
keiko.cmx : \
    keiko.cmi
keiko.cmi :
lexer.cmo : \
    keiko.cmi \
    lexer.cmi
lexer.cmx : \
    keiko.cmx \
    lexer.cmi
lexer.cmi : \
    keiko.cmi
main.cmo : \
    peepopt.cmi \
    parser.cmi \
    lexer.cmi \
    keiko.cmi \
    codebuf.cmi
main.cmx : \
    peepopt.cmx \
    parser.cmx \
    lexer.cmx \
    keiko.cmx \
    codebuf.cmx
parser.cmo : \
    lexer.cmi \
    keiko.cmi \
    expr.cmi \
    codebuf.cmi \
    parser.cmi
parser.cmx : \
    lexer.cmx \
    keiko.cmx \
    expr.cmx \
    codebuf.cmx \
    parser.cmi
parser.cmi : \
    lexer.cmi \
    keiko.cmi
peepopt.cmo : \
    keiko.cmi \
    peepopt.cmi
peepopt.cmx : \
    keiko.cmx \
    peepopt.cmi
peepopt.cmi : \
    keiko.cmi
