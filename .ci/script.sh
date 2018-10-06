#!/bin/bash
set -e

cd $TRAVIS_BUILD_DIR
mkdir build
cd build
cmake -DBUILD_TESTING:BOOL=ON -DCMAKE_BUILD_TYPE=${TRAVIS_BUILD_TYPE} ..
cmake --build . --config $TRAVIS_BUILD_TYPE
make
make test
