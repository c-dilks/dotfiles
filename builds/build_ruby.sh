#!/bin/bash
# use rbenv and ruby-install to install a local copy of ruby, to $(pwd)/.rbenv

set -e

VERSION=3.2.2

function sep() {
  echo """
$*
++++++++++++++++++++++++++++++++++++++++"""
}

export RBENV_ROOT=$(pwd)/.rbenv
sep "install rbenv"
git clone https://github.com/rbenv/rbenv.git .rbenv
# pushd .rbenv
# src/configure
# make -C src
# popd

export PATH=$RBENV_ROOT/bin:$PATH
eval "$(.rbenv/bin/rbenv init - bash)"
export PYTHON=$(which python) # for pycall gem

sep "install ruby-build"
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git $(rbenv root)/plugins/ruby-build

sep "install ruby version $VERSION"
export RUBY_BUILD_BUILD_PATH=.ruby
mkdir -p RUBY_BUILD_BUILD_PATH
rbenv install --verbose $VERSION
rbenv global $VERSION

echo 'done; now make sure you have `eval "$(rbenv init - zsh)"` in your .zshrc file'
