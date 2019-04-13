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

mv docs/source ${BASENAME}-docs
mv docs/aidocs ${BASENAME}-docs-ai
mv docs/gamedocs ${BASENAME}-docs-gs

# To be consistent with other docker, put the result in the build folder
# when CMake is used.
if [ -e "CMakeLists.txt" ]; then
    mkdir -p build
    cd build
fi

mkdir -p bundles
tar --xz -cf bundles/${BASENAME}-docs.tar.xz ${BASENAME}-docs
tar --xz -cf bundles/${BASENAME}-docs-ai.tar.xz ${BASENAME}-docs-ai
tar --xz -cf bundles/${BASENAME}-docs-gs.tar.xz ${BASENAME}-docs-gs
