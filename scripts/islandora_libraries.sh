echo "Installing all Islandora Foundation module's required libraries"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/config" ]; then
  . $SHARED_DIR/config
fi

cd /var/www/html/drupal/sites/all/modules

sudo drush cache-clear drush
sudo drush -v videojs-plugin
sudo drush -v pdfjs-plugin
sudo drush -v iabookreader-plugin
sudo drush -v colorbox-plugin
sudo drush -v openseadragon-plugin
sudo drush -v -y en islandora_openseadragon

sudo chown -hR www-data:www-data /var/www/html/drupal/sites/all/libraries
sudo chmod -R 775 /var/www/html/drupal/sites/all/libraries
