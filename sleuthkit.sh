echo "Installing Sleuthkit."

sudo apt-get install libafflib-dev afflib-tools libewf-dev ewf-tools

cd ~/git
git clone https://github.com/sleuthkit/sleuthkit.git
cd sleuthkit && ./bootstrap && ./configure && make && sudo make install && sudo ldconfig
