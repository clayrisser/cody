NAME := golang

include ../../share.mk

.PHONY: install
install: | sudo \
	$(HOME)/.gvm/bin/gvm
$(HOME)/.gvm/bin/gvm:
	@curl -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
