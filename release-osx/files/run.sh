#!/bin/sh

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

VERSION=$1
BASENAME="openttd-${VERSION}"

case $(cat /etc/sdk-version) in
    10.11) darwin=darwin15 ;;
    10.12) darwin=darwin16 ;;
    10.13) darwin=darwin17 ;;
    *)
        echo "Unknown SDK version $(cat /etc/sdk-version)"
        exit 1
        ;;
esac

echo ""
echo "Creating .zip file for Mac OS X"
echo "  OS: OSX"
echo "  SDK Version: $(cat /etc/sdk-version)"
echo "  Target version: $(cat /etc/target-version)"
echo "  Darwin: ${darwin}"
echo ""

compiler=x86_64-apple-${darwin}

# OpenTTD doesn't auto-detect clang (only GCC) for build
export CC=clang
export CXX=clang++

# OpenTTD doesn't auto-detect clang (only GCC) for host
# Compile static, as we never want to link to (possibly incompatible) dylib/tbd
./configure \
    --host=${compiler} \
    --cc-host=${compiler}-cc \
    --cxx-host=${compiler}-c++ \
    --pkg-config=${compiler}-pkg-config \
    --enable-static
make
make bundle_zip BUNDLE_NAME=${BASENAME}-macosx-$(cat /etc/target-version)-x86_64
