.DEFAULT_GOAL := help

include share.mk

PACKAGES := $(shell cd packages && ls -d */ | sed 's|\/$$||g')
PACKAGES_PATH := $(addprefix packages/,$(PACKAGES))

.PHONY: environment
environment:
	@echo ARCH $(ARCH)
	@echo FLAVOR $(FLAVOR)
	@echo PKG_MANAGER $(PKG_MANAGER)
	@echo PLATFORM $(PLATFORM)

.PHONY: $(PACKAGES_PATH)
$(PACKAGES_PATH):
	@echo $(MAKE) -sC $@ install

TARGET ?= install
.PHONY: $(PACKAGES)
$(PACKAGES):
	@$(MAKE) -sC packages/$@ $(TARGET)
ifeq ($(TARGET),install)
	$(call installed_package,$@)
endif
ifeq ($(TARGET),uninstall)
	$(call uninstalled_package,$@)
endif

.PHONY: install
install:
ifneq (,$(PACKAGE))
	@TARGET=$@ $(MAKE) -s $(PACKAGE)
else
	@sudo cp -r $(CURDIR)/kisspm.sh /usr/local/bin/kisspm
	@sudo chmod +x /usr/local/bin/kisspm
	$(call installed_package,kisspm)
endif

.PHONY: uninstall
uninstall:
ifneq (,$(PACKAGE))
	@TARGET=$@ $(MAKE) -s $(PACKAGE)
else
	@sudo rm -rf /usr/local/bin/kisspm
	$(call uninstalled_package,kisspm)
	@rm -rf $(HOME)/.kisspm
endif

.PHONY: help
help: ;

define installed_package
	touch $(HOME)/.kisspm_installed && \
	for p in $$(cat $(HOME)/.kisspm_installed); do \
		echo $$p;  \
	done | tee $(HOME)/.kisspm_installed >/dev/null && \
	for p in $$(cat $(HOME)/.kisspm_installed); do \
		if [ "$$p" = "$1" ]; then export _FOUND_PACKAGE=1; fi \
	done && \
	if [ "$$_FOUND_PACKAGE" != "1" ]; then \
		echo $1 >> $(HOME)/.kisspm_installed; \
	fi
endef

define uninstalled_package
	touch $(HOME)/.kisspm_installed && \
	for p in $$(cat $(HOME)/.kisspm_installed); do \
		if [ "$$p" != "$1" ]; then echo $$p; fi  \
	done | tee $(HOME)/.kisspm_installed >/dev/null
endef
