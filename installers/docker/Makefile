NAME := docker
DEPENDS_ON := \
	python
CODE_EXTENSIONS := \
	ms-azuretools.vscode-docker

include $(CODY)
include $(SHARED)/code/code.mk

DEPENDS_ON += $(CODE_INSTALLER)

ifeq ($(CODE),code)
CODE_EXTENSIONS := \
	ms-vscode-remote.remote-containers
endif

PODMAN_COMPOSE_BINARY := $(HOME)/.local/bin/podman-compose
ifeq ($(CODENAME),bookworm)
PODMAN_COMPOSE_BINARY = /usr/bin/podman-compose
endif
ifeq ($(CODENAME),sid)
PODMAN_COMPOSE_BINARY = /usr/bin/podman-compose
endif
ifeq ($(PKG_MANAGER),brew)
PODMAN_COMPOSE_BINARY = /usr/local/bin/podman-compose
endif

.PHONY: install
ifeq ($(PKG_MANAGER),brew)
install: | /usr/local/bin/docker \
	/usr/local/bin/docker-compose \
	/usr/local/bin/podman \
	$(PODMAN_COMPOSE_BINARY) \
	code-extensions
else
install: | sudo \
	/usr/bin/docker \
	/usr/bin/buildah \
	/usr/bin/docker-compose \
	/usr/bin/docker-credential-pass \
	/usr/bin/podman \
	$(PODMAN_COMPOSE_BINARY) \
	code-extensions
endif

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

ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/podman:
	@$(BREW) install $(@F)
/usr/local/bin/docker:
	@$(BREW) install --cask $(@F)
/usr/local/bin/docker-compose:
	@$(BREW) install $(@F)
/usr/local/bin/podman-compose:
	@$(BREW) install $(@F)
endif

/usr/bin/buildah: not-supported
/usr/bin/docker-compose: not-supported
/usr/bin/docker-credential-pass: not-supported
/usr/bin/docker: not-supported
/usr/bin/podman-compose: not-supported
/usr/bin/podman: not-supported
endif

$(HOME)/.local/bin/podman-compose:
	@pipx install podman-compose

.PHONY: uninstall
uninstall: ;
