NAME := codium
DEPENDS_ON :=
CODE_EXTENSIONS := \
	ahmadalli.vscode-nginx-conf \
	dotenv.dotenv-vscode \
	eamodio.gitlens \
	editorconfig.editorconfig \
	esbenp.prettier-vscode \
	gitlab.gitlab-workflow \
	grapecity.gc-excelviewer \
	gruntfuggly.todo-tree \
	hediet.vscode-drawio \
	mechatroner.rainbow-csv \
	mkhl.direnv \
	ms-vscode.hexeditor \
	ms-vscode.makefile-tools \
	naumovs.color-highlight \
	psioniq.psi-header \
	redhat.fabric8-analytics \
	redhat.vscode-xml \
	rubberduck.rubberduck-vscode \
	streetsidesoftware.code-spell-checker \
	tabnine.tabnine-vscode \
	ultram4rine.vscode-choosealicense \
	vspacecode.vspacecode

include $(CODY)
include $(SHARED)/code/code.mk

CODIUM_BINARY := /usr/bin/codium
ifeq ($(PKG_MANAGER),brew)
CODIUM_BINARY := /usr/local/bin/codium
endif

.PHONY: install
install: | sudo \
	$(HOME)/.config/VSCodium/product.json \
	$(CODIUM_BINARY) \
	code-extensions

ifeq ($(PKG_MANAGER),apt-get)
ifeq (1,$(IS_WSL))
/usr/bin/codium: ;
else
/usr/bin/codium:
	@wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
		| gpg --dearmor \
		| $(SUDO) dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
	@echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
		| $(SUDO) tee /etc/apt/sources.list.d/vscodium.list
	@$(SUDO) $(APT) update
	@$(SUDO) $(APT) install -y codium
endif
else
/usr/bin/codium: not-supported
endif

ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/codium:
	@$(BREW) install --cask codium
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
