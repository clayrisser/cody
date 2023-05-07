NAME := docker
DEPENDS_ON := \
	python \
	vscode
CODE_EXTENSIONS := \
	ms-azuretools.vscode-docker \
	ms-vscode-remote.remote-containers

include $(CODY)
include $(SHARED)/code/code.mk

PODMAN_COMPOSE_BINARY := /usr/local/bin/podman-compose
ifeq ($(CODENAME),bookworm)
PODMAN_COMPOSE_BINARY = /usr/bin/podman-compose
endif

.PHONY: install
install: | sudo \
	/usr/bin/buildah \
	/usr/bin/docker \
	/usr/bin/docker-compose \
	/usr/bin/docker-credential-pass \
	/usr/bin/podman \
	$(PODMAN_COMPOSE_BINARY) \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/podman:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y podman
ifeq (1,$(IS_WSL))
/usr/bin/docker: ;
else
/usr/bin/docker:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y docker.io
	@$(SUDO) usermod -aG docker $(USER)
	@$(SUDO) su -l $(USER)
endif
/usr/bin/docker-compose:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y docker-compose
/usr/bin/podman-compose:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y podman-compose
/usr/bin/buildah:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y buildah
/usr/bin/docker-credential-pass:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y golang-docker-credential-helpers
else
/usr/bin/buildah: not-supported
/usr/bin/docker-compose: not-supported
/usr/bin/docker-credential-pass: not-supported
/usr/bin/docker: not-supported
/usr/bin/podman-compose: not-supported
/usr/bin/podman: not-supported
endif
/usr/local/bin/podman-compose:
	@$(SUDO) $(PIP) install podman-compose $(PIP_ARGS)

.PHONY: uninstall
uninstall: ;
