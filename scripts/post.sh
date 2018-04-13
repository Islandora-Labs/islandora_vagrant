#!/bin/bash

# Setup a user for Tomcat Manager
sed -i '$i<role rolename="admin-gui"/>' /etc/tomcat7/tomcat-users.xml
sed -i '$i<user username="islandora" password="islandora" roles="manager-gui,admin-gui"/>' /etc/tomcat7/tomcat-users.xml
service tomcat7 restart

# Set correct permissions on sites/default/files
chmod -R 775 /var/www/drupal/sites/default/files

# Update Drupal and friends to something recent
drush --root=/var/www/drupal -v -y pm-update

# Allow anonymous & authenticated users to view repository objects
drush --root=/var/www/drupal role-add-perm "anonymous user" "view fedora repository objects"
drush --root=/var/www/drupal role-add-perm "authenticated user" "view fedora repository objects"
drush --root=/var/www/drupal cc all


# Config cantaloupe 
export CANTALOUPE_RUNNING=$(curl -Is -m 10 http://127.0.0.1:8080/cantaloupe/iiif/2 | head -n 1)

if [ "$CANTALOUPE_RUNNING" = "HTTP/1.1 200 OK" ] && [ "$CANTALOUPE_SETUP" = "TRUE" ] ; then

    drush --root=/var/www/drupal vset islandora_openseadragon_tilesource iiif
    drush --root=/var/www/drupal vset islandora_openseadragon_iiif_url http://localhost:8000/iiif/2
    drush --root=/var/www/drupal vget islandora_openseadragon_iiif_token_header
    drush --root=/var/www/drupal vset islandora_openseadragon_iiif_token_header 1
    drush --root=/var/www/drupal vset islandora_openseadragon_iiif_identifier [islandora_openseadragon:pid]~[islandora_openseadragon:dsid]~[islandora_openseadragon:token]

    drush --root=/var/www/drupal vset islandora_internet_archive_bookreader_iiif_identifier [islandora_iareader:pid]~[islandora_iareader:dsid]~[islandora_iareader:token]
    drush --root=/var/www/drupal vset islandora_internet_archive_bookreader_iiif_url http://localhost:8000/iiif/2
    drush --root=/var/www/drupal vset islandora_internet_archive_bookreader_iiif_token_header 1
    drush --root=/var/www/drupal vset islandora_internet_archive_bookreader_pagesource iiif
fi

# Adds path variables to vagrant user
if [ -f /vagrant/configs/variables ]; then
    . /vagrant/configs/variables
fi

# Lets brand this a bit

cat <<'EOT' >> /home/vagrant/.bashrc

echo '┌----------------------------------------------------------------------┐'
echo '| Welcome to the Islandora 7.x Development box. Islandora is at        |'
echo '| http://localhost:8000.                                               |'
echo '|                                                                      |'
echo '| User: admin                                                          |'
echo '| Pass: islandora                                                      |'
echo '|                                                                      |'
echo '| More information available at the Islandora Vagrant github:          |'
echo '| https://github.com/Islandora-Labs/islandora_vagrant/                 |'
echo '└----------------------------------------------------------------------┘'
echo ''

EOT
