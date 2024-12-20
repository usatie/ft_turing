NAME     = ft_turing
OCAMLC   = ocamlopt
SRCS     = src/main.ml\

OBJS     = $(SRCS:%.ml=%.o)

all: $(NAME)

$(NAME): $(OBJS)
	$(OCAMLC) -o $(NAME) $(OBJS)

%.o: %.ml
	$(OCAMLC) -c $<

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all clean fclean re

# Install ocaml if not installed
# Needs to be run on both mac/Linux
ifeq ($(OS),Windows_NT)
	OSFLAG = WIN32
else
	OSFLAG = $(shell uname)
endif

ifeq ($(OSFLAG), Darwin)
	# Mac OSX
	OCAML = $(shell which ocaml)
else
	# Linux
	OCAML = $(shell which ocaml)
endif

install:
	@echo "Installing OPAM"
ifeq ($(OCAML),)
ifeq ($(OSFLAG), Darwin)
	brew install opam
else
	sudo apt-get install ocaml
endif
endif
	@echo "Initializing OPAM"
	opam init -y
