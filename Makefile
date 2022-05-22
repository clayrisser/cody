.DEFAULT_GOAL := help

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

.PHONY: $(INSTALLERS_PATH)
$(INSTALLERS_PATH):
	@echo $(MAKE) -sC $@ install

TARGET ?= install
.PHONY: $(INSTALLERS)
$(INSTALLERS):
	@$(MAKE) -sC installers/$@ $(TARGET)
ifeq ($(TARGET),install)
	$(call installed_installer,$@)
endif
ifeq ($(TARGET),uninstall)
	$(call uninstalled_installer,$@)
endif

.PHONY: install
install:
ifneq (,$(INSTALLER))
	@TARGET=$@ $(MAKE) -s $(INSTALLER)
else
	@sudo cp -r $(CURDIR)/cody.sh /usr/local/bin/cody
	@sudo chmod +x /usr/local/bin/cody
	$(call installed_installer,cody)
endif

.PHONY: uninstall
uninstall:
ifneq (,$(INSTALLER))
	@TARGET=$@ $(MAKE) -s $(INSTALLER)
else
	@sudo rm -rf /usr/local/bin/cody
	$(call uninstalled_installer,cody)
	@rm -rf $(HOME)/.cody
	@rm -rf $(XDG_STATE_HOME)
endif

.PHONY: help
help: ;

define installed_installer
	mkdir -p $(_STATE_PATH) && \
	touch $(_INSTALLED_PATH) && \
	for p in $$(cat $(_INSTALLED_PATH)); do \
		echo $$p;  \
	done | tee $(_INSTALLED_PATH) >/dev/null && \
	for p in $$(cat $(_INSTALLED_PATH)); do \
		if [ "$$p" = "$1" ]; then export _FOUND_INSTALLER=1; fi \
	done && \
	if [ "$$_FOUND_INSTALLER" != "1" ]; then \
		echo $1 >> $(_INSTALLED_PATH); \
	fi
endef

define uninstalled_installer
	mkdir -p $(_STATE_PATH) && \
	touch $(_INSTALLED_PATH) && \
	for p in $$(cat $(_INSTALLED_PATH)); do \
		if [ "$$p" != "$1" ]; then echo $$p; fi  \
	done | tee $(_INSTALLED_PATH) >/dev/null
endef
