#!/bin/sh

set -e

echo ""
echo "Validating source"
echo "  OS: Linux"
echo "  Compiler: clang 3.9"
echo "  Arch: amd64"
echo ""

export CC=clang-3.9
export CXX=clang++-3.9
if [ -e "CMakeLists.txt" ]; then
    mkdir build
    cd build
    cmake ..
else
    ./configure --prefix-dir=/usr
fi

make -j2 all test
