NAME := docker

include ../../share.mk

.PHONY: install
install: sudo /bin/docker
/bin/docker:
ifeq ($(PKG_MANAGER),apt-get)
	@$(SUDO) $(APT) install -y docker-ce
	@$(SUDO) usermod -aG docker $(USER)
	@$(SUDO) su -l $(USER)
else
	@$(call not_supported,$(NAME))
endif
