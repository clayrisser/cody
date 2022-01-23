NAME := nodejs
NVM_VERSION ?= 0.39.1

include ../../share.mk

.PHONY: install
install: | sudo /bin/node $(HOME)/.nvm/nvm-exec
/bin/node:
ifeq ($(PKG_MANAGER),apt-get)
	@$(SUDO) $(APT) install -y nodejs
else
	@$(call not_supported,$(NAME))
endif
$(HOME)/.nvm/nvm-exec:
	@curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$(NVM_VERSION)/install.sh | bash
