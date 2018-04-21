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

    local osx_version=${target}

    local image_name="${image_name}:osx-${osx_version}"

    build_osx "10.13" ${image_name} "--build-arg" "OSX_DEPLOYMENT_TARGET=${osx_version}"
}

read_targets ${base_image_name}
