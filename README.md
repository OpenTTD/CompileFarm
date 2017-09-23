# OpenTTD-CF

This repository contains Docker files to produce binary for OpenTTD.

They are the Docker files as used by OpenTTD to produce binaries for releases,
nightlies, experimental branches, etc.

Windows binaries are not produced via Docker, and as such not part of this
repository.

## Installation

Run `./create.sh` to start building all the images. You will have to enter
a `OSXSDKURL` if you want to build OSX images, or use the value `IGNORE` if
you like to skip them.

The SDK can be created in various of ways if you have access to a Mac; google
around for that if you are interested.

## Running

To create a single binary, run:

```
./build.sh debian-stretch-amd64
```

If you want to know all valid images on your system, run:

```
docker images openttd-cf --format "{{.Tag}}"
```

Of course this heavily depend on what docker images you produced in the
installation step.

To create all binaries for all known images, run:

```
./build-all.sh
```

Resulting binaries will always be in `bundles/`.

