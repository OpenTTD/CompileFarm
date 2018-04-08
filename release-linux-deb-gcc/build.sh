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

    local image_name="${image_name}:linux-${target}-gcc"

    local distro=${target%%-*}
    target=${target#*-}

    local distro_tag=${target%%-*}
    target=${target#*-}

    local arch=${target}

    # Debian has "slim" images, which are drastically smaller
    if [ "${distro}" = "debian" ]; then
        distro_tag="${distro_tag}-slim"
    fi
    if [ "${arch}" != "amd64" ]; then
        distro="${arch}/${distro}"
    fi

    build $(dirname $0) ${distro} ${distro_tag} ${image_name}
}

read_targets ${base_image_name}
