NAME := terraform
DEPENDS_ON := \
	vscode
CODE_EXTENSIONS := \
	hashicorp.terraform

include $(CODY)
include $(SHARED)/code/code.mk

TERRAFORM_BINARY := /usr/bin/terraform
ifeq ($(PKG_MANAGER),brew)
TERRAFORM_BINARY := /usr/local/bin/terraform
endif

.PHONY: install
install: | smart-sudo \
	$(TERRAFORM_BINARY) \
	code-extensions
ifeq ($(PKG_MANAGER),apt-get)
/usr/bin/terraform:
	@$(SUDO) sh -c 'curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/terraform.gpg'
	@$(SUDO) sh -c 'echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(CODENAME) main" > /etc/apt/sources.list.d/terraform.list'
	@$(call apt-update)
	@$(SUDO) $(APT) install -y $(@F)
else
ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/terraform:
	@$(BREW) install $(@F)
endif
/usr/bin/terraform: not-supported
endif
