NAME := java
DEPENDS_ON :=
CODE_EXTENSIONS := \
	redhat.java \
	wmanth.jar-viewer

include $(CODY)
include $(SHARED)/code/code.mk

DEPENDS_ON += $(CODE)

.PHONY: install
install: | sudo \
	/bin/java \
	/usr/bin/gradle \
	/usr/bin/mvn \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/bin/java:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y openjdk-17-jdk
/usr/bin/mvn:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y maven
/usr/bin/gradle:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y gradle
else
/bin/java: not-supported
/usr/bin/mvn: not-supported
endif

.PHONY: uninstall
uninstall: ;
