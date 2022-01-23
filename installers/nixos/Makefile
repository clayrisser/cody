NAME := nixos

include ../../share.mk

.PHONY: install
install: sudo /nix/var/nix/gc.lock
/nix/var/nix/gc.lock:
	@curl -L https://nixos.org/nix/install | sh
