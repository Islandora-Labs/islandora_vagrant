echo "Installing all Islandora Foundation modules"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  . $SHARED_DIR/configs/variables
fi

# Permissions and ownership
sudo chown -hR vagrant:web /var/www/drupal/sites/all/libraries
sudo chown -hR vagrant:web /var/www/drupal/sites/all/modules
sudo chmod -R 775 /var/www/drupal/sites/all/libraries
sudo chmod -R 775 /var/www/drupal/sites/all/modules

# Clone all Islandora Foundation modules
cd /var/www/drupal/sites/all/modules
cat $SHARED_DIR/configs/islandora-module-list-sans-tuque.txt | while read LINE; do
  git clone https://github.com/Islandora/$LINE
done

# Clone Tuque and BagItPHP
cd /var/www/drupal/sites/all
if [ ! -d libraries ]; then
  mkdir libraries
fi
cd /var/www/drupal/sites/all/libraries
git clone https://github.com/Islandora/tuque
git clone git://github.com/scholarslab/BagItPHP.git

# Check for a user's .drush folder, create if it doesn't exist
if [ ! -d "$HOME_DIR/.drush" ]; then
  mkdir "$HOME_DIR/.drush"
  sudo chown vagrant:vagrant $HOME_DIR/.drush
fi

# Move OpenSeadragon drush file to user's .drush folder
if [ -d "$HOME_DIR/.drush" -a -f "/var/www/drupal/sites/all/modules/islandora_openseadragon/islandora_openseadragon.drush.inc" ]; then
  mv "/var/www/drupal/sites/all/modules/islandora_openseadragon/islandora_openseadragon.drush.inc" "$HOME_DIR/.drush"
fi

# Move video.js drush file to user's .drush folder
if [ -d "$HOME_DIR/.drush" -a -f "/var/www/drupal/sites/all/modules/islandora_videojs/islandora_videojs.drush.inc" ]; then
  mv "/var/www/drupal/sites/all/modules/islandora_videojs/islandora_videojs.drush.inc" "$HOME_DIR/.drush"
fi

# Move pdf.js drush file to user's .drush folder
if [ -d "$HOME_DIR/.drush" -a -f "/var/www/drupal/sites/all/modules/islandora_pdfjs/islandora_pdfjs.drush.inc" ]; then
  mv "/var/www/drupal/sites/all/modules/islandora_pdfjs/islandora_pdfjs.drush.inc" "$HOME_DIR/.drush"
fi

# Move IA Bookreader drush file to user's .drush folder
if [ -d "$HOME_DIR/.drush" -a -f "/var/www/drupal/sites/all/modules/islandora_internet_archive_bookreader/islandora_internet_archive_bookreader.drush.inc" ]; then
  mv "/var/www/drupal/sites/all/modules/islandora_internet_archive_bookreader/islandora_internet_archive_bookreader.drush.inc" "$HOME_DIR/.drush"
fi

