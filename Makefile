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

all:
	@echo "OCAML: $(OCAML)"
	@echo "OSFLAG: $(OSFLAG)"

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
