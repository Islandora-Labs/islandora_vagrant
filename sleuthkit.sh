echo "Installing Sleuthkit."

# Dependencies
sudo apt-get install libafflib-dev afflib-tools libewf-dev ewf-tools

# Clone and compile Sleuthkit
cd ~/git
git clone https://github.com/sleuthkit/sleuthkit.git
cd sleuthkit && ./bootstrap && ./configure && make && sudo make install && sudo ldconfig
