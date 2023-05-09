NAME := solidity
DEPENDS_ON :=
CODE_EXTENSIONS := \
	nomicfoundation.hardhat-solidity

include $(CODY)
include $(SHARED)/code/code.mk

ifeq ($(CODE),code)
CODE_EXTENSIONS += RemixProject.ethereum-remix \
	tintinweb.solidity-visual-auditor
endif

DEPENDS_ON += $(CODE_INSTALLER)

.PHONY: install
install: code-extensions

.PHONY: uninstall
uninstall:
