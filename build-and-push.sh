#!/usr/bin/env bash

shopt -s globstar
set -e

mkdir -p build

pip install jinja2-cli

ubuntu_versions="18.04 20.04 22.04"
debian_versions="10 11"

templates=(*.j2)

process_templates() {
    local distro=$1
    local versions=$2
    local templates=$(grep -l "{{ ${distro}_version }}" "${templates[@]}")

    for template in $templates; do
        echo "${distro^} template: $template"
        for version in $versions; do
            image_name=$(basename "$template" .Dockerfile.j2)
            dockerfile="${image_name}-${version}.Dockerfile"
            jinja2 -o "build/${dockerfile}" -D "${distro}_version=${version}" $template
        done
    done
}

process_templates "ubuntu" "$ubuntu_versions"
process_templates "debian" "$debian_versions"

for dockerfile in **/*.Dockerfile; do
    image_name=$(basename "$dockerfile" .Dockerfile)
    docker build -t ${REGISTRY}/${OWNER}/${image_name}:latest -f "$dockerfile" .
    docker push ${REGISTRY}/${OWNER}/${image_name}:latest
done
