NAME := java

include ../../share.mk

.PHONY: install
install: sudo /bin/java
/bin/java:
ifeq ($(PKG_MANAGER),apt-get)
	@$(SUDO) $(APT) install -y openjdk-17-jdk
else
	@$(call not_supported,$(NAME))
endif
