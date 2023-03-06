NAME := codium
DEPENDS_ON :=
CODE_EXTENSIONS := \
	cweijan.vscode-database-client2 \
	eamodio.gitlens \
	editorconfig.editorconfig \
	esbenp.prettier-vscode \
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
install: | sudo \
	$(HOME)/.config/VSCodium/product.json \
	/usr/bin/codium \
	code-extensions
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
$(HOME)/.config/VSCodium/product.json:
	@mkdir -p $(HOME)/.config/VSCodium
	@printf $(PRODUCT_JSON) > $@

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

.PHONY: uninstall
uninstall: ;
