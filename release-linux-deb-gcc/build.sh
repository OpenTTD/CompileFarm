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

    local distro=${target%%-*}
    target=${target#*-}

    local distro_tag=${target%%-*}
    target=${target#*-}

    local arch=${target}

    local image_name="${image_name}:linux-${distro}-${distro_tag}-${arch}-gcc"

    build_linux ${arch} ${distro} ${distro_tag} ${image_name}
}

read_targets ${base_image_name}
