.PHONY: all setup-environment wvkbd lisgd

all: setup-environment setup-nvim wvkbd lisgd

setup-environment:
	./scripts/setup-environment

setup-nvim:
	./scripts/setup-nvim

wvkbd:
	./scripts/build-wvkbd

lisgd:
	./scripts/build-lisgd

