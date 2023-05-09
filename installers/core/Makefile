NAME := core
DEPENDS_ON :=

include $(CODY)

YQ_BINARY := /usr/local/bin/yq
ifeq ($(PKG_MANAGER),apt-get)
ifneq (1,$(IS_WSL))
YQ_BINARY := /usr/bin/yq
endif
endif

.PHONY: install yq
ifeq ($(PKG_MANAGER),brew)
install: | /usr/local/bin/convert \
	/usr/bin/curl \
	/usr/local/bin/ggrep \
	/usr/local/bin/git \
	/usr/local/bin/git-lfs \
	/usr/local/bin/gsed \
	/usr/local/bin/jq \
	/usr/local/bin/remake \
	$(YQ_BINARY)
else
install: | sudo \
	/usr/bin/convert \
	/usr/bin/curl \
	/usr/bin/git \
	/usr/bin/git-lfs \
	/usr/bin/jq \
	/usr/bin/make \
	$(YQ_BINARY)
endif

ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/jq:
	@$(call apt-update)
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
/usr/bin/snapd:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y snapd
/usr/bin/curl:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y curl
else

ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/jq:
	@$(BREW) install jq
/usr/local/bin/convert:
	@$(BREW) install imagemagick
/usr/local/bin/curl:
	@$(BREW) install curl
/usr/local/bin/remake:
	@$(BREW) install remake
/usr/local/bin/git:
	@$(BREW) install git
/usr/local/bin/git-lfs:
	@$(BREW) install git-lfs
/usr/local/bin/gsed:
	@$(BREW) install gsed
/usr/local/bin/ggrep:
	@$(BREW) install grep
else
/usr/local/bin/jq: not-supported
/usr/local/bin/convert: not-supported
/usr/local/bin/make: not-supported
/usr/local/bin/git: not-supported
/usr/local/bin/git-lfs: not-supported
/usr/local/bin/curl: not-supported
endif

/usr/bin/jq: not-supported
/usr/bin/convert: not-supported
/usr/bin/make: not-supported
/usr/bin/git: not-supported
/usr/bin/git-lfs: not-supported
/usr/bin/snapd: not-supported
ifeq ($(PLATFORM),darwin)
/usr/bin/curl: ;
else
/usr/bin/curl: not-supported
endif
endif

ifeq ($(PKG_MANAGER),apt-get)
ifeq (1,$(IS_WSL))
/usr/bin/yq: | /usr/bin/snapd
	@$(SUDO) snap install yq
else
/usr/bin/yq: not-supported
endif
else
/usr/bin/yq: not-supported
endif
ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/yq:
	@$(BREW) install yq
else
/usr/local/bin/yq:
	@$(SUDO) curl -Lo $@ https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 && \
		$(SUDO) chmod +x $@
endif

.PHONY: uninstall
uninstall: ;
