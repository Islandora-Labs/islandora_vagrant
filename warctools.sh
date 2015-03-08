echo "Installing warctools."

# Dependencies
apt-get install python-setuptools python-unittest2 -y --force-yes

# Clone and build warctools
cd ~
mkdir git
cd git
git clone https://github.com/internetarchive/warctools.git
cd warctools && ./setup.py build && sudo ./setup.py install
