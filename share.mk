export NULL := /dev/null
export NOFAIL := 2>$(NULL) || $(TRUE)
export NOOUT := >$(NULL) 2>$(NULL)
export ARCH := unknown
export FLAVOR := unknown
export PKG_MANAGER := unknown
export PLATFORM := unknown
ifeq ($(OS),Windows_NT)
	export HOME := $(HOMEDRIVE)$(HOMEPATH)
	PLATFORM = win32
	FLAVOR = win64
	ARCH = $(PROCESSOR_ARCHITECTURE)
	PKG_MANAGER = choco
	ifeq ($(ARCH),AMD64)
		ARCH = amd64
	endif
	ifeq ($(ARCH),ARM64)
		ARCH = arm64
	endif
	ifeq ($(PROCESSOR_ARCHITECTURE),x86)
		ARCH = amd64
		ifeq (,$(PROCESSOR_ARCHITEW6432))
			ARCH = x86
			FLAVOR := win32
		endif
	endif
else
	PLATFORM = $(shell uname 2>$(NULL) | tr '[:upper:]' '[:lower:]' 2>$(NULL))
	ARCH = $(shell (dpkg --print-architecture 2>$(NULL) || uname -m 2>$(NULL) || arch 2>$(NULL) || echo unknown) | tr '[:upper:]' '[:lower:]' 2>$(NULL))
	ifeq ($(ARCH),i386)
		ARCH = 386
	endif
	ifeq ($(ARCH),i686)
		ARCH = 386
	endif
	ifeq ($(ARCH),x86_64)
		ARCH = amd64
	endif
	ifeq ($(PLATFORM),linux) # LINUX
		ifneq (,$(wildcard /system/bin/adb))
			ifneq ($(shell getprop --help >$(NULL) 2>$(NULL) && echo 1 || echo 0),1)
				PLATFORM = android
			endif
		endif
		ifeq ($(PLATFORM),linux)
			FLAVOR = $(shell lsb_release -si 2>$(NULL) | tr '[:upper:]' '[:lower:]' 2>$(NULL))
			ifeq (,$(FLAVOR))
				FLAVOR = unknown
				ifneq (,$(wildcard /etc/redhat-release))
					FLAVOR = rhel
				endif
				ifneq (,$(wildcard /etc/SuSE-release))
					FLAVOR = suse
				endif
				ifneq (,$(wildcard /etc/debian_version))
					FLAVOR = debian
				endif
				ifeq ($(shell cat /etc/os-release 2>$(NULL) | grep -qE "^ID=alpine$$"),ID=alpine)
					FLAVOR = alpine
				endif
			endif
			ifeq ($(FLAVOR),rhel)
				PKG_MANAGER = yum
			endif
			ifeq ($(FLAVOR),suse)
				PKG_MANAGER = zypper
			endif
			ifeq ($(FLAVOR),debian)
				PKG_MANAGER = apt-get
			endif
			ifeq ($(FLAVOR),ubuntu)
				PKG_MANAGER = apt-get
			endif
			ifeq ($(FLAVOR),alpine)
				PKG_MANAGER = apk
			endif
		endif
	else
		ifneq (,$(findstring CYGWIN,$(PLATFORM))) # CYGWIN
			PLATFORM = win32
			FLAVOR = cygwin
		endif
		ifneq (,$(findstring MINGW,$(PLATFORM))) # MINGW
			PLATFORM = win32
			FLAVOR = msys
			PKG_MANAGER = mingw-get
		endif
		ifneq (,$(findstring MSYS,$(PLATFORM))) # MSYS
			PLATFORM = win32
			FLAVOR = msys
			PKG_MANAGER = pacman
		endif
	endif
	ifeq ($(PLATFORM),darwin)
		PKG_MANAGER = brew
	endif
endif

define not_supported
	echo $1 installer for $(FLAVOR) $(PLATFORM) is not not supported && exit 1
endef

APT ?= apt-get
SUDO ?= sudo

.PHONY: sudo
sudo:
	@$(SUDO) true