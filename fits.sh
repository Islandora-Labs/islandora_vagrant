echo "Installing FITS"

FITS_HOME=/usr/local/fits
FITS_VERSION=0.8.4_0

mkdir $FITS_HOME
sudo chown vagrant:vagrant $FITS_HOME
cd $FITS_HOME
wget "http://projects.iq.harvard.edu/files/fits/files/fits-$FITS_VERSION.zip"
unzip fits-$FITS_VERSION.zip
cd fits*
chmod +x fits.sh
chmod +x fits-env.sh
