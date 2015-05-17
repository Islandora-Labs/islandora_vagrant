echo "Installing all Islandora Foundation modules"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  . $SHARED_DIR/configs/variables
fi

cd /var/www/drupal/sites/all

drush make --yes --no-core --contrib-destination=. $SHARED_DIR/configs/islandora.drush.make

if [ ! -d libraries ]; then
  mkdir libraries
fi

# Check for a user's .drush folder, create if it doesn't exist
if [ ! -d "$HOME_DIR/.drush" ]; then
  mkdir "$HOME_DIR/.drush"
  chown vagrant:vagrant $HOME_DIR/.drush
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

# Enable all modules identified in the drush makefile
cd /var/www/drupal/sites/all/modules
# Extract all the module directory names from the drush makefile so we can loop through them
MODULES=$(grep -v "^;" $SHARED_DIR/configs/islandora.drush.make | grep -oh "projects\[[A-Za-z_]*\]" | sed "s/projects\[//" | sed "s/\]/ /" | tr -d '\n')
for MODULE in $MODULES
do
  # Get the module's absolute path
  MODULEPATH=/var/www/drupal/sites/all/modules/$MODULE
  # For each module, find all its .info files (there could be more than one)
  INFOFILES=$(find $MODULEPATH -name '*.info' -exec basename {} \;)
  for INFOFILE in $INFOFILES
  do
    # Remove the .info extension
    INFOFILE=$(echo $INFOFILE | sed "s/\.info$//")
    drush --yes en $INFOFILE
  done
done  

# BagItPHP library
cd /var/www/drupal/sites/all/libraries
git clone git://github.com/scholarslab/BagItPHP.git

# Permissions and ownership
chown -hR www-data:www-data /var/www/drupal/sites/all/libraries
chown -hR www-data:www-data /var/www/drupal/sites/all/modules
chmod -R 775 /var/www/drupal/sites/all/libraries
chmod -R 775 /var/www/drupal/sites/all/modules

cd /var/www/drupal/sites/all/modules

# Set variables for Islandora modules
drush eval "variable_set('islandora_audio_viewers', array('name' => array('none' => 'none', 'islandora_videojs' => 'islandora_videojs'), 'default' => 'islandora_videojs'))"
drush eval "variable_set('islandora_fits_executable_path', '/usr/local/fits/fits-0.8.5/fits.sh')"
drush eval "variable_set('islandora_lame_url', '/usr/bin/lame')"
drush eval "variable_set('islandora_video_viewers', array('name' => array('none' => 'none', 'islandora_videojs' => 'islandora_videojs'), 'default' => 'islandora_videojs'))"
drush eval "variable_set('islandora_video_ffmpeg_path', '/usr/local/bin/ffmpeg')"
drush eval "variable_set('islandora_book_viewers', array('name' => array('none' => 'none', 'islandora_internet_archive_bookreader' => 'islandora_internet_archive_bookreader'), 'default' => 'islandora_internet_archive_bookreader'))"
drush eval "variable_set('islandora_book_page_viewers', array('name' => array('none' => 'none', 'islandora_openseadragon' => 'islandora_openseadragon'), 'default' => 'islandora_openseadragon'))"
drush eval "variable_set('islandora_large_image_viewers', array('name' => array('none' => 'none', 'islandora_openseadragon' => 'islandora_openseadragon'), 'default' => 'islandora_openseadragon'))"
drush eval "variable_set('islandora_use_kakadu', TRUE)"
drush eval "variable_set('islandora_newspaper_issue_viewers', array('name' => array('none' => 'none', 'islandora_internet_archive_bookreader' => 'islandora_internet_archive_bookreader'), 'default' => 'islandora_internet_archive_bookreader'))"
drush eval "variable_set('islandora_newspaper_page_viewers', array('name' => array('none' => 'none', 'islandora_openseadragon' => 'islandora_openseadragon'), 'default' => 'islandora_openseadragon'))"
drush eval "variable_set('islandora_pdf_create_fulltext', 1)"
drush eval "variable_set('islandora_checksum_enable_checksum', TRUE)"
drush eval "variable_set('islandora_ocr_tesseract', '/usr/bin/tesseract')"
drush eval "variable_set('islandora_ocr_tesseract_enabled_languages', array('English', 'French')"
drush eval "variable_set('islandora_batch_java', '/usr/bin/java')"
drush eval "variable_set('image_toolkit', 'imagemagick')"
drush eval "variable_set('imagemagick_convert', '/usr/bin/convert')"
