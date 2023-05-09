NAME := golang
GO_VERSION := 1.17.6
DEPENDS_ON :=
CODE_EXTENSIONS := \
	golang.go

include $(CODY)
include $(SHARED)/code/code.mk

DEPENDS_ON += $(CODE)

ifneq ($(PLATFORM),linux)
DEPENDS_ON += cpp
endif

.PHONY: install
ifeq ($(PLATFORM),darwin)
install: | $(HOME)/.gvm/bin/gvm \
	code-extensions
else
install: | /usr/bin/bison \
	$(HOME)/.gvm/bin/gvm \
	code-extensions
endif
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/bison:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y bison
else
/usr/bin/bison: not-supported
endif
$(HOME)/.gvm/bin/gvm:
	@curl -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
	@echo '[[ -s "$$HOME/.gvm/scripts/gvm" ]] && source "$$HOME/.gvm/scripts/gvm"' >> $(HOME)/.zshrc
ifeq ($(PLATFORM),linux)
	@. $(HOME)/.gvm/scripts/gvm; gvm install go$(GO_VERSION) -B
else
	@. $(HOME)/.gvm/scripts/gvm; gvm install go$(GO_VERSION)
endif
	@. $(HOME)/.gvm/scripts/gvm; gvm use go$(GO_VERSION) --default

.PHONY: uninstall
uninstall:
	-@rm -rf $(HOME)/.gvm
