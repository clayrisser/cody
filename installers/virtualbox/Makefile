NAME := virtualbox
DEPENDS_ON :=

include $(CODY)

.PHONY: install
install: | sudo \
	/usr/bin/virtualbox
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/virtualbox:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y virtualbox
else
/usr/bin/virtualbox: not-supported
endif
