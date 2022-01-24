NAME := golang
GO_VERSION := 1.17.6

include ../../share.mk

.PHONY: install
install: | /usr/bin/bison \
	$(HOME)/.gvm/bin/gvm
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/bison:
	@$(SUDO) $(APT) install -y bison
else
/usr/bin/bison: not-supported
endif
$(HOME)/.gvm/bin/gvm:
	@curl -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
	@$(HOME)/.gvm/bin/gvm install go$(GO_VERSION) -B
	@$(HOME)/.gvm/bin/gvm use go$(GO_VERSION) --default
