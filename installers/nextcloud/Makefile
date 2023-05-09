NAME := nextcloud
DEPENDS_ON :=

include $(CODY)

.PHONY: install
ifeq ($(PKG_MANAGER),brew)
install: | sudo \
	/Applications/Nextcloud.app/Contents/Info.plist
else
install: | sudo \
	/usr/bin/nextcloud
endif

ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/nextcloud:
	@echo 'NOT IMPLEMENTED' && exit 1
else

ifeq ($(PKG_MANAGER),brew)
/Applications/Nextcloud.app/Contents/Info.plist:
	@$(BREW) install --cask nextcloud
endif

/usr/bin/nextcloud: not-supported
endif

.PHONY: uninstall
uninstall: ;
