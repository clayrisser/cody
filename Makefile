.DEFAULT_GOAL := install

include share.mk

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
	@$(MAKE) -sC $@ install

TARGET ?= install
.PHONY: $(INSTALLERS)
$(INSTALLERS):
	@$(MAKE) -sC installers/$@ $(TARGET)

.PHONY: install
install: sudo $(INSTALLERS_PATH)
