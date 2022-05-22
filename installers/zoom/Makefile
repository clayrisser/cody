NAME := zoom
DEPENDS_ON := \

include $(CODY)

.PHONY: install
install: | \
	/bin/zoom \
	/usr/src/v4l2loopback-0.12.5/v4l2loopback.c \
	/usr/bin/obs
ifeq ($(PKG_MANAGER),apt-get)
/bin/zoom:
	@$(SUDO) true && \
		cd $${XDG_RUNTIME_DIR:-/tmp} && \
		curl -LO https://zoom.us/client/latest/zoom_amd64.deb && \
		$(SUDO) dpkg -i zoom_amd64.deb && \
		$(SUDO) apt-get install -f && \
		$(SUDO) dpkg -i zoom_amd64.deb
/usr/src/v4l2loopback-0.12.5/v4l2loopback.c:
	@$(SUDO) $(APT) install -y \
		v4l2loopback-dkms
	@echo v4l2loopback | \
		$(SUDO) tee /etc/modules-load.d/v4l2loopback.conf
	@echo 'options v4l2loopback card_label="OBS Video Source" video_nr=10 exclusive_caps=1' | \
		$(SUDO) tee /etc/modprobe.d/v4l2-obs-studio.conf
	@$(SUDO) depmod -a
	@$(SUDO) modprobe v4l2loopback
/usr/bin/obs:
	@cat 'deb http://www.deb-multimedia.org bullseye main' > \
		/etc/apt/sources.list
	@$(SUDO) $(APT) update -oAcquire::AllowInsecureRepositories=true
	@$(SUDO) $(APT) install -y deb-multimedia-keyring
	@$(SUDO) $(APT) install -y \
		obs-studio
else
/bin/zoom: not-supported
/usr/src/v4l2loopback-0.12.5/v4l2loopback.c: not-supported
/usr/bin/obs: not-supported
endif
