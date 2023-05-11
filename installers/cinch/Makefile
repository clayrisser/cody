NAME := cinch
DEPENDS_ON := \
	core

include $(CODY)

.PHONY: install
install: | sudo \
	/usr/local/bin/os
/usr/local/bin/os:
	@rm -rf /tmp/_cinch
	@git clone https://gitlab.com/risserlabs/community/cinch.git /tmp/_cinch
	@cd /tmp/_cinch && make install
	@rm -rf /tmp/_cinch

.PHONY: uninstall
uninstall:
	@rm -rf /tmp/_cinch
	@git clone https://gitlab.com/risserlabs/community/cinch.git /tmp/_cinch
	@cd /tmp/_cinch && make uninstall
	@rm -rf /tmp/_cinch
