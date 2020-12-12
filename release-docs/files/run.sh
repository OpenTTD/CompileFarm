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

if [ -e "CMakeLists.txt" ]; then
    (
        mkdir build
        cd build
        cmake ..
        make docs || true
    )
    mv build/docs/source docs/source
    mv build/docs/ai-api docs/aidocs
    mv build/docs/gs-api docs/gamedocs
else
    mkdir -p objs
    VERSION=${VERSION} doxygen
    (
        cd src/script/api
        VERSION=${VERSION} doxygen Doxyfile_AI
        VERSION=${VERSION} doxygen Doxyfile_Game
    )
fi

# Fixing a bug in a Debian patch on Doxygen
# https://bugs.launchpad.net/ubuntu/+source/doxygen/+bug/1631169
cp docs/source/html/dynsections.js docs/aidocs/html/
cp docs/source/html/dynsections.js docs/gamedocs/html/

mv docs/source ${BASENAME}-docs
mv docs/aidocs ${BASENAME}-docs-ai
mv docs/gamedocs ${BASENAME}-docs-gs

# To be consistent with other docker, put the result in the build folder
# when CMake is used.
if [ -e "CMakeLists.txt" ]; then
    BUNDLES_DIRECTORY=build/bundles
else
    BUNDLES_DIRECTORY=bundles
fi

mkdir -p ${BUNDLES_DIRECTORY}
tar --xz -cf ${BUNDLES_DIRECTORY}/${BASENAME}-docs.tar.xz ${BASENAME}-docs
tar --xz -cf ${BUNDLES_DIRECTORY}/${BASENAME}-docs-ai.tar.xz ${BASENAME}-docs-ai
tar --xz -cf ${BUNDLES_DIRECTORY}/${BASENAME}-docs-gs.tar.xz ${BASENAME}-docs-gs
