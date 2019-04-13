#!/bin/sh

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

VERSION=$1
BASENAME="openttd-${VERSION}"

echo ""
echo "Creating .deb file"
echo "  Source: ${BASENAME}"
echo "  OS: Linux"
echo "  Compiler: GCC"
echo "  Distro: ${DISTRO}"
echo "  Release: ${RELEASE}"
echo "  Arch: ${ARCH}"
echo ""

if [ -e "CMakeLists.txt" ]; then
    mkdir build
    cd build
    cmake ..
    make -j2 package
    mv bundles/*.deb bundles/${BASENAME}-linux-${DISTRO}-${RELEASE}-${ARCH}.deb
else
    ln -sf os/debian debian && mkdir -p bundles
    fakeroot make -j2 -f debian/rules binary
    mv ../*dbg*.deb bundles/${BASENAME}-linux-${DISTRO}-${RELEASE}-${ARCH}-dbg.deb
    mv ../*.deb bundles/${BASENAME}-linux-${DISTRO}-${RELEASE}-${ARCH}.deb
fi
