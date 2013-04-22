##
## Makefile
##
## Made by vincent leroy
## Login   <leroy_v@epitech.eu>
##
## Started on  Tue Apr 02 12:23:55 2013 vincent leroy
## Last update Mon Apr 22 20:44:56 2013 vincent leroy
##

ML		= Case.ml \
		  Affichage.ml \
		  main.ml

MLI		= Case.mli \
		  Affichage.mli

NAME		= step1

CFLAGS		=

CMI		= $(MLI:.mli=.cmi)
CMO		= $(ML:.ml=.cmo)
CMX		= $(ML:.ml=.cmx)
OBJ		= $(ML:.ml=.o)

RM		= rm -f

OCAMLC		= ocamlc
OCAMLOPT	= ocamlopt

RESULT		= $(NAME)
SOURCES		= $(ML)
LIBS		= bigarray sdl
INCDIRS		= +sdl

include OCamlMakefile

all: $(NAME)

$(NAME): $(CMI) $(CMX)
	$(OCAMLOPT) $(CMX) -o $(NAME)

native: $(CMI) $(CMX)
	$(OCAMLOPT) $(CMX) -o $(NAME)

byte: $(CMI) $(CMO)
	$(OCAMLC) $(CMO) -o $(NAME)

clean:
	$(RM) $(CMI) $(CMO) $(CMX) $(OBJ)

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all native byte clean fclean re

.SUFFIXES: .mli .ml .cmi .cmo .cmx .o

.mli.cmi:
	$(OCAMLC) -c $(CFLAGS) $<

.ml.cmo:
	$(OCAMLC) -c $(CFLAGS) $<

.ml.cmx:
	$(OCAMLOPT) -c $(CFLAGS) $<

.ml.o:
	$(OCAMLOPT) -c $(CFLAGS) $<
