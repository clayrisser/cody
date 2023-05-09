NAME := nordvpn
DEPENDS_ON :=

include $(CODY)

NORDVPN_BINARY := /usr/bin/nordvpn
ifeq ($(PKG_MANAGER),brew)
NORDVPN_BINARY := /usr/local/bin/nordvpn
endif

.PHONY: install
install: | sudo \
	$(NORDVPN_BINARY)
ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/nordvpn:
	@$(BREW) install --cask nordvpn
else
/usr/bin/nordvpn:
	@curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh | $(SUDO) sh
	@$(SUDO) usermod -aG nordvpn $(USER)
endif

.PHONY: uninstall
uninstall: ;
