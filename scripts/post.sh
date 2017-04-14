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
echo ' ___  ________  ___       ________  ________   ________  ________  ________  ________           '
echo '|\  \|\   ____\|\  \     |\   __  \|\   ___  \|\   ___ \|\   __  \|\   __  \|\   __  \          '
echo '\ \  \ \  \___|\ \  \    \ \  \|\  \ \  \\ \  \ \  \_|\ \ \  \|\  \ \  \|\  \ \  \|\  \         '
echo ' \ \  \ \_____  \ \  \    \ \   __  \ \  \\ \  \ \  \ \\ \ \  \\\  \ \   _  _\ \   __  \        '
echo '  \ \  \|____|\  \ \  \____\ \  \ \  \ \  \\ \  \ \  \_\\ \ \  \\\  \ \  \\  \\ \  \ \  \       '
echo '   \ \__\____\_\  \ \_______\ \__\ \__\ \__\\ \__\ \_______\ \_______\ \__\\ _\\ \__\ \__\      '
echo '    \|__|\_________\|_______|\|__|\|__|\|__| \|__|\|_______|\|_______|\|__|\|__|\|__|\|__|      '
echo ' ________    ___    ___            _____     ________          ________  ________   _______     '
echo '|\_____  \  |\  \  /  /|          / __  \   |\  ___  \        |\   __  \|\   ____\ /  ___  \    '
echo ' \|___/  /| \ \  \/  / /________ |\/_|\  \  \ \____   \       \ \  \|\  \ \  \___|/__/|_/  /|   '
echo '     /  / /  \ \    / /\_________\|/ \ \  \  \|____|\  \       \ \   _  _\ \  \   |__|//  / /   '
echo '    /  / /__  /     \/\|_________|    \ \  \ ___ __\_\  \       \ \  \\  \\ \  \____  /  /_/__  '
echo '   /__/ /\__\/  /\   \                 \ \__\\__\\_______\       \ \__\\ _\\ \_______\\________\'
echo '   |__|/\|__/__/ /\ __\                 \|__\|__\|_______|        \|__|\|__|\|_______|\|_______|'
echo '            |__|/ \|__|                                                                         '
echo '                                                                                                '
EOT
