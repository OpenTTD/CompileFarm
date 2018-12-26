#!/bin/sh

set -e

echo ""
echo "Validating source"
echo "  OS: Linux"
echo "  Compiler: GCC 6"
echo "  Arch: i386"
echo ""

./configure --prefix-dir=/usr
make -j2 test
