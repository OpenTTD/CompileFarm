#!/bin/sh

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <image-name>"
fi

base_image_name=$1

. $(dirname $0)/../build-include.source

build_target() {
    local image_name=$1
    local target=$2

    local compiler=${target%-*}
    target=${target##*-}

    local image_name="${image_name}:linux-${target}-${compiler}"

    local arch=${target}

    . $(dirname $0)/compilers/${compiler}.inc

    local distro=${DISTRO}

    if [ "${arch}" != "amd64" ]; then
        distro="${arch}/${distro}"
    fi

    build_linux $(dirname $0) ${distro} ${DISTRO_TAG} ${image_name} "--build-arg" "EXTRA_PACKAGES=${EXTRA_PACKAGES}"
}

read_targets ${base_image_name}
