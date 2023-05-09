NAME := kube
DEPENDS_ON := \
	docker \
	openlens
CODE_EXTENSIONS := \
	ms-kubernetes-tools.vscode-kubernetes-tools

include $(CODY)
include $(SHARED)/code/code.mk

DEPENDS_ON += $(CODE_INSTALLER)

.PHONY: install
install: | smart-sudo \
	/usr/local/bin/kubectl \
	/usr/local/bin/helm \
	/usr/local/bin/kubectx \
	/usr/local/bin/flux \
	/usr/local/bin/kops \
	$(HOME)/.krew/bin/kubectl-krew \
	code-extensions
ifeq ($(PKG_MANAGER),brew)
/usr/local/bin/kubectl:
	@$(BREW) install $(@F)
/usr/local/bin/helm:
	@$(BREW) install $(@F)
/usr/local/bin/kubectx:
	@$(BREW) install $(@F)
/usr/local/bin/flux:
	@$(BREW) install $(@F)
/usr/local/bin/kops:
	@$(BREW) install $(@F)
else
/usr/local/bin/kubectl:
	@cd $${XDG_RUNTIME_DIR:-/tmp} && \
		curl -LO "https://dl.k8s.io/release/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
		curl -LO "https://dl.k8s.io/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
		echo "$$(cat kubectl.sha256)  kubectl" | sha256sum --check && \
		$(SUDO) install -o root -g root -m 0755 kubectl $@
/usr/local/bin/helm:
	@curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
/usr/local/bin/kubectx:
	@$(SUDO) git clone https://github.com/ahmetb/kubectx /opt/kubectx
	@$(SUDO) ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
	@$(SUDO) ln -s /opt/kubectx/kubens /usr/local/bin/kubens
	@mkdir -p $(ZSH)/completions
	@chmod -R 755 $(ZSH)/completions
	@ln -s /opt/kubectx/completion/_kubectx.zsh $(ZSH)/completions/_kubectx.zsh
	@ln -s /opt/kubectx/completion/_kubens.zsh $(ZSH)/completions/_kubens.zsh
/usr/local/bin/flux:
	@cd $(_TMP_PATH) && \
		curl -L -o flux.tar.gz \
			https://github.com/fluxcd/flux2/releases/download/v0.27.0/flux_0.27.0_linux_amd64.tar.gz && \
		$(SUDO) tar -xzvf flux.tar.gz --directory /usr/local/bin
/usr/local/bin/kops:
	@cd $(_TMP_PATH) && \
		curl -Lo kops \
			https://github.com/kubernetes/kops/releases/download/$(shell \
				curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4 \
			)/kops-linux-amd64 && \
		chmod +x kops && \
		$(SUDO) mv kops $@
endif
ifeq ($(PLATFORM),linux)
$(HOME)/.krew/bin/kubectl-krew:
	@cd $(_TMP_PATH) && \
		curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew-linux_amd64.tar.gz" && \
		tar zxvf "krew-linux_amd64.tar.gz" && \
		./krew-linux_amd64 install krew
else
ifeq ($(PLATFORM),darwin)
$(HOME)/.krew/bin/kubectl-krew:
	@cd $(_TMP_PATH) && \
		curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew-darwin_amd64.tar.gz" && \
		tar zxvf "krew-darwin_amd64.tar.gz" && \
		./krew-darwin_amd64 install krew
else
$(HOME)/.krew/bin/kubectl-krew: not-supported
endif
endif

.PHONY: uninstall
uninstall:
	-@$(SUDO) rm -rf \
		$(HOME)/.krew \
		$(ZSH)/completions/_kubectx.zsh \
		$(ZSH)/completions/_kubens.zsh
ifneq ($(PLATFORM),brew)
	-@$(SUDO) rm -rf \
		/opt/kubectx \
		/usr/local/bin/flux \
		/usr/local/bin/helm \
		/usr/local/bin/kops \
		/usr/local/bin/kubectl \
		/usr/local/bin/kubectx \
		/usr/local/bin/kubens
endif
