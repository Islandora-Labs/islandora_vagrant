#!/bin/bash

echo "Installing warctools."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  . "$SHARED_DIR"/configs/variables
fi

# Set apt-get for non-interactive mode
export DEBIAN_FRONTEND=noninteractive

# Dependencies
apt-get install python-setuptools python-unittest2 -y --force-yes

# Clone and build warctools
cd /tmp
git clone https://github.com/internetarchive/warctools.git
cd warctools && ./setup.py build && ./setup.py install
