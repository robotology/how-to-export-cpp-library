#!/bin/bash
set -e

# Print some more system information after installing all build tools
echo "-------------------- BEGIN SYSTEM INFORMATION --------------------"
uname -a
if [ "$TRAVIS_OS_NAME" == "linux" ]; then lsb_release -a;                     fi
if [ "$TRAVIS_OS_NAME" == "osx" ];   then system_profiler SPSoftwareDataType; fi
env
which cmake
cmake --version
which $CC
$CC --version
which $CXX
$CXX --version
which ccache
ccache --version
ccache -s
echo "--------------------  END SYSTEM INFORMATION  --------------------"
