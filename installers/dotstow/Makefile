NAME := dotstow
DEPENDS_ON :=

include $(CODY)

STOW_BINARY := /usr/bin/stow
ifeq ($(PKG_MANAGER),brew)
STOW_BINARY := /usr/local/bin/stow
endif

.PHONY: install
install: | sudo \
	$(STOW_BINARY) \
	/usr/local/bin/dotstow

ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/stow:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y stow
else

ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/stow:
	@$(BREW) install $(@F)
endif
/usr/bin/stow: not-supported
endif

/usr/local/bin/dotstow:
	@$$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) \
		https://gitlab.com/risserlabs/community/dotstow/-/raw/main/install.sh 2>/dev/null | $(SUDO) sh

.PHONY: uninstall
uninstall: | sudo
	-@$(SUDO) rm -f /usr/local/bin/dotstow
