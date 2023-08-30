NAME := java
DEPENDS_ON :=
CODE_EXTENSIONS := \
	redhat.java \
	vscjava.vscode-java-pack \
	vscjava.vscode-spring-initializr \
	wmanth.jar-viewer

include $(CODY)
include $(SHARED)/code/code.mk

DEPENDS_ON += $(CODE_INSTALLER)

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
ifeq ($(PKG_MANAGER),brew)
/bin/java:
	@$(BREW) install openjdk
/usr/bin/mvn:
	@$(BREW) install maven
/usr/bin/gradle:
	@$(BREW) install gradle
else
/bin/java: not-supported
/usr/bin/gradle: not-supported
/usr/bin/mvn: not-supported
endif
endif

.PHONY: uninstall
uninstall: ;
