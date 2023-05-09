NAME := php
DEPENDS_ON :=
CODE_EXTENSIONS := \
	xdebug.php-pack

include $(CODY)
include $(SHARED)/code/code.mk

DEPENDS_ON += $(CODE)

.PHONY: install
install: | /usr/bin/composer \
	$(HOME)/.phpenv/bin/phpenv \
	$(HOME)/.phpenv/plugins/php-build/bin/php-build \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/composer:
	@$(MAKE) -C ../.. -s apt-update
	@$(SUDO) $(APT) install -y \
		autoconf \
		bison \
		build-essential \
		composer \
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
else
/bin/composer: not-supported
endif
$(HOME)/.phpenv/bin/phpenv:
	@git clone https://github.com/phpenv/phpenv $(HOME)/.phpenv
$(HOME)/.phpenv/plugins/php-build/bin/php-build:
	@git clone https://github.com/php-build/php-build $(HOME)/.phpenv/plugins/php-build

.PHONY: uninstall
uninstall: | sudo
	-@rm -rf $(HOME)/.phpenv
