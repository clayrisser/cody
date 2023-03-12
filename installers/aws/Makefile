NAME := aws
DEPENDS_ON := \
	javascript \
	python

include $(CODY)

.PHONY: install
install: | sudo \
	/usr/local/bin/aws \
	/usr/local/bin/_awsp
/usr/local/bin/aws:
	@$(SUDO) $(PIP) install awscli $(PIP_ARGS)
/usr/local/bin/_awsp:
	@$(SUDO) npm install -g awsp

.PHONY: uninstall
uninstall: | sudo
	@$(SUDO) pip uninstall awscli
	@$(SUDO) npm uninstall -g awsp
