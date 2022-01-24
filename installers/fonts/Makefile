NAME := fonts

include ../../share.mk

.PHONY: install
install: | $(HOME)/.local/share/fonts/NerdFonts/Noto\ Sans\ SemiBold\ Italic\ Nerd\ Font\ Complete\ Mono.ttf
$(HOME)/.local/share/fonts/NerdFonts/Noto\ Sans\ SemiBold\ Italic\ Nerd\ Font\ Complete\ Mono.ttf:
	@mkdir -p $(HOME)/Downloads && cd $(HOME)/Downloads && \
		echo git clone https://github.com/ryanoasis/nerd-fonts.git && \
		cd nerd-fonts && \
		./install.sh
	@rm -rf $(HOME)/Downloads/nerd-fonts
