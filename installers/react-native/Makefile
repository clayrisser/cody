NAME := react-native
RND_VERSION := 0.13.0
DEPENDS_ON := \
	javascript \
	android-studio

include $(CODY)

.PHONY: install
install: | sudo \
	/usr/bin/watchman \
	/usr/bin/react-native-debugger \
	$(HOME)/.local/share/applications/react-native-debugger.desktop
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/watchman:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y watchman
else
/usr/bin/watchman: not-supported
endif
/usr/bin/react-native-debugger:
	@curl -Lo $(_TMP_PATH)/rnd.deb \
		https://github.com/jhen0409/react-native-debugger/releases/download/v$(RND_VERSION)/react-native-debugger_$(RND_VERSION)_amd64.deb
	@$(call apt-update)
	@$(SUDO) dpkg -i $(_TMP_PATH)/rnd.deb || true
	@$(SUDO) $(APT) install -f -y
	@$(SUDO) dpkg -i $(_TMP_PATH)/rnd.deb
$(HOME)/.local/share/applications/react-native-debugger.desktop:
	@sed 's|^Exec=react-native-debugger %U$$|Exec=xrun react-native-debugger %U|g' \
		/usr/share/applications/react-native-debugger.desktop > $@

.PHONY: uninstall
uninstall: ;
