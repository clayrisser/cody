NAME := chatgpt
DEPENDS_ON :=

include $(CODY)

.PHONY: install
install: | $(HOME)/.local/bin/chatgpt
$(HOME)/.local/bin/chatgpt:
	@pipx install git+https://github.com/mmabrouk/chatgpt-wrapper
	@playwright install

.PHONY: uninstall
uninstall:
	@pipx uninstall chatgpt
