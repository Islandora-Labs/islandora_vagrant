#!/bin/bash

# Setup a user for Tomcat Manager
sed -i '$i<role rolename="admin-gui"/>' /etc/tomcat7/tomcat-users.xml
sed -i '$i<user username="islandora" password="islandora" roles="manager-gui,admin-gui"/>' /etc/tomcat7/tomcat-users.xml
service tomcat7 restart

# Set correct permissions on sites/default/files
chmod -R 775 /var/www/drupal/sites/default/files

# Allow anonymous & authenticated users to view repository objects
drush --root=/var/www/drupal role-add-perm "anonymous user" "view fedora repository objects"
drush --root=/var/www/drupal role-add-perm "authenticated user" "view fedora repository objects"
drush --root=/var/www/drupal cc all

#Last chance to fix locale

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

# Lets brand this a bit

cat <<'EOT' >> /home/vagrant/.bashrc
echo ' _____  _____ _               _   _ _____   ____  _____            '
echo '|_   _|/ ____| |        /\   | \ | |  __ \ / __ \|  __ \     /\    '
echo '  | | | (___ | |       /  \  |  \| | |  | | |  | | |__) |   /  \   '
echo '  | |  \___ \| |      / /\ \ | . ` | |  | | |  | |  _  /   / /\ \  '
echo ' _| |_ ____) | |____ / ____ \| |\  | |__| | |__| | | \ \  / ____ \ '
echo '|_____|_____/|______/_/    \_\_| \_|_____/ \____/|_|  \_\/_/    \_\'
echo '                                (                '
echo '     )                )     )   )\ )   (      )  '
echo '  ( /(     )       ( /(  ( /(  (()/(   )\  ( /(  '
echo '  )\()) ( /(  ___  )\()) )\())  /(_))(((_) )\()) '
echo ' ((_)\  )\())|___|((_)\ ((_)\  (_))  )\___((_)\  '
echo '|__  / ((_)\       / (_)/ _(_) | _ \((/ __|/ (_) '
echo '  / /_ \ \ /       | | _\_, /  |   / | (__ | |   '
echo ' /_/(_)/_\_\       |_|(_)/_/   |_|_\  \___||_|   '
echo '                                                 '
EOT
