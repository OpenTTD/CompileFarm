# OpenTTD-docker-cf

A collection of Dockerfiles which are prepared to compile OpenTTD in all kind
of flavours.

The images created from these Dockerfiles are used by the Compile Farm of
OpenTTD to produce all the official releases since 1.9.0. This includes
binaries like nightlies, experimentals, release-candidates, forks, etc.

## Requirements

Install the latest Docker CE. At least 17.05 is needed.

## Building

The images are created by Docker Hub Automated Builds, and can be found
under:

https://hub.docker.com/r/openttd/compile-farm/

They can simply be pulled like:

```
docker pull openttd-cf:debian-stretch-amd64
```

If you want to build them yourself, simply run 'make' in the root directory.
This will produce all the images. More specific targets are available; check
the Makefile for more details.

## Running (releases)

To compile your source via a Docker, simply create a new directory, say
'build', and put in there a folder called 'source' with the source you would
like to compile. The Docker will put some temporary files in the 'build'
folder, but mostly it will work inside the 'source' folder.

Now run from your build folder:

```
docker run --rm --user=`id -u`:`id -g` -v $(realpath $(pwd)):/workdir openttd-cf:<your flavor>
```

This will produce the resulting binaries in the bundles directory of your
source directory. Depending on the target, this can be a zip, deb, ..

## Running (CI)

The dockers marked 'ci' are meant for code validation and tests
(like regression-check). These don't produce any binaries, but only validate
that the new code is correct. It follows the above chapter exactly, with a few
key differences:

 - The image name is not 'openttd-cf', but 'openttd-cf-ci'.
 - When running the docker, it doesn't produce any output in bundles folder.

## Listing current images

To list all the images you currently have on your system, simply run:

```
docker images openttd-cf --format "{{.Tag}}"
```

Or for all the CI images:

```
docker images openttd-cf-ci --format "{{.Tag}}"
```

## Targets

In this repository you see different folders, each for their own target.

A short walkthrough:

 - linux-ci: targets that only validate sources on errors.
 - linux-deb: targets that produce .deb files (Debian and Ubuntu).
 - linux-generic: targets that produce tarballs (for any Linux OS).
 - noarch: targets that produce source tarballs and documentation.
 - osx: targets that produce .zip files to work on Mac OS X.

