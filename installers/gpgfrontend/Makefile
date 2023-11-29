NAME := gpgfrontend
DEPENDS_ON :=

include $(CODY)

GPGFRONTEND_BINARY := $(HOME)/Applications/GpgFrontend
ifeq ($(PKG_MANAGER),brew)
GPGFRONTEND_BINARY := /Applications/gpgfrontend/Contents/Info.plist
endif

.PHONY: install
install: | sudo \
	$(GPGFRONTEND_BINARY)

ifeq ($(PLATFORM),linux)
ifneq (1,$(IS_WSL))
$(HOME)/Applications/GpgFrontend:
	@bash ./linux-install.sh
else
/usr/local/bin/code: ;
endif
endif

ifeq ($(PKG_MANAGER),brew)
/Applications/gpgfrontend/Contents/Info.plist:
	@$(BREW) install --cask gpgfrontend
endif

.PHONY: uninstall
uninstall: not-supported
