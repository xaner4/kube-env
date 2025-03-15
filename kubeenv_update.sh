#!/bin/bash

function main() {
    source log.sh
    source kubeenv_software.sh

    github_release_tag "yq"
    github_release_tag "jq"
    github_release_tag "gh"
    github_release_tag "k9s"
    github_release_tag "helm"
    github_release_tag "kubens"
    github_release_tag "kubectx"
    github_release_tag "kompose"
    github_release_tag "kubeseal"
    github_release_tag "kustomize"
}

function github_release_tag() {
    software_name=${1}
    version_var="${software_name}_version"
    current_version="${!version_var}"
    repo_var="${software_name}_version_page"
    org_repo=${!repo_var}
    latest=$(curl -sL https://api.github.com/repos/${org_repo}/releases/latest | jq -r ".tag_name" | awk -F'/' '{print $NF}' | sed 's/^v//')
    if [[ ${?} -gt 0 || ${latest} == "null" ]];then
        log error "Could not fetch Github version from ${org_repo}"
        return
    fi

    if [ "${current_version}" == "${latest}" ]; then
        log info "${software_name} is already latest"
        return
    fi

    update_version "${software_name}" "${latest}"
    log info "${software_name} has been updated from '${current_version}' -> '${latest}'"
}

function update_version() {
    software_name="${1}"
    version_var="${software_name}_version"
    current_version="${!version_var}"
    latest="${2}"
    
    sed -i "s|${software_name}_version=\"${current_version}\"|${software_name}_version=\"${latest}\"|g" kubeenv_software.sh
    if [[ $? -gt 0 ]]; then
        log error "Something went wrong updating version for ${software_name}"
        return
    fi
    log notice "${software_name} has been update to version ${latest}"
}

main
