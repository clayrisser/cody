NAME := waydroid
DEPENDS_ON :=

include $(CODY)

.PHONY: install
install: | sudo /usr/bin/waydroid
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/waydroid:
	@curl https://repo.waydro.id | $(SUDO) bash
	@$(SUDO) $(APT) install -y waydroid
else
/usr/bin/waydroid: not-supported
endif

.PHONY: uninstall
uninstall: ;
