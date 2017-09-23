#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <version>"
	exit 1
fi

VERSION=$1

BASENAME="openttd-${VERSION}"

function compress {
	tar --gzip -cf bundles/$1.tar.gz $1
	tar --xz -cf bundles/$1.tar.xz $1
	zip -9 -r bundles/$1.zip $1
}

echo ""
echo "Creating source bundle"
echo "  Source: ${BASENAME}"
echo ""

mkdir ${BASENAME}-source
rsync -ar --exclude ${BASENAME}-source --exclude .svn --exclude .hg --exclude .git  . ${BASENAME}-source

mkdir -p bundles

compress ${BASENAME}-source

echo ""
echo "Creating documentation bundle"
echo "  Source: ${BASENAME}"
echo ""

mkdir -p objs
doxygen
mv docs/source ${BASENAME}-docs
compress ${BASENAME}-docs

echo ""
echo "Creating API documentation bundle"
echo "  Source: ${BASENAME}"
echo ""

cd src/script/api
doxygen Doxyfile_AI
doxygen Doxyfile_Game
cd ../../..
mv docs/aidocs ${BASENAME}-aidocs
mv docs/gamedocs ${BASENAME}-gamedocs
compress ${BASENAME}-aidocs
compress ${BASENAME}-gamedocs
