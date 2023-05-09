NAME := solidity
DEPENDS_ON := \
	vscode
CODE_EXTENSIONS := \
	juanblanco.solidity \
	nomicfoundation.hardhat-solidity

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: code-extensions

.PHONY: uninstall
uninstall:
