NAME := dbgate
DEPENDS_ON :=

include $(CODY)

DBGATE_BINARY := /usr/bin/dbgate
ifeq ($(PKG_MANAGER),brew)
DBGATE_BINARY := /usr/local/bin/dbgate
endif

.PHONY: install
install: | smart-sudo \
	$(DBGATE_BINARY)

ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/dbgate:
	@$(call apt-update)
	@curl -Lo $(_TMP_PATH)/dbgate.deb https://github.com/dbgate/dbgate/releases/latest/download/dbgate-latest.deb
	@$(SUDO) dpkg -i $(_TMP_PATH)/dbgate.deb || true
	@$(SUDO) $(APT) install -f
	@$(SUDO) dpkg -i $(_TMP_PATH)/dbgate.deb
else
ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/dbgate:
	@$(BREW) install --cask dbgate
endif
/usr/bin/dbgate: not-supported
endif

.PHONY: uninstall
uninstall:
ifeq ($(PKG_MANAGER),apt-get)
	@$(SUDO) $(APT) remove -y dbgate
	@$(SUDO) $(APT) autoremove
endif
