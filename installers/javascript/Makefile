NAME := javascript
DEPENDS_ON := \
	vscode
CODE_EXTENSIONS := \
	amodio.tsl-problem-matcher \
	dbaeumer.vscode-eslint \
	prisma.prisma

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: | sudo \
	/usr/bin/node \
	/usr/bin/npm \
	/usr/local/bin/yarn \
	$(HOME)/.nvm/nvm-exec \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/node:
	@$(SUDO) $(APT) install -y nodejs
/usr/bin/npm:
	@$(SUDO) $(APT) install -y npm
else
/usr/bin/node: not-supported
/usr/bin/npm: not-supported
endif
/usr/local/bin/yarn:
	@$(SUDO) /usr/bin/npm install -g yarn
$(HOME)/.nvm/nvm-exec:
	@curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

.PHONY: uninstall
ifeq ($(PKG_MANAGER),apt-get)
uninstall: | sudo
	-@$(SUDO) /usr/bin/npm uninstall -g yarn
	@$(SUDO) $(APT) remove -y nodejs npm
	@$(SUDO) $(APT) autoremove -y
	@rm -rf $(HOME)/.nvm
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
else
uninstall: not-supported
endif
