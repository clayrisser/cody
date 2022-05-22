NAME := terraform
DEPENDS_ON := \

include $(CODY)

.PHONY: install
install: | sudo \
	/bin/terraform
ifeq ($(PKG_MANAGER),apt-get)
/bin/terraform:
	@$(SUDO) true
	@$(SUDO) sh -c 'curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/terraform.gpg'
	@$(SUDO) sh -c 'echo "deb [arch=amd64] https://apt.releases.hashicorp.com $$(lsb_release -cs) main" > /etc/apt/sources.list.d/terraform.list'
	@$(SUDO) apt-get update
	@$(SUDO) apt-get install terraform
else
/bin/terraform: not-supported
endif
