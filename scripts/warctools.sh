echo "Installing warctools."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/config" ]; then
  . $SHARED_DIR/config
fi

# Dependencies
apt-get install python-setuptools python-unittest2 -y --force-yes

# Clone and build warctools
cd $HOME_DIR/git
git clone https://github.com/internetarchive/warctools.git
cd warctools && ./setup.py build && sudo ./setup.py install
