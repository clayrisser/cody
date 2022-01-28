NAME := java

include ../../share.mk

.PHONY: install
install: | sudo \
	/bin/java \
	/bin/maven
ifeq ($(PKG_MANAGER),apt-get)
/bin/java:
	@$(SUDO) $(APT) install -y openjdk-17-jdk
/bin/maven:
	@$(SUDO) $(APT) install -y maven
else
/bin/java: not-supported
/bin/maven: not-supported
endif
