NAME := vscode
DEPENDS_ON :=
CODE_EXTENSIONS := \
	cweijan.vscode-database-client2 \
	eamodio.gitlens \
	editorconfig.editorconfig \
	esbenp.prettier-vscode \
	github.copilot \
	gitlab.gitlab-workflow \
	grapecity.gc-excelviewer \
	gruntfuggly.todo-tree \
	hediet.vscode-drawio \
	mikestead.dotenv \
	ms-vscode.makefile-tools \
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
install: | sudo /usr/bin/code code-extensions
/usr/bin/code:
ifeq ($(PKG_MANAGER),apt-get)
	@wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	@$(SUDO) install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	@$(SUDO) sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	@rm -f packages.microsoft.gpg
	@$(SUDO) apt-get update
	@$(SUDO) apt-get install -y code
else
	@$(call not_supported,$(NAME))
endif

.PHONY: uninstall
uninstall: ;
	@$(SUDO) apt-get remove -y code
