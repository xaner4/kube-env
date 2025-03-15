#!/bin/bash

kubectl_version="$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)"
kubectl_version_page="https://storage.googleapis.com/kubernetes-release/release/stable.txt"
kubectl_download_url="https://dl.k8s.io/${kubectl_version}/bin/${os,,}/${hardware_map[${hardware}]}/kubectl"

k9s_version="0.40.8"
k9s_version_page="derailed/k9s"
k9s_download_url="https://github.com/derailed/k9s/releases/download/v${k9s_version}/k9s_${os}_${hardware_map[${hardware}]}.tar.gz"

helm_version="3.17.2"
helm_version_page="helm/helm"
helm_download_url="https://get.helm.sh/helm-v${helm_version}-${os,,}-${hardware_map[${hardware}]}.tar.gz"

kubectx_version="0.9.5"
kubectx_version_page="ahmetb/kubectx"
kubectx_download_url="https://github.com/ahmetb/kubectx/releases/download/v${kubectx_version}/kubectx_v${kubectx_version}_${os,,}_${hardware}.tar.gz"

kubens_version="0.9.5"
kubens_version_page="ahmetb/kubectx"
kubens_download_url="https://github.com/ahmetb/kubectx/releases/download/v${kubens_version}/kubens_v${kubens_version}_${os,,}_${hardware}.tar.gz"

kubeseal_version="0.28.0"
kubeseal_version_page="bitnami-labs/sealed-secrets"
kubeseal_download_url="https://github.com/bitnami-labs/sealed-secrets/releases/download/v${kubeseal_version}/kubeseal-${kubeseal_version}-${os,,}-${hardware_map[${hardware}]}.tar.gz"

kustomize_version="5.6.0"
kustomize_version_page="kubernetes-sigs/kustomize"
kustomize_download_url="https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${kustomize_version}/kustomize_v${kustomize_version}_${os,,}_${hardware_map[${hardware}]}.tar.gz"

kompose_version="1.35.0"
kompose_version_page="kubernetes/kompose"
kompose_download_url="https://github.com/kubernetes/kompose/releases/download/v${kompose_version}/kompose-${os,,}-${hardware_map[${hardware}]}"

yq_version="4.45.1"
yq_version_page="mikefarah/yq"
yq_download_url="https://github.com/mikefarah/yq/releases/download/v${yq_version}/yq_${os,,}_${hardware_map[${hardware}]}.tar.gz"

jq_version="jq-1.7.1"
jq_version_page="jqlang/jq"
jq_download_url="https://github.com/jqlang/jq/releases/download/${jq_version}/jq-${os,,}-${hardware_map[${hardware}]}"

gh_version="2.68.1"
gh_version_page="cli/cli"
gh_download_url="https://github.com/cli/cli/releases/download/v${gh_version}/gh_${gh_version}_${os,,}_${hardware_map[${hardware}]}.tar.gz"
