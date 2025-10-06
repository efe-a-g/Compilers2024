all: common.cma

LIB = print.cmo source.cmo growvect.cmo util.cmo

common.cma: $(LIB)
	ocamlc -a $^ -o $@ 

%.cmi: %.mli
	ocamlc -c $< -o $@

%.cmo: %.ml
	ocamlc -c $< -o $@

clean: force
	rm -f *.cmi *.cmo common.cma

ML = growvect.ml growvect.mli print.ml print.mli source.ml source.mli util.ml

depend : $(ML) force
	(sed '/^###/q' Makefile; echo; ocamldep $(ML)) >new
	mv new Makefile

force:

###

growvect.cmo : \
    growvect.cmi
growvect.cmx : \
    growvect.cmi
growvect.cmi :
print.cmo : \
    print.cmi
print.cmx : \
    print.cmi
print.cmi :
source.cmo : \
    print.cmi \
    source.cmi
source.cmx : \
    print.cmx \
    source.cmi
source.cmi : \
    print.cmi
