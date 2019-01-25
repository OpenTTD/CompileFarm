#!/bin/sh

set -ex

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

(
    cd src/script/api
    doxygen Doxyfile_AI
    doxygen Doxyfile_Game
)

mv docs/source ${BASENAME}-docs-source
mv docs/aidocs ${BASENAME}-docs-ai
mv docs/gamedocs ${BASENAME}-docs-gs

mkdir -p bundles
tar --xz -cf bundles/${BASENAME}-docs-source.tar.xz ${BASENAME}-docs-source
tar --xz -cf bundles/${BASENAME}-docs-ai.tar.xz ${BASENAME}-docs-ai
tar --xz -cf bundles/${BASENAME}-docs-gs.tar.xz ${BASENAME}-docs-gs
