#!/bin/sh

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <image-name>"
fi

base_image_name=$1

. $(dirname $0)/../build-include.source

image_name="${base_image_name}:commit-checker"
build_linux $(dirname $0) ${DEFAULT_DISTRO} ${DEFAULT_DISTRO_TAG} ${image_name}
