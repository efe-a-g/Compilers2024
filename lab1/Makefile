# lab1/Makefile

## Add your own test cases to this list
TEST = gcd repeat loop case

KEIKO = ../keiko
LIB = ../lib

all: ppc1

PPC = keiko.cmo lexer.cmo tree.cmo parser.cmo peepopt.cmo kgen.cmo main.cmo

ppc1: $(LIB)/common.cma $(PPC)
	ocamlc $^ -o $@ 

parser.mli parser.ml: parser.mly
	ocamlyacc -v parser.mly

lexer.ml: lexer.mll
	ocamllex lexer.mll

tree.cmo: MLFLAGS += -w u

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

ML = keiko.ml keiko.mli kgen.ml kgen.mli lexer.mli \
	lexer.ml main.ml parser.mli parser.ml tree.ml tree.mli \
	peepopt.mli peepopt.ml

depend : $(ML) force
	(sed '/^###/q' Makefile; echo; ocamldep $(ML)) >new
	mv new Makefile

realclean: clean


# CLEANUP

clean: force
	rm -f ppc1 *.cma *.cmo *.cmi
	rm -f parser.mli parser.ml lexer.ml parser.output
	rm -f a.k a.out a.x a.test

force:

###

keiko.cmo : \
    keiko.cmi
keiko.cmx : \
    keiko.cmi
keiko.cmi :
kgen.cmo : \
    tree.cmi \
    peepopt.cmi \
    keiko.cmi \
    kgen.cmi
kgen.cmx : \
    tree.cmx \
    peepopt.cmx \
    keiko.cmx \
    kgen.cmi
kgen.cmi : \
    tree.cmi
lexer.cmo : \
    tree.cmi \
    parser.cmi \
    keiko.cmi \
    lexer.cmi
lexer.cmx : \
    tree.cmx \
    parser.cmx \
    keiko.cmx \
    lexer.cmi
lexer.cmi : \
    tree.cmi \
    parser.cmi
main.cmo : \
    tree.cmi \
    parser.cmi \
    lexer.cmi \
    kgen.cmi
main.cmx : \
    tree.cmx \
    parser.cmx \
    lexer.cmx \
    kgen.cmx
parser.cmo : \
    tree.cmi \
    lexer.cmi \
    keiko.cmi \
    parser.cmi
parser.cmx : \
    tree.cmx \
    lexer.cmx \
    keiko.cmx \
    parser.cmi
parser.cmi : \
    tree.cmi \
    keiko.cmi
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
    tree.cmi
tree.cmx : \
    keiko.cmx \
    tree.cmi
tree.cmi : \
    keiko.cmi
