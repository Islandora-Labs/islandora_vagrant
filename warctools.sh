echo "Installing warctools."

apt-get install python-setuptools python-unittest2 -y --force-yes
cd ~
mkdir git
cd git
git clone https://github.com/internetarchive/warctools.git
cd warctools && ./setup.py build && sudo ./setup.py install
