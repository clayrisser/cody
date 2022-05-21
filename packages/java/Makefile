NAME := java

include ../../share.mk

.PHONY: install
install: | sudo \
	/bin/java \
	/usr/bin/mvn
ifeq ($(PKG_MANAGER),apt-get)
/bin/java:
	@$(SUDO) $(APT) install -y openjdk-17-jdk
/usr/bin/mvn:
	@$(SUDO) $(APT) install -y maven
else
/bin/java: not-supported
/usr/bin/mvn: not-supported
endif
