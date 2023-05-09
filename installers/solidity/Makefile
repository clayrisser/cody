NAME := solidity
DEPENDS_ON :=
CODE_EXTENSIONS := \
	juanblanco.solidity \
	nomicfoundation.hardhat-solidity

include $(CODY)
include $(SHARED)/code/code.mk

DEPENDS_ON += $(CODE)

.PHONY: install
install: code-extensions

.PHONY: uninstall
uninstall:
