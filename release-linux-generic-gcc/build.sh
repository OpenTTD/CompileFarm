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

    local image_name="${image_name}:linux-generic-${target}-gcc"

    local distro=${DEFAULT_DISTRO}
    local arch=${target}

    if [ "${arch}" != "amd64" ]; then
        distro="${arch}/${distro}"
    fi

    build $(dirname $0) ${distro} ${DEFAULT_DISTRO_TAG} ${image_name}
}

read_targets ${base_image_name}
