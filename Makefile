.PHONY: all setup-environment wvkbd lisgd

all: setup-environment wvkbd lisgd

setup-environment:
	./scripts/setup-environment

wvkbd:
	./scripts/build-wvkbd

lisgd:
	./scripts/build-lisgd

