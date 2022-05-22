NAME := android-studio

include ../../cody.mk

.PHONY: install
install: | sudo /var/lib/flatpak/exports/share/applications/com.google.AndroidStudio.desktop
/var/lib/flatpak/exports/share/applications/com.google.AndroidStudio.desktop:
	@$(MAKE) -sC ../flatpak install
	@flatpak install -y \
		https://dl.flathub.org/repo/appstream/com.google.AndroidStudio.flatpakref
