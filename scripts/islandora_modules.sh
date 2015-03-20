echo "Installing all Islandora Foundation modules"

if [ -f "/vagrant/config" ]; then
  . /vagrant/config
else
  HOME_DIR="/home/vagrant"
fi

# List of Islandora Foundation modules
cd $HOME_DIR
wget https://raw.githubusercontent.com/ruebot/islandora-release-manager-helper-scripts/7.x-1.5/islandora-module-list-sans-tuque.txt

# Clone all Islandora Foundation modules
cd /var/www/html/drupal/sites/all/modules
cat $HOME_DIR/islandora-module-list-sans-tuque.txt | while read line; do
  git clone https://github.com/Islandora/$line
done

# Clone Tuque
cd /var/www/html/drupal/sites/all
mkdir libraries
cd /var/www/html/drupal/sites/all/libraries
git clone https://github.com/Islandora/tuque

# Permissions and ownership
chown -hR www-data:www-data /var/www/html/drupal/sites/all/libraries
chown -hR www-data:www-data /var/www/html/drupal/sites/all/modules
chmod -R 775 /var/www/html/drupal/sites/all/libraries
chmod -R 775 /var/www/html/drupal/sites/all/modules

# Enable all Islandora foundation modules
cd /var/www/html/drupal/sites/all/modules
drush -y en php_lib islandora objective_forms
drush -y en islandora_solr islandora_solr_metadata islandora_solr_facet_pages islandora_solr_views
drush -y en islandora_basic_collection islandora_pdf islandora_audio islandora_book islandora_compound_object islandora_disk_image islandora_entities islandora_entities_csv_import islandora_basic_image islandora_large_image islandora_newspaper islandora_video islandora_web_archive
drush -y en islandora_premis islandora_checksum islandora_checksum_checker
drush -y en islandora_book_batch islandora_image_annotation islandora_pathauto islandora_pdfjs islandora_videojs islandora_jwplayer
drush -y en xml_forms xml_form_builder xml_schema_api xml_form_elements xml_form_api jquery_update zip_importer islandora_basic_image islandora_bibliography islandora_compound_object islandora_google_scholar islandora_scholar_embargo islandora_solr_config citation_exporter doi_importer endnotexml_importer pmid_importer ris_importer
drush videojs-plugin
drush pdfjs-plugin
drush iabookreader-plugin
drush colorbox-plugin
#drush openseadragon-plugin -- ISLANDORA-1213 -- Installer is broken
####ISLANDORA-1213 WORKAROUND ############################################
cd /var/www/html/drupal/sites/all/libraries
if [ ! -f "$DOWNLOAD_DIR/openseadragon-bin.zip" ]; then
  echo "Downloading OpenSeadragon"
  wget-q -O "$DOWNLOAD_DIR/openseadragon-bin.zip" "http://openseadragon.github.io/releases/openseadragon-bin-0.9.129.zip"
fi
unzip $DOWNLOAD_DIR/openseadragon-bin.zip -d $DRUPAL_LIBRARIES
mv $DRUPAL_LIBRARIES/openseadragon-bin-0.9.129 $DRUPAL_LIBRARIES/openseadragon
###########################################################################
drush -y en islandora_internet_archive_bookreader islandora_openseadragon islandora_xmlsitemap islandora_bagit islandora_simple_workflow islandora_fits islandora_marcxml islandora_oai islandora_ocr islandora_xacml_api islandora_xacml_editor islandora_xmlsitemap

#BagItPHP library
cd /var/www/html/drupal/sites/all/libraries
git clone git://github.com/scholarslab/BagItPHP.git

# Permissions and ownership
chown -hR www-data:www-data /var/www/html/drupal/sites/all/libraries
chown -hR www-data:www-data /var/www/html/drupal/sites/all/modules
chmod -R 775 /var/www/html/drupal/sites/all/libraries
chmod -R 775 /var/www/html/drupal/sites/all/modules

# Set variables for Islandora modules

cd /var/www/html/drupal/sites/all/modules
drush eval "variable_set('islandora_audio_viewers', array('name' => array('none' => 'none', 'islandora_videojs' => 'islandora_videojs'), 'default' => 'islandora_videojs'))"
drush eval "variable_set('islandora_fits_executable_path', '/usr/local/fits/fits-0.8.4/fits.sh')"
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
drush eval "variable_set('islandora_ocr_tesseract', '/usr/local/bin/tesseract')"
drush eval "variable_set('islandora_batch_java', '/usr/bin/java')"
drush eval "variable_set('image_toolkit', 'imagemagick')"
drush eval "variable_set('imagemagick_convert', '/usr/bin/convert')"
