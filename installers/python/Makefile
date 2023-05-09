NAME := python
DEPENDS_ON := \
	codium
CODE_EXTENSIONS := \
	bungcip.better-toml \
	ms-python.python

include $(CODY)
include $(SHARED)/code/code.mk

PIPX_BINARY = /usr/local/bin/pipx
POETRY_BINARY := /usr/local/bin/poetry
ifeq ($(CODENAME),bookworm)
PIPX_BINARY = /usr/bin/pipx
endif

.PHONY: install
ifeq ($(PKG_MANAGER),brew)
install: | /usr/local/bin/python3 \
	/usr/local/bin/pip3 \
	$(PIPX_BINARY) \
	$(POETRY_BINARY) \
	$(HOME)/.pyenv/bin/pyenv \
	code-extensions
else
install: | sudo \
	/usr/bin/python3 \
	/usr/bin/python \
	/usr/bin/pip3 \
	$(PIPX_BINARY) \
	$(POETRY_BINARY) \
	$(HOME)/.pyenv/bin/pyenv \
	code-extensions
endif

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
/usr/bin/pipx:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y \
		pipx
/usr/local/bin/poetry:
	@$(SUDO) $(PIP) install poetry $(PIP_ARGS)
/usr/local/bin/pipx:
	@$(SUDO) $(PIP) install pipx $(PIP_ARGS)
	@echo 'export PATH=$$PATH:$$HOME/.local/bin' >> $(HOME)/.zshrc
else

ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/pip3:
	@$(BREW) install pipenv
/usr/local/bin/pipx:
	@$(BREW) install pipx
	@echo 'export PATH=$$PATH:$$HOME/.local/bin' >> $(HOME)/.zshrc
/usr/local/bin/poetry:
	@$(BREW) install poetry
/usr/local/bin/python3:
	@$(BREW) install python
else
/usr/local/bin/poetry:
	@$(SUDO) $(PIP) install poetry $(PIP_ARGS)
/usr/local/bin/pipx:
	@$(SUDO) $(PIP) install pipx $(PIP_ARGS)
	@echo 'export PATH=$$PATH:$$HOME/.local/bin' >> $(HOME)/.zshrc
endif

/usr/bin/pip3: not-supported
/usr/bin/pipx: not-supported
/usr/bin/poetry: not-supported
/usr/bin/python3: not-supported
/usr/bin/python: not-supported
endif

$(HOME)/.pyenv/bin/pyenv:
ifeq ($(PKG_MANAGER),apt-get)
	@$(call apt-update)
	@$(SUDO) $(APT) install -y \
		libbz2-dev \
		libffi-dev \
		liblzma-dev \
		libpython3.*-dev \
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
