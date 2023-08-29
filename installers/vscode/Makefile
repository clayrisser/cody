NAME := vscode
DEPENDS_ON :=
CODE_EXTENSIONS := \
	ahmadalli.vscode-nginx-conf \
	eamodio.gitlens \
	editorconfig.editorconfig \
	esbenp.prettier-vscode \
	github.copilot \
	gitlab.gitlab-workflow \
	gruntfuggly.todo-tree \
	kisstkondoros.vscode-gutter-preview \
	mechatroner.rainbow-csv \
	mikestead.dotenv \
	mkhl.direnv \
	ms-vscode.hexeditor \
	tamasfe.even-better-toml \
	naumovs.color-highlight \
	psioniq.psi-header \
	redhat.fabric8-analytics \
	redhat.vscode-xml \
	rubberduck.rubberduck-vscode \
	streetsidesoftware.code-spell-checker \
	vspacecode.vspacecode \
	zawys.vscode-as-git-mergetool

CODE_FLAVOR := cursor # visual-studio-code,codium

include $(CODY)
include $(SHARED)/code/code.mk

CODE_BINARY := /usr/bin/code
ifeq ($(PKG_MANAGER),brew)
CODE_BINARY := /usr/local/bin/code
endif

.PHONY: install
install: | sudo \
	$(CODE_BINARY) \
	code-extensions

ifeq ($(PKG_MANAGER),apt-get)
ifneq (1,$(IS_WSL))
/usr/bin/code:
	@$(call apt-update)
	@wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > $(_TMP_PATH)/packages.microsoft.gpg
	@$(SUDO) install -D -o root -g root -m 644 $(_TMP_PATH)/packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	@$(SUDO) sh -c 'echo "deb [arch=$(ARCH) signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	@$(SUDO) $(APT) update
	@$(SUDO) $(APT) install -y code
else
/usr/bin/code: ;
endif
else
/usr/bin/code: not-supported
endif

ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/code:
	@$(BREW) install --cask $(CODE_FLAVOR)
endif

.PHONY: uninstall
ifeq ($(PKG_MANAGER),apt-get)
uninstall: | sudo
	@$(BREW) uninstall $(CODE_FLAVOR)
else
uninstall: not-supported
endif
