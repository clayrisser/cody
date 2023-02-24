NAME := codium
DEPENDS_ON := \

EXTENSIONS := \
	RemixProject.ethereum-remix \
	amodio.tsl-problem-matcher \
	azblockchain.azure-blockchain \
	bbenoist.nix \
	bungcip.better-toml \
	cweijan.vscode-database-client2 \
	dawidd6.debian-vscode \
	dbaeumer.vscode-eslint \
	eamodio.gitlens \
	editorconfig.editorconfig \
	esbenp.prettier-vscode \
	github.copilot \
	gitlab.gitlab-workflow \
	golang.go \
	grapecity.gc-excelviewer \
	gruntfuggly.todo-tree \
	hashicorp.terraform \
	hediet.vscode-drawio \
	juanblanco.solidity \
	mikestead.dotenv \
	ms-azuretools.vscode-docker \
	ms-kubernetes-tools.vscode-kubernetes-tools \
	ms-python.python \
	ms-vscode.cpptools \
	ms-vscode.makefile-tools \
	prisma.prisma \
	psioniq.psi-header \
	rebornix.ruby \
	redhat.fabric8-analytics \
	redhat.java \
	redhat.vscode-xml \
	rubymaniac.vscode-direnv \
	rust-lang.rust \
	streetsidesoftware.code-spell-checker \
	timkmecl.codegpt3 \
	tintinweb.solidity-visual-auditor \
	tintinweb.vscode-decompiler \
	ultram4rine.vscode-choosealicense \
	visual-auditor \
	vspacecode.vspacecode \
	xdebug.php-pack \
	zawys.vscode-as-git-mergetool

include $(CODY)

.PHONY: install
install: | sudo /usr/bin/code
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
	@$(MAKE) -s extensions

.PHONY: extensions
extensions:
ifneq (,$(EXTENSIONS))
	@for e in $(EXTENSIONS); do \
		code --install-extension $$e; \
	done
else
	@true
endif

.PHONY: uninstall
uninstall: ;
	@$(SUDO) apt-get remove -y code
