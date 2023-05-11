NAME := javascript
DEPENDS_ON :=
CODE_EXTENSIONS := \
	amodio.tsl-problem-matcher \
	dbaeumer.vscode-eslint \
	prisma.prisma

include $(CODY)
include $(SHARED)/code/code.mk

DEPENDS_ON += $(CODE_INSTALLER)

.PHONY: install
ifeq ($(PKG_MANAGER),brew)
install: | /usr/local/bin/node \
	/usr/local/bin/yarn \
	/usr/local/bin/yarn2init \
	$(HOME)/.nvm/nvm-exec \
	code-extensions
else
install: | sudo \
	/usr/bin/node \
	/usr/bin/npm \
	/usr/local/bin/yarn \
	/usr/local/bin/yarn2init \
	$(HOME)/.nvm/nvm-exec \
	code-extensions
endif

ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/node:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y nodejs
/usr/bin/npm:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y npm
/usr/local/bin/yarn:
	@$(SUDO) /usr/bin/npm install -g yarn
else

ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/node:
	@$(BREW) install nodejs
/usr/local/bin/npm:
	@$(BREW) install npm
/usr/local/bin/yarn:
	@$(BREW) install yarn
else
/usr/local/bin/yarn:
	@$(SUDO) /usr/bin/npm install -g yarn
endif

/usr/bin/node: not-supported
/usr/bin/npm: not-supported
endif
$(HOME)/.nvm/nvm-exec:
	@curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
/usr/local/bin/yarn2init:
	@cd $(_TMP_PATH) && \
		curl -L -o yarn2init.tar.gz \
			https://gitlab.com/risserlabs/community/yarn2init/-/archive/main/yarn2init-main.tar.gz && \
		tar -xzf yarn2init.tar.gz && \
		cd yarn2init-main && \
		$(SUDO) make install

.PHONY: uninstall
uninstall: | sudo
	-@$(SUDO) /usr/bin/npm uninstall -g yarn
	-@$(SUDO) rm -f /usr/local/bin/yarn2init
	-@rm -rf $(HOME)/.nvm
ifneq (,$(wildcard $(HOME)/.bashrc))
	@sed -i '/^export NVM_DIR=.*/d' $(HOME)/.bashrc
	@sed -i '/^\[ -s "$$NVM_DIR\/nvm.sh" \].*/d' $(HOME)/.bashrc
	@sed -i '/^\[ -s "$$NVM_DIR\/bash_completion" \].*/d' $(HOME)/.bashrc
endif
ifneq (,$(wildcard $(HOME)/.zshrc))
	@sed -i '/^export NVM_DIR=.*/d' $(HOME)/.zshrc
	@sed -i '/^\[ -s "$$NVM_DIR\/nvm.sh" \].*/d' $(HOME)/.zshrc
	@sed -i '/^\[ -s "$$NVM_DIR\/bash_completion" \].*/d' $(HOME)/.zshrc
endif
