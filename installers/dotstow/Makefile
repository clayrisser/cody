NAME := dotstow
DEPENDS_ON :=

include $(CODY)

.PHONY: install
install: | sudo \
	/usr/bin/stow \
	/usr/local/bin/dotstow
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/stow:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y stow
else
/usr/bin/stow: not-supported
endif
/usr/local/bin/dotstow:
	@$$(curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) \
		https://gitlab.com/risserlabs/community/dotstow/-/raw/main/install.sh 2>/dev/null | $(SUDO) sh

.PHONY: uninstall
uninstall: | sudo
	-@$(SUDO) rm -f /usr/local/bin/dotstow
