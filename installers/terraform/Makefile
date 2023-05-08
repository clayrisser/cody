NAME := terraform
DEPENDS_ON := \
	vscode
CODE_EXTENSIONS := \
	hashicorp.terraform

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: | sudo \
	/usr/bin/terraform \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/terraform:
	@$(SUDO) sh -c 'curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/terraform.gpg'
	@$(SUDO) sh -c 'echo "deb [arch=amd64] https://apt.releases.hashicorp.com $$(cat /etc/os-release | grep VERSION_CODENAME | cut -d'=' -f2) main" > /etc/apt/sources.list.d/terraform.list'
	@$(call apt-update)
	@$(SUDO) $(APT) install -y terraform
else
/bin/terraform: not-supported
endif
