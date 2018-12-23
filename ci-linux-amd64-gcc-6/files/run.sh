#!/bin/sh

set -e

echo ""
echo "Validating source"
echo "  OS: Linux"
echo "  Compiler: GCC 6"
echo "  Arch: amd64"
echo ""

./configure --prefix-dir=/usr
make test
