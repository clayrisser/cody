.DEFAULT_GOAL := help
export CODY ?= $(abspath $(CURDIR)/cody.mk)
export DEBIAN_FRONTEND=noninteractive
export PROJECT_ROOT := $(CURDIR)

include cody.mk
INSTALLERS := $(shell cd installers && ls -d */ | sed 's|\/$$||g')
INSTALLERS_PATH := $(addprefix installers/,$(INSTALLERS))

export XDG_STATE_HOME ?= $(HOME)/.local/state
export _STATE_PATH ?= $(XDG_STATE_HOME)/cody
export _INSTALLED_PATH ?= $(_STATE_PATH)/installed

.PHONY: environment
environment:
	@echo ARCH $(ARCH)
	@echo FLAVOR $(FLAVOR)
	@echo PKG_MANAGER $(PKG_MANAGER)
	@echo PLATFORM $(PLATFORM)

TARGET ?= install
.PHONY: $(INSTALLERS)
$(INSTALLERS):
ifeq ($(TARGET),install)
	@mkdir -p $(_TMP_PATH)
endif
	@$(MAKE) -sC installers/$@ $(TARGET)
ifeq ($(TARGET),install)
	@rm -rf $(_TMP_PATH)
	@$(call installed_installer,$@)
endif
ifeq ($(TARGET),uninstall)
	@$(call uninstalled_installer,$@)
endif

.PHONY: install
install:
ifneq (,$(INSTALLER))
	@TARGET=$@ $(MAKE) -s $(INSTALLER)
else
	@sudo mkdir -p /usr/local/bin
	@sudo cp -r $(CURDIR)/cody.sh /usr/local/bin/cody
	@sudo chmod +x /usr/local/bin/cody
	@$(call installed_installer,cody)
endif

.PHONY: uninstall
uninstall:
ifneq (,$(INSTALLER))
	@TARGET=$@ $(MAKE) -s $(INSTALLER)
else
	@sudo rm -rf /usr/local/bin/cody
	$(call uninstalled_installer,cody)
	@rm -rf $(HOME)/.cody
endif

.PHONY: help
help: ;

define installed_installer
	mkdir -p $(_INSTALLED_PATH)/$1
endef

define uninstalled_installer
	mkdir -p $(_INSTALLED_PATH)/$1
	rm -rf $(_INSTALLED_PATH)/$1
endef
