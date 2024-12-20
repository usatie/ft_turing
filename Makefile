NAME      = ft_turing
OCAML_OPT = ocamlopt
OPAM_LIB  = $(shell opam var lib)

YOJSON_DIR = $(OPAM_LIB)/yojson
YOJSON_LIB = $(YOJSON_DIR)/yojson.cmxa
YOJSON_INC = -I $(YOJSON_DIR)

INCLUDES  = -I src $(YOJSON_INC)
SRCS      = src/argparse.ml\
			src/main.ml\

LIBS      = $(YOJSON_LIB)
OBJS      = $(SRCS:%.ml=%.o)
CMX_FILES = $(SRCS:%.ml=%.cmx)
CMI_FILES = $(SRCS:%.ml=%.cmi)

all: check_yojson $(NAME)
	./$(NAME) inputs/unary_sub.json input

$(NAME): $(CMX_FILES)
	$(OCAML_OPT) -o $(NAME) $(LIBS) $(CMX_FILES) 

%.cmx: %.ml
	$(OCAML_OPT) -c $< $(INCLUDES)

clean:
	$(RM) $(OBJS) $(CMX_FILES) $(CMI_FILES)

fclean: clean
	$(RM) $(NAME)

re: fclean all

fmt:
	ocamlformat -i $(SRCS)

check_yojson:
	@if [ ! -d "$(YOJSON_DIR)" ]; then \
		echo "yojson not found. Installing..."; \
		opam install yojson --yes; \
	fi

.PHONY: all clean fclean re fmt check_yojson
