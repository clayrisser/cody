NAME := core
DEPENDS_ON :=

include $(CODY)

.PHONY: install yq
ifeq ($(PKG_MANAGER),brew)
install: | /usr/local/bin/convert \
	/usr/bin/curl \
	/usr/local/bin/cloc \
	/usr/local/bin/ggrep \
	/usr/local/bin/git \
	/usr/local/bin/git-lfs \
	/usr/local/bin/gpg \
	/usr/local/bin/gsed \
	/usr/local/bin/jq \
	/usr/local/bin/mkpm \
	/usr/local/bin/gmake \
	/usr/local/bin/wget \
	/usr/local/bin/yq
else
install: | sudo \
	/usr/bin/cloc \
	/usr/bin/convert \
	/usr/bin/curl \
	/usr/bin/git \
	/usr/bin/git-lfs \
	/usr/bin/jq \
	/usr/bin/make \
	/usr/bin/man \
	/usr/bin/vim \
	/usr/bin/wget \
	/usr/bin/gpg \
	/usr/bin/yq \
	/usr/local/bin/mkpm
endif

ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/jq:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/cloc:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/convert:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y imagemagick
/usr/bin/make:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/man:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/git:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/git-lfs:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
	@git lfs install
/usr/bin/snap:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y snapd
/usr/bin/curl:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/vim:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/wget:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/gpg:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/yq:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
else

ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/jq:
	@$(BREW) install $(@F)
/usr/local/bin/convert:
	@$(BREW) install imagemagick
/usr/local/bin/cloc:
	@$(BREW) install $(@F)
/usr/local/bin/curl:
	@$(BREW) install $(@F)
/usr/local/bin/gmake:
	@$(BREW) install $(@F)
/usr/local/bin/git:
	@$(BREW) install $(@F)
/usr/local/bin/git-lfs:
	@$(BREW) install $(@F)
	@git lfs install
/usr/local/bin/gsed:
	@$(BREW) install $(@F)
/usr/local/bin/ggrep:
	@$(BREW) install grep
/usr/local/bin/wget:
	@$(BREW) install $(@F)
/usr/local/bin/yq:
	@$(BREW) install $(@F)
/usr/local/bin/gpg:
	@$(BREW) install gnupg
endif

/usr/bin/jq: not-supported
/usr/bin/convert: not-supported
/usr/bin/make: not-supported
/usr/bin/git: not-supported
/usr/bin/git-lfs: not-supported
/usr/bin/snap: not-supported
/usr/bin/vim: not-supported
/usr/bin/wget: not-supported
/usr/bin/gpg: not-supported
/usr/bin/yq: not-supported
ifeq ($(PLATFORM),darwin)
/usr/bin/curl: ;
else
/usr/bin/curl: not-supported
endif
endif

/usr/local/bin/mkpm: | sudo
	@$(shell curl --version >/dev/null 2>/dev/null && echo curl -L || echo wget -O-) \
		https://gitlab.com/bitspur/community/mkpm/-/raw/main/install.sh 2>/dev/null | sh

.PHONY: uninstall
uninstall:
	@$(SUDO) rm -f /usr/local/bin/mkpm
