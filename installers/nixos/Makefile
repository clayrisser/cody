NAME := nixos
DEPENDS_ON :=
CODE_EXTENSIONS := \
	bbenoist.nix

include $(CODY)
include $(SHARED)/code/code.mk

DEPENDS_ON += $(CODE_INSTALLER)

.PHONY: install
install: | sudo \
	/nix/var/nix/gc.lock \
	code-extensions
/nix/var/nix/gc.lock:
ifeq ($(PLATFORM),darwin)
	@curl -L https://nixos.org/nix/install | sh
else
ifeq (1,$(IS_WSL))
	@curl -L https://nixos.org/nix/install | sh -s --no-daemon
else
	@curl -L https://nixos.org/nix/install | sh -s --daemon
endif
endif
