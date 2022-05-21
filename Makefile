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
	@echo $(MAKE) -sC packages/$@ $(TARGET)

.PHONY: install
install:
ifneq (,$(PACKAGE))
	@TARGET=$@ $(MAKE) -s $(PACKAGE)
else
	@sudo cp -r $(CURDIR)/kisspm.sh /usr/local/bin/kisspm
	@sudo chmod +x /usr/local/bin/kisspm
endif

.PHONY: uninstall
uninstall:
ifneq (,$(PACKAGE))
	@TARGET=$@ $(MAKE) -s $(PACKAGE)
else
	@sudo rm -rf /usr/local/bin/kisspm
endif

.PHONY: help
help: ;
