#!/bin/bash -ex

if [ -z "${OSXSDKURL}" ]; then
	set +x
	echo "Please provide OSXSDKURL where in a folder osx-sdk the OSX SDKs are located"
	echo "  Their filename should be something like: MacOSX10.8.sdk.tar.xz"
	echo "Set to IGNORE to skip OSX images"
	exit 1
fi

if [ "$1" = "rebuild" ]; then
	rebuild="--no-cache"
else
	rebuild=""
fi

function create {
	cname="${arch}"
	if [ "${release}" != "" ]; then
		cname="${release}-${cname}"
	fi
	if [ "${os}" != "" ]; then
		cname="${os}-${cname}"
	fi

	d="generated/$cname"

	if [ "$1" = "linux" ]; then
		# Names of docker images can be prefixed with 'i386'; 'amd64' is implied, so left out
		if [ "${arch}" = "amd64" ]; then
			tag="${os}:${release}"
		else
			tag="${arch}/${os}:${release}"
		fi
	else
		# All our other images run on debian stretch
		tag="debian:stretch"
	fi

	docker pull ${tag}

	mkdir -p $d
	cat dockerfiles/Dockerfile-${1} | sed "s/@OS@/${os}/g;s/@RELEASE@/${release}/g;s/@ARCH@/${arch}/g;s#@TAG@#${tag}#g;s#@OSXSDKURL@#${OSXSDKURL}#g" > $d/Dockerfile
	cat dockerfiles/release-${1}.sh | sed "s/@OS@/${os}/g;s/@RELEASE@/${release}/g;s/@ARCH@/${arch}/g;s#@TAG@#${tag}#g" > $d/release.sh
	chmod +x $d/release.sh

	docker build ${rebuild} -t openttd-cf:${cname} $d
}

for arch in i386 amd64; do
	os="debian"
	for release in wheezy jessie stretch; do
		create linux
	done

	os="ubuntu"
	for release in trusty xenial zesty; do
		create linux
	done

	os="generic"
	release=""
	create generic
done

if [ "$OSXSDKURL" != "IGNORE" ]; then
	os="osx"
	arch="x86_64"
	release="10.8"
	create osx

	arch="i386"
	release="10.6"
	create osx
fi

os=""
arch="noarch"
release=""
create noarch

docker image prune -f
