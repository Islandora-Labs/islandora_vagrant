#!/bin/bash

echo "Installing all Islandora Foundation modules"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  # shellcheck source=/dev/null
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
cd "$DRUPAL_HOME"/sites/all/modules || exit
while read -r LINE; do
  git clone https://github.com/Islandora/"$LINE"
done < "$SHARED_DIR"/configs/islandora-module-list-sans-tuque.txt

# Set git filemode false for git
cd "$DRUPAL_HOME"/sites/all/modules || exit
while read -r LINE; do
  cd "$LINE" || exit
  git config core.filemode false
  cd "$DRUPAL_HOME"/sites/all/modules || exit
done < "$SHARED_DIR"/configs/islandora-module-list-sans-tuque.txt

# Clone Tuque, BagItPHP, and Cite-Proc
cd "$DRUPAL_HOME"/sites/all || exit
if [ ! -d libraries ]; then
  mkdir libraries
fi
cd "$DRUPAL_HOME"/sites/all/libraries || exit
git clone https://github.com/Islandora/tuque.git
git clone git://github.com/scholarslab/BagItPHP.git
git clone https://github.com/Islandora/citeproc-php.git

cd "$DRUPAL_HOME"/sites/all/libraries/tuque || exit
git config core.filemode false
cd "$DRUPAL_HOME"/sites/all/libraries/BagItPHP || exit
git config core.filemode false

# Check for a user's .drush folder, create if it doesn't exist
if [ ! -d "$HOME_DIR/.drush" ]; then
  mkdir "$HOME_DIR/.drush"
  sudo chown vagrant:vagrant "$HOME_DIR"/.drush
fi

# Move OpenSeadragon drush file to user's .drush folder
if [ -d "$HOME_DIR/.drush" ] && [ -f "$DRUPAL_HOME/sites/all/modules/islandora_openseadragon/islandora_openseadragon.drush.inc" ]; then
  mv "$DRUPAL_HOME/sites/all/modules/islandora_openseadragon/islandora_openseadragon.drush.inc" "$HOME_DIR/.drush"
fi

# Move video.js drush file to user's .drush folder
if [ -d "$HOME_DIR/.drush" ] && [ -f "$DRUPAL_HOME/sites/all/modules/islandora_videojs/islandora_videojs.drush.inc" ]; then
  mv "$DRUPAL_HOME/sites/all/modules/islandora_videojs/islandora_videojs.drush.inc" "$HOME_DIR/.drush"
fi

# Move pdf.js drush file to user's .drush folder
if [ -d "$HOME_DIR/.drush" ] && [ -f "$DRUPAL_HOME/sites/all/modules/islandora_pdfjs/islandora_pdfjs.drush.inc" ]; then
  mv "$DRUPAL_HOME/sites/all/modules/islandora_pdfjs/islandora_pdfjs.drush.inc" "$HOME_DIR/.drush"
fi

# Move IA Bookreader drush file to user's .drush folder
if [ -d "$HOME_DIR/.drush" ] && [ -f "$DRUPAL_HOME/sites/all/modules/islandora_internet_archive_bookreader/islandora_internet_archive_bookreader.drush.inc" ]; then
  mv "$DRUPAL_HOME/sites/all/modules/islandora_internet_archive_bookreader/islandora_internet_archive_bookreader.drush.inc" "$HOME_DIR/.drush"
fi

drush -y -u 1 en php_lib islandora objective_forms
drush -y -u 1 en islandora_solr islandora_solr_metadata islandora_solr_facet_pages islandora_solr_views
drush -y -u 1 en islandora_basic_collection islandora_pdf islandora_audio islandora_book islandora_compound_object islandora_disk_image islandora_entities islandora_entities_csv_import islandora_basic_image islandora_large_image islandora_newspaper islandora_video islandora_web_archive
drush -y -u 1 en islandora_premis islandora_checksum islandora_checksum_checker
drush -y -u 1 en islandora_book_batch islandora_pathauto islandora_pdfjs islandora_videojs islandora_jwplayer
drush -y -u 1 en xml_forms xml_form_builder xml_schema_api xml_form_elements xml_form_api jquery_update zip_importer islandora_basic_image islandora_bibliography islandora_compound_object islandora_google_scholar islandora_scholar_embargo islandora_solr_config citation_exporter doi_importer endnotexml_importer pmid_importer ris_importer
drush -y -u 1 en islandora_fits islandora_ocr islandora_oai islandora_marcxml islandora_simple_workflow islandora_xacml_api islandora_xacml_editor islandora_xmlsitemap colorbox islandora_internet_archive_bookreader islandora_bagit islandora_batch_report islandora_usage_stats islandora_form_fieldpanel islandora_altmetrics islandora_populator islandora_newspaper_batch 

cd "$DRUPAL_HOME"/sites/all/modules || exit

# Set variables for Islandora modules
drush eval "variable_set('islandora_audio_viewers', array('name' => array('none' => 'none', 'islandora_videojs' => 'islandora_videojs'), 'default' => 'islandora_videojs'))"
drush eval "variable_set('islandora_fits_executable_path', '$FITS_HOME/fits-$FITS_VERSION/fits.sh')"
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
drush eval "variable_set('islandora_checksum_checksum_type', 'SHA-1')"
drush eval "variable_set('islandora_ocr_tesseract', '/usr/bin/tesseract')"
drush eval "variable_set('islandora_batch_java', '/usr/bin/java')"
drush eval "variable_set('image_toolkit', 'imagemagick')"
drush eval "variable_set('imagemagick_convert', '/usr/bin/convert')"
