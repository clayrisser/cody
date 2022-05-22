NAME := flatpak

include ../../cody.mk

.PHONY: install
install: | sudo /usr/bin/flatpak
/usr/bin/flatpak:
ifeq ($(PKG_MANAGER),apt-get)
	@$(SUDO) $(APT) install -y flatpak
else
	@$(call not_supported,$(NAME))
endif
