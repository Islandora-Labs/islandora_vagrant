echo "Installing Sleuthkit."

# Dependencies
apt-get install libafflib-dev afflib-tools libewf-dev ewf-tools -y --force-yes

# Clone and compile Sleuthkit
cd /home/vagrant/git
git clone https://github.com/sleuthkit/sleuthkit.git
cd sleuthkit && ./bootstrap && ./configure && make && sudo make install && sudo ldconfig
