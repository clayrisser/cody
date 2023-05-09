NAME := easybashgui
DEPENDS_ON := \
	core
EBG_VERSION := 12.0.4

include $(CODY)

.PHONY: install
install: | sudo \
	/usr/local/bin/easybashgui
/usr/local/bin/easybashgui:
	@cd $(_TMP_PATH) && \
		curl -L -o easybashgui.tar.gz \
			https://github.com/BashGui/easybashgui/archive/refs/tags/$(EBG_VERSION).tar.gz && \
		tar -xzf easybashgui.tar.gz && \
		cd easybashgui-$(EBG_VERSION) && \
		$(SUDO) make install

.PHONY: uninstall
uninstall: | sudo
	@cd $(_TMP_PATH) && \
		curl -L -o easybashgui.tar.gz \
			https://github.com/BashGui/easybashgui/archive/refs/tags/$(EBG_VERSION).tar.gz && \
		tar -xzf easybashgui.tar.gz
		cd easybashgui-$(EBG_VERSION) && \
		$(SUDO) make uninstall
