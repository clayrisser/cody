NAME := php
DEPENDS_ON := \
	vscode
CODE_EXTENSIONS := \
	xdebug.php-pack \

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: | /bin/composer \
	$(HOME)/.phpenv/bin/phpenv \
	$(HOME)/.phpenv/plugins/php-build/bin/php-build \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/bin/composer: | apt-update
	@$(SUDO) $(APT) install -y composer
else
/bin/composer: not-supported
endif
$(HOME)/.phpenv/bin/phpenv:
ifeq ($(PKG_MANAGER),apt-get)
	@$(SUDO) $(APT) install -y \
		autoconf \
		bison \
		build-essential \
		libbz2-dev \
		libcurl4-openssl-dev \
		libjpeg-dev \
		libmcrypt-dev \
		libonig-dev \
		libpng-dev \
		libreadline-dev \
		libsqlite3-dev \
		libtidy-dev \
		libxml2-dev \
		libxslt1-dev \
		pkg-config \
		re2c
endif
	@git clone https://github.com/phpenv/phpenv $(HOME)/.phpenv
$(HOME)/.phpenv/plugins/php-build/bin/php-build:
	@git clone https://github.com/php-build/php-build $(HOME)/.phpenv/plugins/php-build

.PHONY: uninstall
uninstall: | sudo
	-@rm -rf $(HOME)/.phpenv
ifeq ($(PKG_MANAGER),apt-get)
	@$(SUDO) $(APT) uninstall -y \
		autoconf \
		bison \
		build-essential \
		libbz2-dev \
		libcurl4-openssl-dev \
		libjpeg-dev \
		libmcrypt-dev \
		libonig-dev \
		libpng-dev \
		libreadline-dev \
		libsqlite3-dev \
		libtidy-dev \
		libxml2-dev \
		libxslt1-dev \
		pkg-config \
		re2c
	@$(SUDO) $(APT) autoremove -y
else
uninstall: not-supported
endif
