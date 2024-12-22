NAME      = ft_turing
OCAML_OPT = ocamlopt
OPAM_LIB  = $(shell opam var lib)

YOJSON_DIR = $(OPAM_LIB)/yojson
YOJSON_LIB = $(YOJSON_DIR)/yojson.cmxa
YOJSON_INC = -I $(YOJSON_DIR)

INCLUDES  = -I src $(YOJSON_INC)
SRCS_MLI  = src/types.mli\
			src/json_parser.mli\
			src/printer.mli\

SRCS      = src/argparse.ml\
			src/types.ml\
			src/json_parser.ml\
			src/printer.ml\
			src/turing_machine.ml\
			src/main.ml\

LIBS      = $(YOJSON_LIB)
OBJS      = $(SRCS:%.ml=%.o)
CMX_FILES = $(SRCS:%.ml=%.cmx)
CMI_FILES = $(SRCS_MLI:%.mli=%.cmi)

all: check_yojson $(NAME)
	./$(NAME) inputs/unary_sub.json input

$(NAME): $(CMX_FILES)
	$(OCAML_OPT) -o $(NAME) $(LIBS) $(CMX_FILES) 

%.cmi: %.mli
	$(OCAML_OPT) -c $< $(INCLUDES)

%.cmx: %.ml %.cmi
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

test:
	./$(NAME) inputs/unary_sub.json input && echo "Test passed" || echo "Test failed"
	./$(NAME) inputs/invalid.json input && echo "Test failed" || echo "Test passed"
	./$(NAME) nosuchfile input && echo "Test failed" || echo "Test passed"
	./$(NAME) inputs/invalid-action.json input && echo "Test failed" || echo "Test passed"

.PHONY: all clean fclean re fmt check_yojson
