NAME := debian
DEPENDS_ON := \
	core \
	python
CODE_EXTENSIONS := \
	dawidd6.debian-vscode

include $(CODY)
include $(SHARED)/code/code.mk

DEPENDS_ON += $(CODE_INSTALLER)

ifneq (1,$(IS_WSL))
DEPENDS_ON += virtualbox
endif

.PHONY: install
install: | sudo \
	/usr/bin/apt-file \
	/usr/bin/live-build \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/live-build:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y live-build
/usr/bin/apt-file:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y apt-file
	@$(SUDO) apt-file update
else
/usr/bin/live-build: not-supported
/usr/bin/apt-file: not-supported
endif

.PHONY: uninstall
uninstall: ;
