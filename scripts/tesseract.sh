echo "Installing Tesseract"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/config" ]; then
  . $SHARED_DIR/config
fi

apt-get -y install tesseract-ocr tesseract-ocr-eng tesseract-ocr-fra
