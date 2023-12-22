#!/bin/bash
set -e
if [ $# -ne 2 ]; then echo "USAGE: $0 [root-src-dir] [num-CPUs]"; exit 2; fi
srcDir=$1
ncpus=$2
buildDir=${srcDir}-build
installDir=${srcDir}-install
wdir=$(pwd -P)
mkdir -p $buildDir
mkdir -p $installDir
rm -r $buildDir
rm -r $installDir
mkdir -p $buildDir
pushd $buildDir
cmake ../${srcDir} \
  -DCMAKE_INSTALL_PREFIX=${wdir}/${installDir} \
  -DCMAKE_C_COMPILER=$(which gcc) \
  -DPYTHON_EXECUTABLE=$(which python)
make -j$ncpus
make install
popd
echo "DONE BUILDING ROOT. Installed in prefix $installDir"
