#!/usr/bin/env bash

basedir="$(cd "$(dirname $(realpath "${BASH_SOURCE[0]}"))" >/dev/null 2>&1 && pwd)"

function main() {
    source "${basedir}/log.sh"
    source "${basedir}/kubeenv_software.sh"

    github_release_tag "yq"
    github_release_tag "jq"
    github_release_tag "gh"
    github_release_tag "k9s"
    github_release_tag "helm"
    github_release_tag "krew"
    github_release_tag "kubens"
    github_release_tag "kubectx"
    github_release_tag "kubeseal"
    github_release_tag "headlamp"
}

function github_release_tag() {
    software_name="${1}"
    version_var="${software_name}_version"
    current_version="${!version_var}"
    repo_var="${software_name}_version_page"
    org_repo="${!repo_var}"
    latest=$(curl -sL https://api.github.com/repos/${org_repo}/releases/latest | grep tag_name | awk -F'"' '{gsub(/^v/, "", $4); print $4}')
    rc=${?}
    if [[ "${rc}" -gt 0 || "${latest}" == "null" || "${latest}" == "" ]];then
        log error "Could not fetch Github version from ${org_repo}"
        return
    fi

    if [ "${current_version}" == "${latest}" ]; then
        log info "${software_name} is already latest"
        return
    fi

    update_version "${software_name}" "${latest}"
}

function update_version() {
    software_name="${1}"
    version_var="${software_name}_version"
    current_version="${!version_var}"
    latest="${2}"

    rc=0
    if [[ "$(uname)" == "Linux" ]]; then
        sed -i "s|${software_name}_version=\"${current_version}\"|${software_name}_version=\"${latest}\"|g" "${basedir}/kubeenv_software.sh"
        rc="${?}"
    elif [[ "$(uname)" == "Darwin" ]]; then
        # macOS (BSD sed) requires an explicit backup suffix; use empty string ''
        sed -i '' "s|${software_name}_version=\"${current_version}\"|${software_name}_version=\"${latest}\"|g" "${basedir}/kubeenv_software.sh"
        rc="${?}"
    fi

    if [[ "${rc}" -gt 0 ]]; then
        log error "Something went wrong updating version for ${software_name}"
        return
    fi
    log notice "${software_name} has been update to version ${latest} from ${current_version}"
}

main
