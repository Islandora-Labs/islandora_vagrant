#!/bin/bash

echo "Installing all Islandora Foundation modules"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  . "$SHARED_DIR"/configs/variables
fi

# Permissions and ownership
sudo chown -hR vagrant:www-data "$DRUPAL_HOME"/sites/all/libraries
sudo chown -hR vagrant:www-data "$DRUPAL_HOME"/sites/all/modules
sudo chown -hR vagrant:www-data "$DRUPAL_HOME"/sites/default/files
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/libraries
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/modules
sudo chmod -R 755 "$DRUPAL_HOME"/sites/default/files

# Clone all Islandora Foundation modules
cd "$DRUPAL_HOME"/sites/all/modules
while read LINE; do
  git clone https://github.com/Islandora/"$LINE"
done < "$SHARED_DIR"/configs/islandora-module-list-sans-tuque.txt

# Set git filemode false for git
cd "$DRUPAL_HOME"/sites/all/modules
while read LINE; do
  cd "$LINE"
  git config core.filemode false
  cd "$DRUPAL_HOME"/sites/all/modules
done < "$SHARED_DIR"/configs/islandora-module-list-sans-tuque.txt

# Clone Tuque and BagItPHP
cd "$DRUPAL_HOME"/sites/all
if [ ! -d libraries ]; then
  mkdir libraries
fi
cd "$DRUPAL_HOME"/sites/all/libraries
git clone https://github.com/Islandora/tuque.git
git clone git://github.com/scholarslab/BagItPHP.git

cd "$DRUPAL_HOME"/sites/all/libraries/tuque
git config core.filemode false
cd "$DRUPAL_HOME"/sites/all/libraries/BagItPHP
git config core.filemode false

# Check for a user's .drush folder, create if it doesn't exist
if [ ! -d "$HOME_DIR/.drush" ]; then
  mkdir "$HOME_DIR/.drush"
  sudo chown vagrant:vagrant "$HOME_DIR"/.drush
fi

# Move OpenSeadragon drush file to user's .drush folder
if [ -d "$HOME_DIR/.drush" -a -f "$DRUPAL_HOME/sites/all/modules/islandora_openseadragon/islandora_openseadragon.drush.inc" ]; then
  mv "$DRUPAL_HOME/sites/all/modules/islandora_openseadragon/islandora_openseadragon.drush.inc" "$HOME_DIR/.drush"
fi

# Move video.js drush file to user's .drush folder
if [ -d "$HOME_DIR/.drush" -a -f "$DRUPAL_HOME/sites/all/modules/islandora_videojs/islandora_videojs.drush.inc" ]; then
  mv "$DRUPAL_HOME/sites/all/modules/islandora_videojs/islandora_videojs.drush.inc" "$HOME_DIR/.drush"
fi

# Move pdf.js drush file to user's .drush folder
if [ -d "$HOME_DIR/.drush" -a -f "$DRUPAL_HOME/sites/all/modules/islandora_pdfjs/islandora_pdfjs.drush.inc" ]; then
  mv "$DRUPAL_HOME/sites/all/modules/islandora_pdfjs/islandora_pdfjs.drush.inc" "$HOME_DIR/.drush"
fi

# Move IA Bookreader drush file to user's .drush folder
if [ -d "$HOME_DIR/.drush" -a -f "$DRUPAL_HOME/sites/all/modules/islandora_internet_archive_bookreader/islandora_internet_archive_bookreader.drush.inc" ]; then
  mv "$DRUPAL_HOME/sites/all/modules/islandora_internet_archive_bookreader/islandora_internet_archive_bookreader.drush.inc" "$HOME_DIR/.drush"
fi

