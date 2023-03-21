NAME := kube
DEPENDS_ON := \
	docker \
	openlens \
	vscode
CODE_EXTENSIONS := \
	ms-kubernetes-tools.vscode-kubernetes-tools

include $(CODY)
include $(SHARED)/code/code.mk

.PHONY: install
install: | sudo \
	/usr/local/bin/kubectl \
	/usr/local/bin/helm \
	$(HOME)/.krew/bin/kubectl-krew \
	/usr/local/bin/kubectx \
	/usr/local/bin/flux \
	/usr/local/bin/kops \
	code-extensions
/usr/local/bin/kubectl:
	@cd $${XDG_RUNTIME_DIR:-/tmp} && \
		curl -LO "https://dl.k8s.io/release/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
		curl -LO "https://dl.k8s.io/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
		echo "$$(cat kubectl.sha256)  kubectl" | sha256sum --check && \
		$(SUDO) install -o root -g root -m 0755 kubectl $@
/usr/local/bin/helm:
	@curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
$(HOME)/.krew/bin/kubectl-krew:
	@cd $(_TMP_PATH) && \
		curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew-linux_amd64.tar.gz" && \
		tar zxvf "krew-linux_amd64.tar.gz" && \
		./krew-linux_amd64 install krew
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

.PHONY: uninstall
uninstall:
	-@$(SUDO) rm -rf \
		$(HOME)/.krew \
		$(ZSH)/completions/_kubectx.zsh \
		$(ZSH)/completions/_kubens.zsh \
		/opt/kubectx \
		/usr/local/bin/flux \
		/usr/local/bin/helm \
		/usr/local/bin/kops \
		/usr/local/bin/kubectl \
		/usr/local/bin/kubectx \
		/usr/local/bin/kubens
