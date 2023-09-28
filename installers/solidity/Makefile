NAME := solidity
DEPENDS_ON :=
CODE_EXTENSIONS := \
	nomicfoundation.hardhat-solidity \
	tintinweb.solidity-visual-auditor

include $(CODY)
include $(SHARED)/code/code.mk

DEPENDS_ON += $(CODE_INSTALLER)

.PHONY: install
install: code-extensions

.PHONY: uninstall
uninstall:
