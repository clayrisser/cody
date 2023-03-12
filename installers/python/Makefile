NAME := python
DEPENDS_ON := \
	vscode
CODE_EXTENSIONS := \
	bungcip.better-toml \
	ms-python.python

include $(CODY)
include $(SHARED)/code/code.mk

POETRY_BINARY := /usr/local/bin/poetry
ifeq ($(CODENAME),bookworm)
POETRY_BINARY = /usr/bin/poetry
endif

.PHONY: install
install: | sudo \
	/usr/bin/python3 \
	/usr/bin/python \
	/usr/bin/pip3 \
	$(POETRY_BINARY) \
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
/usr/bin/poetry:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y \
		python3-poetry
else
/usr/bin/pip3: not-supported
/usr/bin/poetry: not-supported
/usr/bin/python3: not-supported
/usr/bin/python: not-supported
endif
/usr/local/bin/poetry:
	@$(SUDO) $(PIP) install poetry
$(HOME)/.pyenv/bin/pyenv:
ifeq ($(PKG_MANAGER),apt-get)
	@$(call apt-update)
	@$(SUDO) $(APT) install -y \
		libbz2-dev \
		libffi-dev \
		liblzma-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		libtk-img-dev
endif
	@git clone https://github.com/pyenv/pyenv.git $(HOME)/.pyenv
	@echo 'export PYENV_ROOT="$$HOME/.pyenv"' >> $(HOME)/.zshrc
	@echo 'export PATH="$$PYENV_ROOT/bin:$$PATH"' >> $(HOME)/.zshrc
	@echo 'eval "$$(pyenv init --path)"' >> $(HOME)/.zshrc

.PHONY: uninstall
uninstall:
	-@$(RM) -rf $(HOME)/.pyenv
