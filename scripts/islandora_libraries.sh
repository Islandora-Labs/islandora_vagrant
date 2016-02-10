#!/bin/bash

echo "Installing all Islandora Foundation module's required libraries"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  # shellcheck source=/dev/null
  . "$SHARED_DIR"/configs/variables
fi

cd "$DRUPAL_HOME"/sites/all/modules || exit

sudo drush cache-clear drush
sudo drush -v videojs-plugin
sudo drush -v pdfjs-plugin
sudo drush -v iabookreader-plugin
sudo drush -v colorbox-plugin
sudo drush -v openseadragon-plugin
sudo drush -v -y en islandora_openseadragon

# After last drush call from root user, change cache permissions
sudo chown -R vagrant:vagrant "$HOME_DIR"/.drush
