NAME := aws

include ../../share.mk

.PHONY: install
install: | \
	/usr/local/bin/aws \
	/usr/bin/awsp
/usr/local/bin/aws:
	@$(SUDO) $(PIP) install awscli
/usr/bin/awsp:
	@$(SUDO) npm install -g awsp
