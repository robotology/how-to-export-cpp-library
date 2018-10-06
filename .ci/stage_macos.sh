#!/bin/bash
set -e

# Update package manager and install packages
brew update
brew install ccache
export PATH="/usr/local/opt/ccache/libexec:$PATH"

# Print system information
bash ./.ci/system_info.sh

# Run script phase
bash ./.ci/script.sh
