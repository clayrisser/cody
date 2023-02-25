NAME := docker
DEPENDS_ON := \
	python \
	vscode
CODE_EXTENSIONS := \
	ms-azuretools.vscode-docker

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: | sudo \
	/bin/podman \
	/bin/docker \
	/bin/docker-compose \
	/usr/local/bin/podman-compose \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/bin/podman: | apt-update
	@$(SUDO) $(APT) install -y podman
/bin/docker: | apt-update
	@$(SUDO) $(APT) install -y docker-ce
	@$(SUDO) usermod -aG docker $(USER)
	@$(SUDO) su -l $(USER)
/bin/docker-compose: | apt-update
	@$(SUDO) $(APT) install -y docker-compose
else
/bin/podman: not-supported
/bin/docker: not-supported
/bin/docker-compose: not-supported
endif
/usr/local/bin/podman-compose:
	@$(SUDO) $(PIP) install podman-compose

.PHONY: uninstall
ifeq ($(PKG_MANAGER),apt-get)
uninstall: | sudo
	@$(SUDO) $(PIP) uninstall podman-compose
	@$(SUDO) $(APT) uninstall -y podman docker-ce docker-compose
	@$(SUDO) $(APT) autoremove -y
else
uninstall: not-supported
endif
