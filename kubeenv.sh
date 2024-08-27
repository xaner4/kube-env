#!/bin/bash

assets="./assets"
bin="./bin"

os=$(uname)
hardware=$(uname -m)
declare -A hardware_map
hardware_map["x86_64"]="amd64"
hardware_map["arm64"]="arm64"

function main() {
    source log.sh
    source kubeenv_software.sh
    check_version
    if [[ ! -d ${bin} ]]; then
        mkdir -p ${bin}
    fi
    if [[ ! -d ${assets} ]]; then
        mkdir -p ${assets}
    fi

    kubectl_install
    k9s_install
    helm_install
    kubectx_install
    kubens_install
    kubeseal_install
    kustomize_install
    yq_install
}

function check_version() {
    current=$(cat version)
    latest=$(curl -s https://raw.githubusercontent.com/xaner4/kube-env/main/version)
    if [[ ${latest} -gt ${current} ]]; then
        log notice "New version available\n\tcurrent: ${RED}v${current}${RESET}\n\t${BLUE}latest:${RESET}  ${GREEN}v${latest}${RESET}"
        exit 1
    fi
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
            tar --strip-components=${sublevel} -xzf "${archive}" -C "${bin}" ${files}
        ;;
        *)
            log error "Not an know archive format"
        ;;
    esac
    

    if [[ $? -gt 0 ]]; then
        log warn "Not possible to unarchive ${archive}"
        return
    else
        log info "${files} has been successfully packed out from ${archive}"
    fi
}

function kubectl_install() {
    download ${kubectl_download_url}
    cp ${assets}/$(basename ${kubectl_download_url}) ${bin}
    chmod +x ${bin}/$(basename ${kubectl_download_url})
}

function k9s_install() {
    download ${k9s_download_url}
    unpack ${k9s_download_url} 0 k9s
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

function yq_install() {
    download ${yq_download_url}
    unpack ${yq_download_url} 0 ./yq_${os,,}_${hardware_map[${hardware}]}
}
main