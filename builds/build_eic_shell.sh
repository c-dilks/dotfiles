#!/bin/bash
# install or update the EIC software container; basically
# a wrapper for `eic_container/install.sh`

set -e

# make a tmp directory (to avoid disk usage in /tmp)
TMPDIR=$HOME/tmp
mkdir -p $TMPDIR

# make subdirectory
mkdir -p eic
pushd eic

# update `eic_container` repo
if [ -d "eic_container" ]; then
  echo "[+] update eic_container repo..."
  pushd eic_container
  git pull
  popd
else
  echo "[+] clone eic_container repo..."
  git clone https://eicweb.phy.anl.gov/containers/eic_container.git
fi

# pull the container
echo "[+] execute install.sh..."
eic_container/install.sh -t $TMPDIR -n
popd
