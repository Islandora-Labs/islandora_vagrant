echo "Installing FITS"

FITS_HOME=/usr/local/fits
FITS_VERSION=0.8.4_0

# Setup FITS_HOME
mkdir $FITS_HOME
sudo chown vagrant:vagrant $FITS_HOME

# Download and deploy FITS
cd $FITS_HOME
wget "http://projects.iq.harvard.edu/files/fits/files/fits-$FITS_VERSION.zip"
unzip fits-$FITS_VERSION.zip
cd fits*
chmod +x fits.sh
chmod +x fits-env.sh
