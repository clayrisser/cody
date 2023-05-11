NAME := easybashgui
DEPENDS_ON :=

include $(CODY)

.PHONY: install
ifeq ($(PKG_MANAGER),brew)
install: | sudo \
	/usr/local/bin/easybashgui \
	/usr/local/bin/zenity
else
install: | sudo \
	/usr/local/bin/easybashgui
endif

/usr/local/bin/easybashgui:
	@cd $(_TMP_PATH) && \
		curl -L -o easybashgui.tar.gz \
			https://gitlab.com/bitspur/community/easybashgui/-/archive/main/easybashgui-main.tar.gz && \
		tar -xzf easybashgui.tar.gz && \
		cd easybashgui-main && \
		$(SUDO) make install

ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/zenity:
	@$(BREW) install $(@F)
endif

.PHONY: uninstall
uninstall: | sudo
	@cd $(_TMP_PATH) && \
		curl -L -o easybashgui.tar.gz \
			https://gitlab.com/bitspur/community/easybashgui/-/archive/main/easybashgui-main.tar.gz && \
		tar -xzf easybashgui.tar.gz && \
		cd easybashgui-main && \
		$(SUDO) make uninstall
