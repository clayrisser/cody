NAME := nodejs
NVM_VERSION ?= 0.39.1

include ../../share.mk

.PHONY: install
install: | sudo \
	/usr/bin/node \
	/usr/bin/npm \
	/usr/local/bin/yarn \
	$(HOME)/.nvm/nvm-exec
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
	@curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$(NVM_VERSION)/install.sh | bash
