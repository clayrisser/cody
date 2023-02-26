NAME := dbgate
DEPENDS_ON :=

include $(CODY)

.PHONY: install
install: | sudo \
	/usr/bin/dbgate
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/dbgate:
	@$(call apt-update)
	@curl -Lo $(_TMP_PATH)/dbgate.deb https://github.com/dbgate/dbgate/releases/latest/download/dbgate-latest.deb
	@$(SUDO) dpkg -i $(_TMP_PATH)/dbgate.deb || true
	@$(SUDO) $(APT) install -f
	@$(SUDO) dpkg -i $(_TMP_PATH)/dbgate.deb
else
/usr/bin/dbgate: not-supported
endif

.PHONY: uninstall
ifeq ($(PKG_MANAGER),apt-get)
uninstall: | sudo
	@$(SUDO) $(APT) remove -y dbgate
	@$(SUDO) $(APT) autoremove -y
else
uninstall: not-supported
endif
