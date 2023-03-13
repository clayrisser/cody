NAME := mullvad
DEPENDS_ON :=

include $(CODY)

.PHONY: install
install: | sudo /usr/bin/mullvad
/usr/bin/mullvad:
	@curl -Lo mullvad.deb https://mullvad.net/download/app/deb/latest
	@$(SUDO) dpkg -i mullvad.deb || true
	@$(SUDO) $(APT) install -f -y
	@$(SUDO) dpkg -i mullvad.deb

.PHONY: uninstall
uninstall: ;
