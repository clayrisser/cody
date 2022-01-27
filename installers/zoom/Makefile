NAME := zoom

include ../../share.mk

.PHONY: install
install: | \
	/bin/zoom
ifeq ($(PKG_MANAGER),apt-get)
/bin/zoom:
	@$(SUDO) true && \
		cd $${XDG_RUNTIME_DIR:-/tmp} && \
		curl -LO https://zoom.us/client/latest/zoom_amd64.deb && \
		$(SUDO) dpkg -i zoom_amd64.deb && \
		$(SUDO) apt-get install -f && \
		$(SUDO) dpkg -i zoom_amd64.deb
else
/bin/zoom: not-supported
endif
