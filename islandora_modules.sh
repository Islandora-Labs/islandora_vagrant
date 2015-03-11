echo "Installing all Islandora Foundation modules"

# List of Islandora Foundation modules
cd /home/vagrant
wget https://raw.githubusercontent.com/ruebot/islandora-release-manager-helper-scripts/7.x-1.5/islandora-module-list-sans-tuque.txt

# Clone all Islandora Foundation modules
cd /var/www/html/drupal/sites/all/modules
cat /home/vagrant/islandora-module-list-sans-tuque.txt | while read line; do
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
drush -y en islandora_book_batch islandora_image_annotation islandora_pathauto islandora_pdfjs islandora_videojs
drush -y en xml_forms xml_form_builder xml_schema_api xml_form_elements xml_form_api jquery_update zip_importer islandora_basic_image islandora_bibliography islandora_compound_object islandora_google_scholar islandora_scholar_embargo islandora_solr_config citation_exporter doi_importer endnotexml_importer pmid_importer ris_importer
drush videojs-plugin
drush pdfjs-plugin
drush iabookreader-plugin
drush colorbox-plugin
#drush openseadragon-plugin -- ISLANDORA-1213 -- Installer is broken
####ISLANDORA-1213 WORKAROUND ############################################
cd /var/www/html/drupal/sites/all/libraries
wget http://openseadragon.github.io/releases/openseadragon-bin-0.9.129.zip
unzip openseadragon-bin-0.9.129.zip
mv openseadragon-bin-0.9.129 openseadragon
###########################################################################
drush -y en islandora_internet_archive_bookreader islandora_openseadragon islandora_xmlsitemap islandora_bagit islandora_simple_workflow islandora_fits islandora_marcxml islandora_oai islandora_ocr islandora_xacml_api islandora_xacml_editor islandora_xmlsitemap

# Permissions and ownership
chown -hR www-data:www-data /var/www/html/drupal/sites/all/libraries
chown -hR www-data:www-data /var/www/html/drupal/sites/all/modules
chmod -R 775 /var/www/html/drupal/sites/all/libraries
chmod -R 775 /var/www/html/drupal/sites/all/modules
