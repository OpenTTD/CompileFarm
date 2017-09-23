#!/bin/sh

if [ -z "$1" ]; then
	echo "Usage: $0 <version>"
	exit 1
fi

VERSION=$1
BASENAME="openttd-${VERSION}"

ARCH=`dpkg --print-architecture`

echo ""
echo "Creating linux-generic file"
echo "  Source: ${BASENAME}"
echo "  OS: Linux generic"
echo "  Arch: ${ARCH}"
echo ""

mkdir -p bundles
./configure --static-icu --without-xdg-basedir
make
make bundle_gzip bundle_xz BUNDLE_NAME=${BASENAME}-linux-generic-${ARCH}
