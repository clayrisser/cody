NAME := aws
DEPENDS_ON := \
	javascript \
	python

include $(CODY)

.PHONY: install
install: | sudo \
	$(HOME)/.local/bin/aws \
	/usr/local/bin/_awsp
$(HOME)/.local/bin/aws:
	@pipx install awscli
/usr/local/bin/_awsp:
	@$(SUDO) npm install -g awsp

.PHONY: uninstall
uninstall: | sudo
	@$(SUDO) pip uninstall awscli
	@$(SUDO) npm uninstall -g awsp
