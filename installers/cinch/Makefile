NAME := cinch
DEPENDS_ON := \

include $(CODY)

.PHONY: install
install: | \
	/usr/local/bin/yarn2init
/usr/local/bin/yarn2init:
	@sudo true
	@git clone https://gitlab.com/risserlabs/community/cinch.git /tmp/_cinch
	@cd /tmp/_cinch && make install

.PHONY: uninstall
uninstall:
	@git clone https://gitlab.com/risserlabs/community/cinch.git /tmp/_cinch
	@cd /tmp/_cinch && make uninstall
