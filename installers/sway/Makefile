NAME := sway

include ../../share.mk

.PHONY: install
install: | sudo /bin/sway /usr/local/bin/bumblebee-status
ifeq ($(PKG_MANAGER),apt-get)
/bin/sway:
	@$(SUDO) $(APT) install -y \
		rofi \
		sway
else
/bin/sway: not-supported
endif
/usr/local/bin/bumblebee-status:
	@$(MAKE) -sC ../python install
	@$(SUDO) $(PIP) install bumblebee-status
