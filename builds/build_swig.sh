#!/bin/bash
set -e
pushd swig # symlink to your preferred swig version
mkdir -p install
rm -r install
./configure --prefix=$(pwd -P)/install
make
make install
popd
