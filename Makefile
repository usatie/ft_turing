NAME      = ft_turing
OCAML_OPT = ocamlopt
SRCS      = src/main.ml\

CMX_FILES = $(SRCS:%.ml=%.cmx)
CMI_FILES = $(SRCS:%.ml=%.cmi)

all: $(NAME)

$(NAME): $(CMX_FILES)
	$(OCAML_OPT) -o $(NAME) $(CMX_FILES)

%.cmx: %.ml
	$(OCAML_OPT) -c $<

clean:
	$(RM) $(CMX_FILES) $(CMI_FILES)

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all clean fclean re
