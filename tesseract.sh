echo "Installing Tesseract"

TESSDATA_HOME=/usr/local/share/tessdata
TESSERACT_VERSION=3.02.02

mkdir $TESSDATA_HOME

# Dependencies
apt-get install libleptonica-dev -y --force-yes

# Download and compile Tesseract
cd /tmp
wget "https://tesseract-ocr.googlecode.com/files/tesseract-ocr-$TESSERACT_VERSION.tar.gz"
tar -xzvf tesseract-ocr-$TESSERACT_VERSION.tar.gz
cd tesseract-ocr && ./autogen.sh && ./configure && make && sudo make install && sudo ldconfig
chown -hR vagrant:vagrant $TESSDATA_HOME
chmod -R 744 $TESSDATA_HOME
