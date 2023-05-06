NAME := vscode
DEPENDS_ON :=
CODE_EXTENSIONS := \
	eamodio.gitlens \
	editorconfig.editorconfig \
	esbenp.prettier-vscode \
	github.copilot \
	gitlab.gitlab-workflow \
	grapecity.gc-excelviewer \
	gruntfuggly.todo-tree \
	hediet.vscode-drawio \
	mechatroner.rainbow-csv \
	mikestead.dotenv \
	ms-vscode.hexeditor \
	ms-vscode.makefile-tools \
	naumovs.color-highlight \
	psioniq.psi-header \
	redhat.fabric8-analytics \
	redhat.vscode-xml \
	rubymaniac.vscode-direnv \
	streetsidesoftware.code-spell-checker \
	timkmecl.codegpt3 \
	tintinweb.vscode-decompiler \
	ultram4rine.vscode-choosealicense \
	vspacecode.vspacecode \
	zawys.vscode-as-git-mergetool

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: | sudo \
	/usr/bin/code \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
ifneq $(1,$(IS_WSL))
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

.PHONY: uninstall
ifeq ($(PKG_MANAGER),apt-get)
uninstall: | sudo
	@$(SUDO) $(APT) uninstall -y code
else
uninstall: not-supported
endif
