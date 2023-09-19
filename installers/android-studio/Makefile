NAME := android-studio
FLATPAK_BASE := https://dl.flathub.org/repo/appstream
FLATPAK_PACKAGE := com.google.AndroidStudio
ifeq ($(PLATFORM),linux)
DEPENDS_ON := \
	flatpak
endif

include $(CODY)

.PHONY: install
ifeq ($(PLATFORM),linux)
install: | sudo \
	/var/lib/flatpak/exports/share/applications/$(FLATPAK_PACKAGE).desktop \
	$(HOME)/.android/advancedFeatures.ini
else
ifeq ($(PKG_MANAGER),brew)
install: | /Applications/Android\ Studio.app/Contents/Info.plist
else
install: not-supported
endif
endif
ifeq ($(PLATFORM),linux)
/var/lib/flatpak/exports/share/applications/$(FLATPAK_PACKAGE).desktop:
	@$(SUDO) flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	@flatpak install -y $(FLATPAK_BASE)/$(FLATPAK_PACKAGE).flatpakref
ifeq ($(PKG_MANAGER),apt-get)
	@$(SUDO) $(APT) install -y \
		bridge-utils \
		libvirt-clients \
		libvirt-daemon-system \
		qemu-kvm
endif
else
ifeq ($(PKG_MANAGER),brew)
/Applications/Android\ Studio.app/Contents/Info.plist:
	@$(BREW) install --cask android-studio
endif
endif

$(HOME)/.android/advancedFeatures.ini:
	@mkdir -p $(HOME)/.android
	@echo 'Vulkan = off' >> $@
	@echo 'GLDirectMem = on' >> $@

.PHONY: uninstall
uninstall:
	@flatpak uninstall -y $(FLATPAK_PACKAGE)
