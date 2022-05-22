NAME := rust
DEPENDS_ON := \

include $(CODY)

.PHONY: install
install: | sudo $(HOME)/.cargo/bin/cargo
$(HOME)/.cargo/bin/cargo:
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > $${XDG_RUNTIME_DIR:-/tmp}/rustup.sh && \
		sh $${XDG_RUNTIME_DIR:-/tmp}/rustup.sh -y
