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

Run `./build.sh` to build all the binaries for all the images you just
created. If you want to build one specific binary, look in that file to see
how to do that.

