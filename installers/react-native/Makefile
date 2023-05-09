NAME := react-native
RND_VERSION := 0.13.0
DEPENDS_ON := \
	javascript \
	python

include $(CODY)

ifneq (1,$(IS_WSL))
DEPENDS_ON += ndroid-studio
endif

WATCHMAN_BINARY := /usr/bin/watchman
RND_BINARY := /usr/bin/react-native-debugger
FLIPPER_BINARY := /usr/bin/flipper
ifeq ($(PKG_MANAGER),brew)
WATCHMAN_BINARY := /usr/local/bin/watchman
RND_BINARY := /Applications/React\ Native\ Debugger.app/Contents/PkgInfo
FLIPPER_BINARY := /Applications/Flipper.app/Contents/PkgInfo
endif

INSTALL_TARGETS := smart-sudo \
	$(WATCHMAN_BINARY) \
	$(RND_BINARY)
ifeq ($(PLATFORM),darwin)
INSTALL_TARGETS += \
	$(HOME)/.local/bin/idb
endif
ifneq (1,$(IS_WSL))
INSTALL_TARGETS += $(FLIPPER_BINARY)
ifeq ($(PLATFORM),linux)
INSTALL_TARGETS += \
	$(HOME)/.local/share/applications/react-native-debugger.desktop
DEPENDS_ON += \
	cinch
FLIPPER_BINARY :=
endif
endif

.PHONY: install
install: | sudo \
	$(INSTALL_TARGETS)
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/watchman:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/flipper:
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/react-native-debugger:
	@curl -Lo $(_TMP_PATH)/rnd.deb \
		https://github.com/jhen0409/react-native-debugger/releases/download/v$(RND_VERSION)/react-native-debugger_$(RND_VERSION)_amd64.deb
	@$(call apt-update)
	@$(SUDO) dpkg -i $(_TMP_PATH)/rnd.deb || true
	@$(SUDO) $(APT) install -f -y
	@$(SUDO) dpkg -i $(_TMP_PATH)/rnd.deb
else

ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/watchman:
	@$(BREW) install $(@F)
/usr/local/bin/react-native-debugger:
	@$(BREW) install --cask $(@F)
/Applications/Flipper.app/Contents/PkgInfo:
	@$(SUDO) xcode-select --switch /Applications/Xcode.app
	@$(BREW) install --cask $(@F)
$(HOME)/.local/bin/idb:
	-@$(BREW) tap facebook/fb
	-@$(BREW) install idb-companion
	@pipx install fb-idb
endif

/usr/bin/watchman: not-supported
/usr/bin/react-native-debugger: not-supported
endif

$(HOME)/.local/share/applications/react-native-debugger.desktop:
	@sed 's|^Exec=react-native-debugger %U$$|Exec=xrun react-native-debugger %U|g' \
		/usr/share/applications/react-native-debugger.desktop > $@

.PHONY: uninstall
uninstall: ;
