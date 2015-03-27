echo "Installing Tesseract"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/config" ]; then
  . $SHARED_DIR/config
fi

if [ ! -d "$TESSDATA_HOME" ]; then
  mkdir $TESSDATA_HOME
fi

# Dependencies
apt-get install libleptonica-dev -y --force-yes

# Download and compile Tesseract
if [ ! -f "$DOWNLOAD_DIR/tesseract-ocr-$TESSERACT_VERSION.tar.gz" ]; then
  wget -q -O "$DOWNLOAD_DIR/tesseract-ocr-$TESSERACT_VERSION.tar.gz" "https://tesseract-ocr.googlecode.com/files/tesseract-ocr-$TESSERACT_VERSION.tar.gz"
fi

cd /tmp
cp "$DOWNLOAD_DIR/tesseract-ocr-$TESSERACT_VERSION.tar.gz" /tmp
tar -xzvf tesseract-ocr-$TESSERACT_VERSION.tar.gz
cd tesseract-ocr && ./autogen.sh && ./configure && make && sudo make install && sudo ldconfig
chown -hR vagrant:vagrant $TESSDATA_HOME
chmod -R 744 $TESSDATA_HOME
