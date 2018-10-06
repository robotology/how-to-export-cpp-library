#!/bin/bash
set -e

DIR=$(dirname "$(readlink -f "$0")")

# Update package manager and install packages
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y build-essential cmake ccache git
if [ "$CC" == "clang" ]; then apt-get install -y clang; fi

# Use ccache also for clang and clang++ on linux
if [ "$CC" == "clang" ]; then ln -sf ../../bin/ccache /usr/lib/ccache/clang; fi
if [ "$CC" == "clang" ]; then export CFLAGS="-Qunused-arguments"; fi
if [ "$CXX" == "clang++" ]; then ln -sf ../../bin/ccache /usr/lib/ccache/clang++; fi
if [ "$CXX" == "clang++" ]; then export CXXFLAGS="-Qunused-arguments"; fi

# Print system information
bash $DIR/system_info.sh

# Run script phase
bash $DIR/script.sh
