NAME := cpp
DEPENDS_ON := \
	vscode
CODE_EXTENSIONS := \
	ms-vscode.cpptools

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: | sudo \
	/usr/bin/gcc \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/gcc:
	@$(SUDO) $(APT) install -y build-essential
else
/usr/bin/gcc: not-supported
endif

.PHONY: uninstall
ifeq ($(PKG_MANAGER),apt-get)
uninstall: | sudo
	@$(SUDO) $(APT) uninstall -y brave-browser
	@$(SUDO) $(APT) autoremove -y
else
uninstall: not-supported
endif