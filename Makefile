.DEFAULT_GOAL := help

include cody.mk

INSTALLERS := $(shell cd installers && ls -d */ | sed 's|\/$$||g')
INSTALLERS_PATH := $(addprefix installers/,$(INSTALLERS))

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
endif

.PHONY: help
help: ;

define installed_installer
	touch $(HOME)/.cody_installed && \
	for p in $$(cat $(HOME)/.cody_installed); do \
		echo $$p;  \
	done | tee $(HOME)/.cody_installed >/dev/null && \
	for p in $$(cat $(HOME)/.cody_installed); do \
		if [ "$$p" = "$1" ]; then export _FOUND_INSTALLER=1; fi \
	done && \
	if [ "$$_FOUND_INSTALLER" != "1" ]; then \
		echo $1 >> $(HOME)/.cody_installed; \
	fi
endef

define uninstalled_installer
	touch $(HOME)/.cody_installed && \
	for p in $$(cat $(HOME)/.cody_installed); do \
		if [ "$$p" != "$1" ]; then echo $$p; fi  \
	done | tee $(HOME)/.cody_installed >/dev/null
endef
