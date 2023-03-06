NAME := shell
DEPENDS_ON := \
	python

include $(CODY)

CURRENT_SHELL := $(shell getent passwd $(USER) | cut -d':' -f7)
ZSH_CUSTOM := $(HOME)/.oh-my-zsh/custom

.PHONY: install chsh
install: | sudo \
	/usr/bin/zsh \
	chsh \
	$(HOME)/.oh-my-zsh/oh-my-zsh.sh \
	$(ZSH_CUSTOM)/themes/spaceship.zsh-theme \
	$(ZSH_CUSTOM)/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
	$(ZSH_CUSTOM)/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh \
	$(HOME)/.autojump/etc/profile.d/autojump.sh \
	$(ZSH_CUSTOM)/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
#	$(ZSH_CUSTOM)/plugins/zsh-completions/zsh-completions.plugin.zsh
/usr/bin/zsh:
ifeq ($(PKG_MANAGER),apt-get)
	@$(SUDO) $(APT) install -y \
		git \
		zsh
else
	@$(call not_supported,$(NAME))
endif
chsh:
ifneq ($(CURRENT_SHELL),/usr/bin/zsh)
	@$(SUDO) usermod -s /usr/bin/zsh $(USER)
endif
$(HOME)/.oh-my-zsh/oh-my-zsh.sh:
	@echo Y | sh -c \
		"$$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$(ZSH_CUSTOM)/themes/spaceship.zsh-theme:
	@git clone https://github.com/spaceship-prompt/spaceship-prompt.git \
		"$(ZSH_CUSTOM)/themes/spaceship-prompt" --depth=1
	@ln -s "$(ZSH_CUSTOM)/themes/spaceship-prompt/spaceship.zsh-theme" "$(ZSH_CUSTOM)/themes/spaceship.zsh-theme"
	@sed -i 's|ZSH_THEME=.*|ZSH_THEME="spaceship"|g' $(HOME)/.zshrc
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
