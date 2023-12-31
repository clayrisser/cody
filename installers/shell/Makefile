NAME := shell
DEPENDS_ON := \
	core \
	python

include $(CODY)

ifeq ($(PLATFORM),darwin)
CURRENT_SHELL := $(shell dscl . -read /Users/$(USER) UserShell | cut -d' ' -f2)
else
CURRENT_SHELL := $(shell getent passwd $(USER) | cut -d':' -f7)
endif
ZSH_CUSTOM := $(HOME)/.oh-my-zsh/custom

INSTALL_TARGETS := sudo \
	/usr/bin/zsh \
	/usr/bin/direnv \
	/usr/local/bin/starship
ifeq ($(PKG_MANAGER),brew)
INSTALL_TARGETS := /opt/homebrew/bin/zsh \
	/opt/homebrew/bin/direnv \
	/opt/homebrew/bin/starship
endif
.PHONY: install chsh
install: | $(INSTALL_TARGETS) \
	chsh \
	$(HOME)/.oh-my-zsh/oh-my-zsh.sh \
	$(ZSH_CUSTOM)/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
	$(ZSH_CUSTOM)/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh \
	$(HOME)/.autojump/etc/profile.d/autojump.sh \
	$(ZSH_CUSTOM)/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh \
	$(ZSH_CUSTOM)/plugins/zsh-completions/zsh-completions.plugin.zsh

/usr/local/bin/starship:
	@curl -Lo $(_TMP_PATH)/starship.sh https://starship.rs/install.sh
	@unset ARCH PLATFORM; sh $(_TMP_PATH)/starship.sh --yes
	@rm -f $(_TMP_PATH)/starship.sh

ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/zsh:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y zsh
/usr/bin/direnv:
	@$(call apt-update)
	@$(SUDO) $(APT) install -y direnv
	@(cat $(HOME)/.zshrc | grep -q direnv) || \
		echo 'eval "$$(direnv hook zsh)"' >> $(HOME)/.zshrc
else
ifeq ($(PKG_MANAGER),brew)
/opt/homebrew/bin/zsh:
	@$(BREW) install zsh
/opt/homebrew/bin/direnv:
	@$(BREW) install direnv
	@(cat $(HOME)/.zshrc | grep -q direnv) || \
		echo 'eval "$$(direnv hook zsh)"' >> $(HOME)/.zshrc
/opt/homebrew/bin/starship:
	@$(BREW) install starship
endif
/usr/bin/direnv: not-supported
/usr/bin/zsh: not-supported
endif

ifeq ($(findstring zsh,$(CURRENT_SHELL)),zsh)
chsh: ;
else
chsh:
ifeq ($(PLATFORM),darwin)
	@usermod -s /bin/zsh $(USER)
else
	@$(SUDO) usermod -s /usr/bin/zsh $(USER)
endif
endif
$(HOME)/.oh-my-zsh/oh-my-zsh.sh:
	@echo Y | sh -c \
		"$$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$(ZSH_CUSTOM)/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh:
	@git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
		$(ZSH_CUSTOM)/plugins/zsh-syntax-highlighting
$(ZSH_CUSTOM)/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh:
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git \
		$(ZSH_CUSTOM)/plugins/zsh-autocomplete
$(HOME)/.autojump/etc/profile.d/autojump.sh:
	@rm -rf $${XDG_RUNTIME_DIR:-/tmp}/autojump
	@git clone --depth 1 https://github.com/wting/autojump.git \
		$${XDG_RUNTIME_DIR:-/tmp}/autojump
	@cd $${XDG_RUNTIME_DIR:-/tmp}/autojump && \
		python3 ./install.py
$(ZSH_CUSTOM)/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh:
	@git clone https://github.com/zsh-users/zsh-autosuggestions \
		$(ZSH_CUSTOM)/plugins/zsh-autosuggestions
$(ZSH_CUSTOM)/plugins/zsh-completions/zsh-completions.plugin.zsh:
	@git clone https://github.com/zsh-users/zsh-completions \
		$(ZSH_CUSTOM)/plugins/zsh-completions

.PHONY: uninstall
uninstall:
	-@$(RM) -rf \
		$(HOME)/.autojump \
		$(HOME)/.oh-my-zsh
