#!/bin/sh

set -e

if [ -z "$1" ]; then
	echo "Usage: $0 <version>"
	exit 1
fi

VERSION=$1
BASENAME="openttd-${VERSION}"

ARCH=`dpkg --print-architecture`

echo ""
echo "Creating .deb file"
echo "  Source: ${BASENAME}"
echo "  OS: Linux"
echo "  Compiler: GCC"
echo "  Arch: ${ARCH}"
echo ""

mkdir -p bundles
./configure --static-icu --without-xdg-basedir --prefix-dir=/usr
make
make bundle_gzip bundle_xz BUNDLE_NAME=${BASENAME}-linux-generic-${ARCH}
