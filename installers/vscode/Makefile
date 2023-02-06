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
	eg2.vscode-npm-script \
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
	@curl -Lo vscode.deb https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
	@$(SUDO) dpkg -i vscode.deb
	@$(SUDO) apt-get install -f
	@$(SUDO) dpkg -i vscode.deb
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
