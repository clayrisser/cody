NAME := python

include ../../share.mk

.PHONY: install
install: | sudo /bin/pip3 $(HOME)/.pyenv/bin/pyenv
ifeq ($(PKG_MANAGER),apt-get)
/bin/pip3:
	@$(SUDO) $(APT) install -y \
		python3 \
		python3-pip
else
/bin/pip3: not-supported
endif
$(HOME)/.pyenv/bin/pyenv:
	@git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	@echo 'export PYENV_ROOT="$$HOME/.pyenv"' >> $(HOME)/.zshrc
	@echo 'export PATH="$$PYENV_ROOT/bin:$$PATH"' >> $(HOME)/.zshrc
	@echo 'eval "$$(pyenv init --path)"' >> $(HOME)/.zshrc
