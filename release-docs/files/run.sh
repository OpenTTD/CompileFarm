#!/bin/sh

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

VERSION=$1
BASENAME="openttd-${VERSION}"

echo ""
echo "Creating docs"
echo "  Source: ${BASENAME}"
echo ""

mkdir -p objs
doxygen

mkdir -p bundles
mv docs/source ${BASENAME}-docs

tar --xz -cf bundles/${BASENAME}-docs.tar.xz ${BASENAME}-docs
