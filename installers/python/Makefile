NAME := python
DEPENDS_ON := \
	vscode
CODE_EXTENSIONS := \
	bungcip.better-toml \
	ms-python.python \

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: | sudo \
	/usr/bin/python3 \
	/usr/bin/python \
	/usr/bin/pip3 \
	/usr/local/bin/poetry \
	$(HOME)/.pyenv/bin/pyenv \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/python3:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y \
		python3
/usr/bin/python:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y \
		python-is-python3
/usr/bin/pip3:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y \
		python3-pip
else
/usr/bin/pip3: not-supported
/usr/bin/python3: not-supported
/usr/bin/python: not-supported
endif
/usr/local/bin/poetry:
	@$(SUDO) $(PIP) install poetry
$(HOME)/.pyenv/bin/pyenv:
ifeq ($(PKG_MANAGER),apt-get)
	@$(call apt-update)
	@$(SUDO) $(APT) install -y \
		libsqlite3-dev \
		ibtk-img-dev \
		libreadline-dev \
		libbz2-dev \
		liblzma-dev
endif
	@git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	@echo 'export PYENV_ROOT="$$HOME/.pyenv"' >> $(HOME)/.zshrc
	@echo 'export PATH="$$PYENV_ROOT/bin:$$PATH"' >> $(HOME)/.zshrc
	@echo 'eval "$$(pyenv init --path)"' >> $(HOME)/.zshrc

.PHONY: uninstall
ifeq ($(PKG_MANAGER),apt-get)
uninstall: | sudo
	-@$(RM) -rf $(HOME)/.pyenv
	@$(SUDO) $(APT) remove -y \
		python3 \
		python-is-python3 \
		python3-pip \
		libsqlite3-dev \
		libreadline-dev \
		libbz2-dev \
		liblzma-dev
	@$(SUDO) $(APT) autoremove -y
else
uninstall: not-supported
endif
