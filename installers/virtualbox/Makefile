NAME := virtualbox
DEPENDS_ON :=

include $(CODY)

.PHONY: install
ifeq ($(PKG_MANAGER),brew)
install: | /usr/local/bin/virtualbox
else
install: | sudo \
	/usr/bin/virtualbox
endif

ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/virtualbox:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y virtualbox
else

ifeq ($(PKG_MANAGER),brew)
/usr/bin/virtualbox:
	@$(BREW) install --cask virtualbox
endif

/usr/bin/virtualbox: not-supported
endif
