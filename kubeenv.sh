#!/usr/bin/env bash

basedir="$(cd "$(dirname $(realpath "${BASH_SOURCE[0]}"))" >/dev/null 2>&1 && pwd)"

assets="${basedir}/assets"
bin="${basedir}/bin"

os="$(uname)"

hardware=$(uname -m)
declare -A hardware_map
hardware_map["x86_64"]="amd64"
hardware_map["arm64"]="arm64"

function main() {
    source "${basedir}/log.sh"
    source "${basedir}/kubeenv_software.sh"

    if [[ ! -d "${bin}" ]]; then
        mkdir -p "${bin}"
    fi
    if [[ ! -d "${assets}" ]]; then
        mkdir -p "${assets}"
    fi

    gh_install
    yq_install
    jq_install
    k9s_install
    helm_install
    krew_install
    kubens_install
    kubectl_install
    kubectx_install
    kubeseal_install
    headlamp_install
}

function download() {
    # download <url>
    if [[ -z "$(command -v wget)" ]];then
        log warn "wget is not installed, install with 'sudo apt install wget'"
        exit 1
    fi

    url="${1}"
    path="${assets}"
    filename="$(basename ${url})"
    if [[ -f "${assets}/${filename}" ]]; then
        log Notice "${filename} does already exists"
        return
    fi
    log info "Downloading ${filename} from ${url} to ${path}"
    wget -P "${assets}" -q "$url" 2>&1
    rc="${?}"
    if [[ "${rc}" -gt 0 ]]; then
        log error "Downloading ${filename} failed"
        return
    fi
}

function unpack() {
    # unpack <download_url> <sublevel> <files>
    archive="${assets}/$(basename $1)"
    sublevel="${2}"
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
            tar --strip-components="${sublevel}" -xzf "${archive}" -C "${bin}" "${files}" --warning=no-unknown-keyword
            rc="${?}"
        ;;
        *)
            log error "Not an know archive format"
            return
        ;;
    esac

    if [[ "${rc}" -gt 0 ]]; then
        log warn "Not possible to unarchive ${archive}"
        return
    else
        log info "${files} has been successfully packed out from ${archive}"
    fi
}

function kubectl_install() {
    download "${kubectl_download_url}"
    cp "${assets}/$(basename ${kubectl_download_url})" "${bin}"
    chmod +x "${bin}/$(basename ${kubectl_download_url})"
}

function yq_install() {
    download "${yq_download_url}"
    unpack "${yq_download_url}" 0 "./yq_${os,,}_${hardware_map[${hardware}]}"
    mv "${bin}/yq_${os,,}_${hardware_map[${hardware}]}" "${bin}/yq"
}

function gh_install() {
    download "${gh_download_url}"
    unpack "${gh_download_url}" 2 "gh_${gh_version}_${os,,}_${hardware_map[${hardware}]}/bin/gh"
}

function jq_install() {
    download "${jq_download_url}"
    mv "${assets}/jq-${os,,}-${hardware_map[${hardware}]}" "${bin}/jq"
    chmod +x "${bin}/jq"
}

function k9s_install() {
    download "${k9s_download_url}"
    unpack "${k9s_download_url}" 0 k9s
}

function krew_install() {
    download "${krew_download_url}"
    unpack "${krew_download_url}" 0 "./krew-${os,,}_${hardware_map[${hardware}]}"
    mv "${bin}/krew-${os,,}_${hardware_map[${hardware}]}" "${bin}/krew"
}

function helm_install() {
    download "${helm_download_url}"
    unpack "${helm_download_url}" 1 "${os,,}-${hardware_map[${hardware}]}/helm"
}

function kubectx_install() {
    download "${kubectx_download_url}"
    unpack "${kubectx_download_url}" 0 kubectx
}

function kubens_install() {
    download "${kubens_download_url}"
    unpack "${kubens_download_url}" 0 kubens
}

function kubeseal_install() {
    download "${kubeseal_download_url}"
    unpack "${kubeseal_download_url}" 0 kubeseal
}

function headlamp_install() {
    download "${headlamp_download_url}"
    unpack "${headlamp_download_url}" 1 "Headlamp-${headlamp_version}-${os,,}-x64/headlamp"
}

main
