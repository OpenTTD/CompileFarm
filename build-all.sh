#!/bin/bash -ex

mkdir -p bundles
rm -f bundles/*

for image in $(docker images openttd-cf --format "{{.Tag}}"); do
	$(realpath $(dirname $0))/build.sh ${image}
done
