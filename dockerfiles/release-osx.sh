#!/bin/sh

if [ -z "$1" ]; then
	echo "Usage: $0 <version>"
	exit 1
fi

VERSION=$1
BASENAME="openttd-${VERSION}"

OS_RELEASE=@RELEASE@
ARCH=@ARCH@
if [ "$OS_RELEASE" = "10.8" ]; then
	DARWIN=darwin12
elif [ "$OS_RELEASE" = "10.6" ]; then
	DARWIN=darwin10
else
	echo "Unknown release version: ${OS_RELEASE}"
	exit 2
fi

echo ""
echo "Creating OSX file"
echo "  Source: ${BASENAME}"
echo "  OS: Mac OS X"
echo "  Release: ${OS_RELEASE}"
echo "  Arch: ${ARCH}"
echo ""

# All MacPorts are compiled static (by removing the dylibs)
# FreeType says it needs bz2 only when compiling statically
# liblzma says it needs -pthread only when compiling statically, which clang doesn't understand
# In result, add bz2 manually to the LDFLAGS, and don't pass any static flag

LDFLAGS="-lbz2" ./configure --host=@ARCH@-apple-${DARWIN} --pkg-config=@ARCH@-apple-${DARWIN}-pkg-config
make
make bundle_zip BUNDLE_NAME=${BASENAME}-macosx-${OS_RELEASE}-${ARCH}

