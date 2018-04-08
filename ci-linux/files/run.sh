#!/bin/sh

set -e

ARCH=`dpkg --print-architecture`

echo ""
echo "Validating source"
echo "  OS: Linux"
echo "  Compiler: $(cat /etc/compiler-packages)"
echo "  Arch: ${ARCH}"
echo ""

./configure --prefix-dir=/usr
make test
