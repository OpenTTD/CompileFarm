#!/bin/bash -ex

mkdir -p binaries
rm -f binaries/*

for c in generated/*; do
	rm -rf $c/workdir
	mkdir -p $c/workdir
	cp -r source $c/workdir/source
	docker run --id=`id -u`:`id -g` --mount type=bind,src=$(realpath $c/workdir),target=/workdir openttd-cf:$(basename ${c})
	cp $c/workdir/source/bundles/* binaries
done

docker container prune -f

