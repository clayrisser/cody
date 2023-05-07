NAME := core
DEPENDS_ON :=

include $(CODY)

.PHONY: install yq
install: | sudo \
	/usr/bin/convert \
	/usr/bin/curl \
	/usr/bin/git \
	/usr/bin/git-lfs \
	/usr/bin/jq \
	/usr/bin/make \
	/usr/bin/snapd \
	yq
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/jq:
	@$(SUDO) $(APT) install -y jq
/usr/bin/convert:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y imagemagick
/usr/bin/make:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y make
/usr/bin/git:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y git
/usr/bin/git-lfs:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y git-lfs
ifeq (1,$(IS_WSL))
/usr/bin/snapd: ;
else
/usr/bin/snapd:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y snapd
endif
/usr/bin/curl:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y curl
else
/usr/bin/jq: not-supported
/usr/bin/convert: not-supported
/usr/bin/make: not-supported
/usr/bin/git: not-supported
/usr/bin/git-lfs: not-supported
/usr/bin/snapd: not-supported
/usr/bin/curl: not-supported
endif
/usr/bin/yq: | /usr/bin/snapd
	@$(SUDO) snap install yq
/usr/local/bin/yq:
	@$(SUDO) curl -Lo $@ https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 && \
		$(SUDO) chmod +x $@
ifeq (1,$(IS_WSL))
yq: /usr/local/bin/yq
else
yq: /usr/bin/yq
endif

.PHONY: uninstall
uninstall: ;
