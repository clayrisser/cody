NAME := debian
DEPENDS_ON := \
	vscode
CODE_EXTENSIONS := \
	dawidd6.debian-vscode \

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: | sudo \
	/usr/bin/live-build \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/live-build:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y live-build
/usr/bin/convert:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y imagemagick
else
/usr/bin/live-build: not-supported
endif

.PHONY: uninstall
uninstall: ;
