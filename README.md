# OpenTTD-CF

A collection of Dockerfiles which are prepared to compile OpenTTD in all kind
of flavours.

The images created from these Dockerfiles are used by the Compile Farm of
OpenTTD to produce all the official releases since 1.9.0. This includes
binaries like nightlies, experimentals, release-candidates, forks, etc.

## Requirements

Install the latest Docker CE. At least 17.05 is needed.

## Building

The images are created and published on Docker Hub, and can be found under:

https://hub.docker.com/r/openttd/compile-farm/
https://hub.docker.com/r/openttd/compile-farm-ci/

They can simply be pulled like:

```bash
docker pull openttd/compile-farm:linux-debian-stretch-amd64-gcc
docker pull openttd/compile-farm-ci:linux-amd64-gcc
```

If you want to build them yourself, things get a bit more complicated. To
avoid code duplication, best is to look in azure-pipelines.yml for the full
set of what is being created.

## Running (releases)

To compile your source via a Docker, simply create a new directory, say
'build', and put in there a folder called 'source' with the source you would
like to compile. The Docker will put some temporary files in the 'build'
folder, but mostly it will work inside the 'source' folder.

Now run from your build folder:

```bash
docker run --rm --user=`id -u`:`id -g` -v $(realpath $(pwd)):/workdir openttd/compile-farm:<your flavor>
```

This will produce the resulting binaries in the bundles directory of your
source directory. Depending on the target, this can be a zip, deb, ..

## Running (CI)

The dockers marked 'ci' are meant for code validation and tests
(like regression-check). These don't produce any binaries, but only validate
that the new code is correct. It follows the above chapter exactly, with a few
key differences:

- The image name is not 'openttd/compile-farm', but 'openttd/compile-farm-ci'.
- When running the docker, it doesn't produce any output in bundles folder.

## Listing current images

To list all the images you currently have on your system, simply run:

```bash
docker images openttd/compile-farm --format "{{.Tag}}"
```

Or for all the CI images:

```bash
docker images openttd/compile-farm-ci --format "{{.Tag}}"
```

## Targets

In this repository you see different folders, each for their own target.

A short walkthrough:

- ci-commit-checker: scripts to validate commit / commit messages.
- ci-linux-*: targets that only validate sources on errors.
- release-linux-deb-gcc: targets that produce .deb files (Debian and Ubuntu).
- release-linux-generic-gcc: targets that produce tarballs (for any Linux OS, build with GCC).
