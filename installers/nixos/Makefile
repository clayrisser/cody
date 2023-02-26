NAME := nixos
DEPENDS_ON :=
CODE_EXTENSIONS := \
	bbenoist.nix

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: | sudo \
	/nix/var/nix/gc.lock \
	code-extensions
/nix/var/nix/gc.lock:
	@curl -L https://nixos.org/nix/install | sh
