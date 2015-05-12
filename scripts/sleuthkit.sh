echo "Installing Sleuthkit."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/config" ]; then
  . $SHARED_DIR/config
fi

# Dependencies
apt-get install libafflib-dev afflib-tools libewf-dev ewf-tools -y --force-yes

# Clone and compile Sleuthkit
cd $HOME_DIR/git
git clone https://github.com/sleuthkit/sleuthkit.git
cd sleuthkit && ./bootstrap && ./configure && make && make install && ldconfig
