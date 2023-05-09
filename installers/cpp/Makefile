NAME := cpp
DEPENDS_ON := \
	core
CODE_EXTENSIONS := \
	jeff-hykin.better-cpp-syntax \
	twxs.cmake

include $(CODY)
include $(SHARED)/code/code.mk

DEPENDS_ON += $(CODE)

.PHONY: install
ifeq ($(PKG_MANAGER),brew)
install: | /usr/local/opt/llvm/bin/clang \
	/usr/local/bin/autoconf \
	/usr/local/bin/automake \
	/usr/local/bin/bazel \
	/usr/local/bin/cmake \
	/usr/local/bin/gcc-13 \
	/usr/local/bin/glibtool \
	/usr/local/bin/ninja \
	/usr/local/opt/bison/bin/bison \
	code-extensions
else
install: | sudo \
	/usr/bin/autoconf \
	/usr/bin/automake \
	/usr/bin/bazel \
	/usr/bin/bison \
	/usr/bin/cmake \
	/usr/bin/gcc \
	/usr/bin/libtool \
	/usr/bin/ninja \
	code-extensions
endif

ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/gcc:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y build-essential
/usr/bin/cmake:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/automake:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/autoconf:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/libtool:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/ninja:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/bazel:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
/usr/bin/bison:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
else

ifeq ($(PKG_MANAGER),brew)
/usr/local/opt/llvm/bin/clang:
	@$(BREW) install llvm
/usr/local/bin/cmake:
	@$(BREW) install $(@F)
/usr/local/bin/gcc-13:
	@$(BREW) install gcc
/usr/local/bin/automake:
	@$(BREW) install $(@F)
/usr/local/bin/autoconf:
	@$(BREW) install $(@F)
/usr/local/bin/glibtool:
	@$(BREW) install libtool
/usr/local/bin/ninja:
	@$(BREW) install $(@F)
/usr/local/bin/bazel:
	@$(BREW) install $(@F)
/usr/local/opt/bison/bin/bison:
	@$(BREW) install $(@F)
endif

/usr/bin/gcc: not-supported
/usr/bin/cmake: not-supported
endif

.PHONY: uninstall
uninstall: ;
