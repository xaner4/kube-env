#!/bin/bash

kubectl_version="$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)"
kubectl_version_page="https://storage.googleapis.com/kubernetes-release/release/stable.txt"
kubectl_download_url="https://dl.k8s.io/${kubectl_version}/bin/${os,,}/${hardware_map[${hardware}]}/kubectl"
kubectl_checksum="https://dl.k8s.io/${kubectl_version}/bin/${os,,}/${hardware_map[${hardware}]}/kubectl.sha256"

k9s_version="0.32.5"
k9s_version_page="derailed/k9s"
k9s_download_url="https://github.com/derailed/k9s/releases/download/v${k9s_version}/k9s_${os}_${hardware_map[${hardware}]}.tar.gz"

helm_version="3.15.4"
helm_version_page="helm/helm"
helm_download_url="https://get.helm.sh/helm-v${helm_version}-${os,,}-${hardware_map[${hardware}]}.tar.gz"
helm_checksum="https://get.helm.sh/helm-v${helm_version}-${os,,}-${hardware_map[${hardware}]}.tar.gz.sha256sum"

kubectx_version="0.9.5"
kubectx_version_page="ahmetb/kubectx"
kubectx_download_url="https://github.com/ahmetb/kubectx/releases/download/v${kubectx_version}/kubectx_v${kubectx_version}_${os,,}_${hardware}.tar.gz"
kubectx_checksum="https://github.com/ahmetb/kubectx/releases/download/v${kubectx_version}/checksums.txt"

kubens_version="0.9.5"
kubens_version_page="ahmetb/kubectx"
kubens_download_url="https://github.com/ahmetb/kubectx/releases/download/v${kubens_version}/kubens_v${kubens_version}_${os,,}_${hardware}.tar.gz"
kubens_checksum="https://github.com/ahmetb/kubectx/releases/download/v${kubens_version}/checksums.txt"

kubeseal_version="0.27.1"
kubeseal_version_page="bitnami-labs/sealed-secrets"
kubeseal_download_url="https://github.com/bitnami-labs/sealed-secrets/releases/download/v${kubeseal_version}/kubeseal-${kubeseal_version}-${os,,}-${hardware_map[${hardware}]}.tar.gz"
kubeseal_checksum="https://github.com/bitnami-labs/sealed-secrets/releases/download/v${kubeseal_version}/sealed-secrets_${kubeseal_version}_checksums.txt"

kustomize_version="5.4.3"
kustomize_version_page="kubernetes-sigs/kustomize"
kustomize_download_url="https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${Kustomize_version}/kustomize_v${Kustomize_version}_${os,,}_${hardware_map[${hardware}]}.tar.gz"
kustomize_checksum="https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${Kustomize_version}/checksums.txt"

yq_version="4.44.3"
yq_version_page="mikefarah/yq"
yq_download_url="https://github.com/mikefarah/yq/releases/download/v${yq_version}/yq_${os,,}_${hardware_map[${hardware}]}.tar.gz"