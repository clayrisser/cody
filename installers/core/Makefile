NAME := core
DEPENDS_ON :=

include $(CODY)

.PHONY: install
install: | sudo \
	/usr/bin/convert \
	/usr/bin/curl \
	/usr/bin/git \
	/usr/bin/git-lfs \
	/usr/bin/jq \
	/usr/bin/make \
	/usr/bin/snapd \
	/usr/bin/yq
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
/usr/bin/snapd:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y snapd
/usr/bin/curl:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y curl
/usr/bin/yq: | /usr/bin/snapd
	@$(SUDO) snap install yq

.PHONY: uninstall
uninstall: ;
