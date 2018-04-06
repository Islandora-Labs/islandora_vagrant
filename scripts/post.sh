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
