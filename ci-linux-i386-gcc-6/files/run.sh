#!/bin/sh

set -e

echo ""
echo "Validating source"
echo "  OS: Linux"
echo "  Compiler: GCC 6"
echo "  Arch: i386"
echo ""

if [ -e "CMakeLists.txt" ]; then
    mkdir build
    cd build
    cmake ..
else
    ./configure --prefix-dir=/usr
fi

make -j2 all test
