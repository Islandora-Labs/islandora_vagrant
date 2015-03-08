echo "Installing all Islandora Foundation modules"

cd ~
wget https://raw.githubusercontent.com/ruebot/islandora-release-manager-helper-scripts/7.x-1.5/islandora-module-list-sans-tuque.txt

cd /var/www/html/drupal/sites/all/modules

cat ~/islandora-module-list-sans-tuque.txt | while read line; do
  git clone https://github.com/Islandora/$line
done

cd /var/www/html/drupal/sites/all
mkdir libraries
cd /var/www/html/drupal/sites/all/libraries
git clone https://github.com/Islandora/tuque

chown -hR www-data:www-data /var/www/html/drupal/sites/all/libraries
chown -hR www-data:www-data /var/www/html/drupal/sites/all/modules
chmod -R 775 /var/www/html/drupal/sites/all/libraries
chmod -R 775 /var/www/html/drupal/sites/all/modules

cd /var/www/html/drupal/sites/all/modules
drush -y en php_lib islandora objective_forms
drush -y en islandora_solr islandora_solr_metadata islandora_solr_facet_pages islandora_solr_views
drush -y en islandora_basic_collection islandora_pdf islandora_audio islandora_book islandora_compound_object islandora_disk_image islandora_entities islandora_entities_csv_import islandora_basic_image islandora_large_image islandora_newspaper islandora_video islandora_web_archive
drush -y en islandora_premis islandora_checksum islandora_checksum_checker
drush -y en islandora_solution_pack_collection islandora_solution_pack_pdf islandora_solution_pack_audio islandora_solution_pack_book islandora_solution_pack_compound islandora_solution_pack_disk_image islandora_solution_pack_entities islandora_solution_pack_image islandora_solution_pack_large_image islandora_solution_pack_newspaper islandora_solution_pack_video islandora_solution_pack_web_archive
drush -y en islandora_book_batch islandora_image_annotation islandora_pathauto islandora_pdfjs islandora_videojs
drush -y en xml_forms xml_form_builder xml_schema_api xml_form_elements xml_form_api jquery_update zip_importer islandora_basic_image islandora_bibliography islandora_compound_object islandora_google_scholar islandora_scholar_embargo islandora_solr_config citation_exporter doi_importer endnotexml_importer pmid_importer ris_importer
drush -y en islandora_internet_archive_bookreader islandora_openseadragon islandora_xmlsitemap islandora_bagit
