NAME := java
DEPENDS_ON := \
	vscode
CODE_EXTENSIONS := \
	redhat.java

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: | sudo \
	/bin/java \
	/usr/bin/mvn \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/bin/java:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y openjdk-17-jdk
/usr/bin/mvn:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y maven
else
/bin/java: not-supported
/usr/bin/mvn: not-supported
endif

.PHONY: uninstall
uninstall: ;
