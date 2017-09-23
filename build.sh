#!/bin/bash -ex

if [ -z "$1" ]; then
	set +x
	echo "Usage: $0 openttd-cf-image"
	echo "Example:"
	echo "  $0 debian-stretch-amd64"
	exit 1
fi

mkdir -p bundles

rm -rf build/$1
mkdir -p build/$1
cp -r source build/$1/

docker run --rm --user=`id -u`:`id -g` --mount type=bind,src=$(realpath build/$1),target=/workdir openttd-cf:$1

cp build/$1/source/bundles/* bundles/

