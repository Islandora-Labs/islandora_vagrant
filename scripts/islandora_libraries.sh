echo "Installing all Islandora Foundation module's required libraries"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/config" ]; then
  . $SHARED_DIR/config
fi

cd /var/www/html/drupal/sites/all/modules

sudo drush cc all
sudo drush videojs-plugin
sudo drush pdfjs-plugin
sudo drush iabookreader-plugin
sudo drush colorbox-plugin
sudo drush openseadragon-plugin
sudo drush -y en islandora_openseadragon

sudo chown -hR www-data:www-data /var/www/html/drupal/sites/all/libraries
sudo chmod -R 775 /var/www/html/drupal/sites/all/libraries
