#!/bin/sh

if [ -z "${GENERATOR}" ]; then
  echo "No Generator has been set"
  exit 1
fi

##. ./versions.sh
eval $(grep HDF5_VER versions.cmd | sed -e 's/set/export/')
VER=${HDF5_VER}

rm -rf lib/src/hdf5-${VER}
rm -rf lib/build/hdf5-${VER}
rm -rf lib/install/hdf5-${VER}

mkdir -p lib/src
cd lib/src
tar xvzf ../../CMake-hdf5-${VER}.tar.gz
cd ../..


ctest -S hdf5.cmake -DCONF_DIR:STRING=debug   "-DCTEST_CMAKE_GENERATOR:STRING=${GENERATOR}" -C Debug   -VV -O ${SGEN}-hdf5-debug.log
ctest -S hdf5.cmake -DCONF_DIR:STRING=release "-DCTEST_CMAKE_GENERATOR:STRING=${GENERATOR}" -C Release -VV -O ${SGEN}-hdf5-release.log
