NAME := javascript
DEPENDS_ON := \
	nodejs \
	vscode
CODE_EXTENSIONS := \
	amodio.tsl-problem-matcher \

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: code-extensions

.PHONY: uninstall
uninstall:
