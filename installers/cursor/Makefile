NAME := cursor
DEPENDS_ON :=
CODE_EXTENSIONS := \
	ahmadalli.vscode-nginx-conf \
	eamodio.gitlens \
	editorconfig.editorconfig \
	esbenp.prettier-vscode \
	github.copilot \
	gruntfuggly.todo-tree \
	kisstkondoros.vscode-gutter-preview \
	mechatroner.rainbow-csv \
	mikestead.dotenv \
	mkhl.direnv \
	ms-vscode.hexeditor \
	ms-vscode.makefile-tools \
	naumovs.color-highlight \
	psioniq.psi-header \
	redhat.fabric8-analytics \
	redhat.vscode-xml \
	streetsidesoftware.code-spell-checker \
	tintinweb.vscode-decompiler \
	ultram4rine.vscode-choosealicense \
	vspacecode.vspacecode \
	zawys.vscode-as-git-mergetool

include $(CODY)
include $(SHARED)/code/code.mk

CODE_BINARY := /usr/local/bin/code

.PHONY: install
install: | sudo \
	$(CODE_BINARY) \
	code-extensions

ifeq ($(PLATFORM),linux)
ifneq (1,$(IS_WSL))
/usr/local/bin/code:
	@bash ./linux-install.sh
else
/usr/local/bin/code: ;
endif
else
/usr/local/bin/code: not-supported
endif

ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/code:
	@$(BREW) install --cask cursor
endif

.PHONY: uninstall
ifeq ($(PLATFORM),linux)
uninstall: | sudo
	@$(SUDO) rm -f /usr/local/bin/code
else
uninstall: not-supported
endif
