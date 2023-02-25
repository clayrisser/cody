NAME := android-studio
FLATPAK_BASE := https://dl.flathub.org/repo/appstream
FLATPAK_PACKAGE := com.google.AndroidStudio
DEPENDS_ON := \
	flatpak

include $(CODY)

.PHONY: install
install: | /var/lib/flatpak/exports/share/applications/$(FLATPAK_PACKAGE).desktop
/var/lib/flatpak/exports/share/applications/$(FLATPAK_PACKAGE).desktop:
	@flatpak install -y $(FLATPAK_BASE)/$(FLATPAK_PACKAGE).flatpakref

.PHONY: uninstall
uninstall:
	@flatpak uninstall -y $(FLATPAK_PACKAGE)
