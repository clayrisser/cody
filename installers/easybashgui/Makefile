NAME := easybashgui
DEPENDS_ON :=

include $(CODY)

.PHONY: install
install: | sudo \
	/usr/local/bin/easybashgui
/usr/local/bin/easybashgui:
	@cd $(_TMP_PATH) && \
		curl -L -o easybashgui.tar.gz \
			https://gitlab.com/bitspur/community/easybashgui/-/archive/main/easybashgui-main.tar.gz && \
		tar -xzf easybashgui.tar.gz && \
		cd easybashgui-main && \
		$(SUDO) make install

.PHONY: uninstall
uninstall: | sudo
	@cd $(_TMP_PATH) && \
		curl -L -o easybashgui.tar.gz \
			https://gitlab.com/bitspur/community/easybashgui/-/archive/main/easybashgui-main.tar.gz && \
		tar -xzf easybashgui.tar.gz && \
		cd easybashgui-main && \
		$(SUDO) make uninstall
