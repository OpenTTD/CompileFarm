#!/bin/sh

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

VERSION=$1
BASENAME="openttd-${VERSION}"
#TARGET_ARCHITECTURE is an environment variable set in the Docker file

#Making the target architecture more explicit
case $TARGET_ARCHITECTURE in
"i686")
    ARCH_EXPLICIT=win32;;
"x86_64")
    ARCH_EXPLICIT=win64;;
*)
    ARCH_EXPLICIT=$TARGET_ARCHITECTURE;;
esac

echo ""
echo "Creating bundle"
echo "  Source: ${BASENAME}"
echo "  OS: Windows"
echo "  Compiler: mingw-w64 cross-compiler"
echo "  Host: Debian"
echo "  Target: ${ARCH_EXPLICIT}"
echo ""

mkdir -p bundles
env PKG_CONFIG_LIBDIR=/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib/pkgconfig \
    ./configure \
    --without-xdg-basedir \
    --host=${TARGET_ARCHITECTURE}-w64-mingw32 \
    --prefix=/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32 \
    --enable-static \
    --static-icu \
    --with-lzo2=/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib/liblzo2.a \
    CFLAGS="-I/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/include" \
    LDFLAGS="-L/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib"

make -j`nproc`
make bundle_zip BUNDLE_NAME=${BASENAME}-windows-${ARCH_EXPLICIT} 
