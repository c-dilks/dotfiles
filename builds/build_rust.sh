#!/bin/bash
# use rustup (https://github.com/rust-lang/rustup) to install rust, cargo, etc.
set -e
pushd rustup
./rustup-init.sh
popd
