NAME := brave

include ../../share.mk

.PHONY: install
install: | sudo /usr/bin/brave-browser
/usr/bin/brave-browser:
ifeq ($(PKG_MANAGER),apt-get)
	@$(SUDO) curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
		https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	@echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | \
		$(SUDO) tee /etc/apt/sources.list.d/brave-browser-release.list
	@$(SUDO) $(APT) update
	@$(SUDO) $(APT) install -y brave-browser
else
	@$(call not_supported,$(NAME))
endif
