NAME := easybashgui
DEPENDS_ON :=
EBG_VERSION := 12.0.4

include $(CODY)

.PHONY: install
install: | sudo \
	/usr/local/bin/easybashgui
/usr/local/bin/easybashgui:
	@cd $(_TMP_PATH) && \
		curl -L -o easybashgui.tar.gz \
			https://gitlab.com/bitspur/community/easybashgui/-/archive/main/easybashgui-main.tar.gz && \
		tar -xzf easybashgui.tar.gz && \
		cd easybashgui-$(EBG_VERSION) && \
		$(SUDO) make install

.PHONY: uninstall
uninstall: | sudo
	@cd $(_TMP_PATH) && \
		curl -L -o easybashgui.tar.gz \
			https://gitlab.com/bitspur/community/easybashgui/-/archive/main/easybashgui-main.tar.gz && \
		tar -xzf easybashgui.tar.gz && \
		cd easybashgui-$(EBG_VERSION) && \
		$(SUDO) make uninstall
