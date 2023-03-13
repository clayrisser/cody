NAME := nordvpn
DEPENDS_ON :=

include $(CODY)

.PHONY: install
install: | sudo /usr/bin/nordvpn
/usr/bin/nordvpn:
	@curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh | $(SUDO) sh
	@$(SUDO) usermod -aG nordvpn $(USER)

.PHONY: uninstall
uninstall: ;
