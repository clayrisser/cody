NAME := rust
DEPENDS_ON := \
	vscode
VSCODE_EXTENSIONS := \
	rust-lang.rust \

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: | sudo $(HOME)/.cargo/bin/cargo code-extensions
$(HOME)/.cargo/bin/cargo:
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > $${XDG_RUNTIME_DIR:-/tmp}/rustup.sh && \
		sh $${XDG_RUNTIME_DIR:-/tmp}/rustup.sh -y
