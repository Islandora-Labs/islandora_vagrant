echo "Installing Sleuthkit."

if [ -f "/vagrant/config" ]; then
  . /vagrant/config
fi

# Dependencies
apt-get install libafflib-dev afflib-tools libewf-dev ewf-tools -y --force-yes

# Clone and compile Sleuthkit
cd $HOME_DIR/git
git clone https://github.com/sleuthkit/sleuthkit.git
cd sleuthkit && ./bootstrap && ./configure && make && sudo make install && sudo ldconfig
