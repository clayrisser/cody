NAME := flatpak
DEPENDS_ON :=

include $(CODY)

.PHONY: install
install: | sudo /usr/bin/flatpak
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/flatpak:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y flatpak
else
/usr/bin/flatpak: not-supported
endif

.PHONY: uninstall
uninstall:
