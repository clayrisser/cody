NAME := docker

include ../../cody.mk

.PHONY: install
install: | sudo \
	/bin/podman \
	/bin/docker \
	/bin/docker-compose \
	/usr/local/bin/podman-compose
ifeq ($(PKG_MANAGER),apt-get)
/bin/podman:
	@$(SUDO) $(APT) install -y podman
/bin/docker:
	@$(SUDO) $(APT) install -y docker-ce
	@$(SUDO) usermod -aG docker $(USER)
	@$(SUDO) su -l $(USER)
/bin/docker-compose:
	@$(SUDO) $(APT) install -y docker-compose
else
/bin/podman: not-supported
/bin/docker: not-supported
/bin/docker-compose: not-supported
endif
/usr/local/bin/podman-compose:
	@$(MAKE) -sC ../python install
	@$(SUDO) $(PIP) install podman-compose
