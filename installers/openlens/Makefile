NAME := openlens
DEPENDS_ON :=
OPENLENS_VERSION := 6.4.7

include $(CODY)

.PHONY: install
install: | sudo \
	/usr/bin/openlens
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/openlens:
	@$(call apt-update)
	@curl -Lo $(_TMP_PATH)/openlens.deb https://github.com/MuhammedKalkan/OpenLens/releases/download/v$(OPENLENS_VERSION)/OpenLens-$(OPENLENS_VERSION).amd64.deb
	@$(SUDO) dpkg -i $(_TMP_PATH)/openlens.deb || true
	@$(SUDO) $(APT) install -f
	@$(SUDO) dpkg -i $(_TMP_PATH)/openlens.deb
else
/usr/bin/openlens: not-supported
endif

.PHONY: uninstall
uninstall:
ifeq ($(PKG_MANAGER),apt-get)
	@$(SUDO) $(APT) remove -y openlens
	@$(SUDO) $(APT) autoremove
endif
