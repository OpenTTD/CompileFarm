#!/bin/sh

if [ -z "$1" ]; then
	echo "Usage: $0 <version>"
	exit 1
fi

VERSION=$1
BASENAME="openttd-${VERSION}"

if [ -e "/etc/os-release" ]; then
	OS="debian"
	OS_RELEASE=`cat /etc/os-release | awk -F"[)(]+" '/VERSION=/ {print $2}'`
else
	OS="ubuntu"
	OS_RELEASE=`cat /etc/lsb-release | awk -F= '/DISTRIB_CODENAME=/ {print $2}'`
fi

ARCH=`dpkg --print-architecture`

echo ""
echo "Creating .deb file"
echo "  Source: ${BASENAME}"
echo "  OS: Linux"
echo "  Distro: ${OS}"
echo "  Release: ${OS_RELEASE}"
echo "  Arch: ${ARCH}"
echo ""

ln -sf os/debian debian && mkdir -p bundles
fakeroot make -f debian/rules binary
mv ../*dbg*.deb bundles/${BASENAME}-linux-${OS}-${OS_RELEASE}-${ARCH}-dbg.deb
mv ../*.deb bundles/${BASENAME}-linux-${OS}-${OS_RELEASE}-${ARCH}.deb
