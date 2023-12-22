#!/bin/bash
set -e
pushd RubyROOT
mkdir -p build
mkdir -p install
rm -r build # clean
rm -r install # clean
cmake -Bbuild -S. \
  -DCMAKE_INSTALL_PREFIX=install \
  -DENABLE_MINUIT2=OFF \
  -DCMAKE_C_COMPILER=$(which gcc)
cmake --build build -j4 -- install
popd
