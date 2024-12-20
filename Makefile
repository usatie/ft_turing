NAME      = ft_turing
OCAML_OPT = ocamlopt
INCLUDES  = -I src
SRCS      = src/argparse.ml\
			src/main.ml\


CMX_FILES = $(SRCS:%.ml=%.cmx)
CMI_FILES = $(SRCS:%.ml=%.cmi)

all: $(NAME)
	./$(NAME)

$(NAME): $(CMX_FILES)
	$(OCAML_OPT) -o $(NAME) $(CMX_FILES)

%.cmx: %.ml
	$(OCAML_OPT) -c $< $(INCLUDES)

clean:
	$(RM) $(CMX_FILES) $(CMI_FILES)

fclean: clean
	$(RM) $(NAME)

re: fclean all

fmt:
	ocamlformat -i $(SRCS)

.PHONY: all clean fclean re fmt
