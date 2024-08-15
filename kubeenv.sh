#!/bin/bash

assets="./assets"
bin="./bin"

os=$(uname)
hardware=$(uname -m)
declare -A hardware_map
hardware_map["x86_64"]="amd64"
hardware_map["arm64"]="arm64"

kubectl_version="$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)"
kubectl_download_url="https://dl.k8s.io/${kubectl_version}/bin/${os,,}/${hardware_map[${hardware}]}/kubectl"
kubectl_checksum="https://dl.k8s.io/${kubectl_version}/bin/${os,,}/${hardware_map[${hardware}]}/kubectl.sha256"

helm_version="3.15.3"
helm_download_url="https://get.helm.sh/helm-v${helm_version}-${os,,}-${hardware_map[${hardware}]}.tar.gz"
helm_checksum="https://get.helm.sh/helm-v${helm_version}-${os,,}-${hardware_map[${hardware}]}.tar.gz.sha256sum"

kubectx_version="0.9.5"
kubectx_download_url="https://github.com/ahmetb/kubectx/releases/download/v${kubectx_version}/kubectx_v${kubectx_version}_${os,,}_${hardware}.tar.gz"
kubectx_checksum="https://github.com/ahmetb/kubectx/releases/download/v${kubectx_version}/checksums.txt"

kubens_version="0.9.5"
kubens_download_url="https://github.com/ahmetb/kubectx/releases/download/v${kubens_version}/kubens_v${kubens_version}_${os,,}_${hardware}.tar.gz"
kubens_checksum="https://github.com/ahmetb/kubectx/releases/download/v${kubens_version}/checksums.txt"

kubeseal_version="0.27.1"
kubeseal_download_url="https://github.com/bitnami-labs/sealed-secrets/releases/download/v${kubeseal_version}/kubeseal-${kubeseal_version}-${os,,}-${hardware_map[${hardware}]}.tar.gz"
kubeseal_checksum="https://github.com/bitnami-labs/sealed-secrets/releases/download/v${kubeseal_version}/sealed-secrets_${kubeseal_version}_checksums.txt"

Kustomize_version="5.4.3"
kustomize_download_url="https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${Kustomize_version}/kustomize_v${Kustomize_version}_${os,,}_${hardware_map[${hardware}]}.tar.gz"
kustomize_checksum="https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${Kustomize_version}/checksums.txt"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RESET='\033[0m'

function main() {
    if [[ ! -d ${bin} ]]; then
        mkdir -p ${bin}
    fi
    if [[ ! -d ${assets} ]]; then
        mkdir -p ${assets}
    fi

    kubectl_install
    helm_install
    kubectx_install
    kubens_install
    kubeseal_install
    kustomize_install
}


function log() {
    loglevel=${1,,}
    msg=${2}
    case ${loglevel} in
        info)
            echo -e "${GREEN}[+] ${msg}${RESET}"
            ;;
        notice)
            echo -e "${BLUE}[*] ${msg}${RESET}"
            ;;
        warn)
            echo -e "${YELLOW}[!] ${msg}${RESET}"
            ;;
        error)
            echo -e "${RED}[-] ${msg}${RESET}"
            ;;
    esac

}

function download() {
    # download <url>
    url="${1}"
    path="${assets}"
    filename="$(basename ${url})"
    if [[ -f "${assets}/${filename}" ]]; then
        log Notice "${filename} does already exists" 
        return
    fi
    log info "Downloading ${filename} from ${url} to ${path}"
    wget -P "$assets" -q "$url" 2>&1
    if [[ $? -gt 0 ]]; then
        log error "Downloading ${filename} failed"
        return
    fi
}

function unpack() {
    # unpack <download_url> <sublevel> <files>
    archive="${assets}/$(basename $1)"
    sublevel=${2}
    files="${@:3}"
    if [[ ! -f ${archive} ]]; then
        log error "${archive} does not exsist; Was it successfully downloaded?"
        return
    fi
    if [[ -f "${bin}/{${files}}" ]]; then
        log notice "${files} has already been packed out"
        return  
    fi
    case "${archive}" in
        *.tar.gz)
            tar --strip-components=${sublevel} -xzf  "${archive}" -C "${bin}" ${files}
        ;;
        *)
            log error "Not an know archive format"
        ;;
    esac
    

    if [[ $? -gt 0 ]]; then
        log warn "Not possible to unarchive ${assets}/${archive}"
        return
    else
        log info "${files} has been successfully packed out from ${archive}"
    fi
}

function kubectl_install() {
    download ${kubectl_download_url}
    mv ${assets}/$(basename ${kubectl_download_url}) ./bin/
}

function helm_install() {
    download ${helm_download_url}
    unpack ${helm_download_url} 1 "${os,,}-${hardware_map[${hardware}]}/helm"
}

function kubectx_install() {
    download ${kubectx_download_url}
    unpack ${kubectx_download_url} 0 kubectx
}

function kubens_install() {
    download ${kubens_download_url}
    unpack ${kubens_download_url} 0 kubens
}

function kubeseal_install() {
    download ${kubeseal_download_url}
    unpack ${kubeseal_download_url} 0 kubeseal
}

function kustomize_install() {
    download ${kustomize_download_url}
    unpack ${kustomize_download_url} 0 kustomize
}

main