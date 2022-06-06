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
	tintinweb.solidity-visual-auditor \
	tintinweb.vscode-decompiler \
	visual-auditor \
	vspacecode.vspacecode \
	xdebug.php-pack \
	zawys.vscode-as-git-mergetool

include $(CODY)

.PHONY: install
install: | sudo $(HOME)/.config/VSCodium/product.json /usr/bin/codium
/usr/bin/codium:
ifeq ($(PKG_MANAGER),apt-get)
	@wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
		| gpg --dearmor \
		| $(SUDO) dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
	@echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
		| $(SUDO) tee /etc/apt/sources.list.d/vscodium.list
	@$(SUDO) $(APT) update
	@$(SUDO) $(APT) install -y codium
else
	@$(call not_supported,$(NAME))
endif
	@$(MAKE) -s extensions
$(HOME)/.config/VSCodium/product.json:
	@mkdir -p $(HOME)/.config/VSCodium
	@printf $(PRODUCT_JSON) > $@
.PHONY: extensions
extensions:
ifneq (,$(EXTENSIONS))
	@for e in $(EXTENSIONS); do \
		codium --install-extension $$e; \
	done
else
	@true
endif

define PRODUCT_JSON
'{\n\
\t"extensionsGallery": {\n\
\t\t"serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",\n\
\t\t"cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",\n\
\t\t"itemUrl": "https://marketplace.visualstudio.com/items",\n\
\t\t"controlUrl": "",\n\
\t\t"recommendationsUrl": ""\n\
\t}\n\
}'
endef
