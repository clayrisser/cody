NAME := openlens
DEPENDS_ON :=
OPENLENS_VERSION := 6.4.7

include $(CODY)

.PHONY: install
ifeq ($(PKG_MANAGER),brew)
install: | /Applications/OpenLens.app/Contents/Info.plist
else
install: | sudo \
	/usr/bin/openlens
endif
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/openlens:
	@$(call apt-update)
	@curl -Lo $(_TMP_PATH)/openlens.deb https://github.com/MuhammedKalkan/OpenLens/releases/download/v$(OPENLENS_VERSION)/OpenLens-$(OPENLENS_VERSION).amd64.deb
	@$(SUDO) dpkg -i $(_TMP_PATH)/openlens.deb || true
	@$(SUDO) $(APT) install -f
	@$(SUDO) dpkg -i $(_TMP_PATH)/openlens.deb
else

ifeq ($(PKG_MANAGER),brew)
/Applications/OpenLens.app/Contents/Info.plist:
	@$(BREW) install --cask $(@F)
endif

/usr/bin/openlens: not-supported
endif

.PHONY: uninstall
uninstall:
ifeq ($(PKG_MANAGER),apt-get)
	@$(SUDO) $(APT) remove -y openlens
	@$(SUDO) $(APT) autoremove
endif
