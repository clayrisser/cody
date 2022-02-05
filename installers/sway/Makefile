NAME := sway

include ../../share.mk

.PHONY: install
install: | sudo \
	/bin/sway \
	/usr/local/bin/bumblebee-status \
	/bin/pipewire
ifeq ($(PKG_MANAGER),apt-get)
/bin/sway:
	@$(SUDO) $(APT) install -y \
		rofi \
		sway
	@$(SUDO) sed -i 's|Exec=sway|Exec=/bin/bash \-l \-c sway|g' \
		/usr/share/wayland-sessions/sway.desktop
/bin/pipewire:
	@$(SUDO) $(APT) install -y \
		libpipewire-0.3-0 \
		pipewire \
		xdg-desktop-portal-wlr
else
/bin/sway: not-supported
/bin/pipewire: not-supported
endif
/usr/local/bin/bumblebee-status:
	@$(MAKE) -sC ../python install
	@$(SUDO) $(PIP) install bumblebee-status
