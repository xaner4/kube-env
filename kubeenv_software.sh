#!/usr/bin/env bash

export kubectl_version="$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)"
export kubectl_version_page="https://storage.googleapis.com/kubernetes-release/release/stable.txt"
export kubectl_download_url="https://dl.k8s.io/${kubectl_version}/bin/${os,,}/${hardware_map[${hardware}]}/kubectl"

export k9s_version="0.50.9"
export k9s_version_page="derailed/k9s"
export k9s_download_url="https://github.com/derailed/k9s/releases/download/v${k9s_version}/k9s_${os}_${hardware_map[${hardware}]}.tar.gz"

export helm_version="3.18.6"
export helm_version_page="helm/helm"
export helm_download_url="https://get.helm.sh/helm-v${helm_version}-${os,,}-${hardware_map[${hardware}]}.tar.gz"

export kubectx_version="0.9.5"
export kubectx_version_page="ahmetb/kubectx"
export kubectx_download_url="https://github.com/ahmetb/kubectx/releases/download/v${kubectx_version}/kubectx_v${kubectx_version}_${os,,}_${hardware}.tar.gz"

export krew_version="0.4.5"
export krew_version_page="kubernetes-sigs/krew"
export krew_download_url="https://github.com/kubernetes-sigs/krew/releases/download/v${krew_version}/krew-${os,,}_${hardware_map[${hardware}]}.tar.gz"

export kubens_version="0.9.5"
export kubens_version_page="ahmetb/kubectx"
export kubens_download_url="https://github.com/ahmetb/kubectx/releases/download/v${kubens_version}/kubens_v${kubens_version}_${os,,}_${hardware}.tar.gz"

export kubeseal_version="0.31.0"
export kubeseal_version_page="bitnami-labs/sealed-secrets"
export kubeseal_download_url="https://github.com/bitnami-labs/sealed-secrets/releases/download/v${kubeseal_version}/kubeseal-${kubeseal_version}-${os,,}-${hardware_map[${hardware}]}.tar.gz"

export yq_version="4.47.1"
export yq_version_page="mikefarah/yq"
export yq_download_url="https://github.com/mikefarah/yq/releases/download/v${yq_version}/yq_${os,,}_${hardware_map[${hardware}]}.tar.gz"

export jq_version="jq-1.8.1"
export jq_version_page="jqlang/jq"
export jq_download_url="https://github.com/jqlang/jq/releases/download/${jq_version}/jq-${os,,}-${hardware_map[${hardware}]}"

export gh_version="2.78.0"
export gh_version_page="cli/cli"
export gh_download_url="https://github.com/cli/cli/releases/download/v${gh_version}/gh_${gh_version}_${os,,}_${hardware_map[${hardware}]}.tar.gz"

export headlamp_version="0.35.0"
export headlamp_version_page="kubernetes-sigs/headlamp"
export headlamp_download_url="https://github.com/kubernetes-sigs/headlamp/releases/download/v${headlamp_version}/Headlamp-${headlamp_version}-${os,,}-x64.tar.gz" #fuck mac users
