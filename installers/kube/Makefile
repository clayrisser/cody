NAME := kube

include ../../share.mk

.PHONY: install
install: | sudo \
	/usr/local/bin/kubectl \
	/usr/local/bin/helm \
	$(HOME)/.krew/bin/kubectl-krew \
	/usr/local/bin/kubectx
/usr/local/bin/kubectl:
	@cd $${XDG_RUNTIME_DIR:-/tmp} && \
		curl -LO "https://dl.k8s.io/release/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
		curl -LO "https://dl.k8s.io/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
		echo "$$(cat kubectl.sha256)  kubectl" | sha256sum --check && \
		sudo install -o root -g root -m 0755 kubectl $@
/usr/local/bin/helm:
	@curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
$(HOME)/.krew/bin/kubectl-krew:
	@cd $${XDG_RUNTIME_DIR:-/tmp} && \
		curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew-linux_amd64.tar.gz" && \
		tar zxvf "krew-linux_amd64.tar.gz" && \
		./krew-linux_amd64 install krew
/usr/local/bin/kubectx:
	@sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
	@sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
	@sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
