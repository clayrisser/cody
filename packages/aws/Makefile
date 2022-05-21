NAME := aws

include ../../share.mk

.PHONY: install
install: | \
	/usr/local/bin/aws \
	/usr/local/bin/_awsp
/usr/local/bin/aws:
	@$(SUDO) $(PIP) install awscli
/usr/local/bin/_awsp:
	@$(SUDO) npm install -g awsp
