NAME := solidity
DEPENDS_ON := \
	vscode
CODE_EXTENSIONS := \
	RemixProject.ethereum-remix \
	juanblanco.solidity \
	tintinweb.solidity-visual-auditor

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: code-extensions

.PHONY: uninstall
uninstall:
