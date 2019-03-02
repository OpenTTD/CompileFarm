#!/bin/sh

set -e

echo ""
echo "Validating source"
echo "  OS: Linux"
echo "  Compiler: clang 3.8"
echo "  Arch: amd64"
echo ""

if [ -e "CMakeLists.txt" ]; then
    mkdir build
    cd build
    cmake ..
else
    ./configure --prefix-dir=/usr
fi

make -j2 test
