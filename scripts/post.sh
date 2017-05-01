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
echo '          _        _           _            _                  _            _           _           _          _          '
echo '         /\ \     / /\        _\ \         / /\               /\ \     _   /\ \        /\ \        /\ \       / /\        '
echo '         \ \ \   / /  \      /\__ \       / /  \             /  \ \   /\_\/  \ \____  /  \ \      /  \ \     / /  \       '
echo '         /\ \_\ / / /\ \__  / /_ \_\     / / /\ \           / /\ \ \_/ / / /\ \_____\/ /\ \ \    / /\ \ \   / / /\ \      '
echo '        / /\/_// / /\ \___\/ / /\/_/    / / /\ \ \         / / /\ \___/ / / /\/___  / / /\ \ \  / / /\ \_\ / / /\ \ \     '
echo '       / / /   \ \ \ \/___/ / /        / / /  \ \ \       / / /  \/____/ / /   / / / / /  \ \_\/ / /_/ / // / /  \ \ \    '
echo '      / / /     \ \ \    / / /        / / /___/ /\ \     / / /    / / / / /   / / / / /   / / / / /__\/ // / /___/ /\ \   '
echo '     / / /  _    \ \ \  / / / ____   / / /_____/ /\ \   / / /    / / / / /   / / / / /   / / / / /_____// / /_____/ /\ \  '
echo ' ___/ / /__/_/\__/ / / / /_/_/ ___/\/ /_________/\ \ \ / / /    / / /\ \ \__/ / / / /___/ / / / /\ \ \ / /_________/\ \ \ '
echo '/\__\/_/___\ \/___/ / /_______/\__\/ / /_       __\ \_/ / /    / / /  \ \___\/ / / /____\/ / / /  \ \ / / /_       __\ \_\'
echo '\/_________/\_____\/  \_______\/   \_\___\     /____/_\/_/     \/_/    \/_____/\/_________/\/_/    \_\\_\___\     /____/_/'
echo '                                                                                                                          '
echo '       ..           ________    ___    ___            _____     ________         '
echo '     , ,,,.,       |\_____  \  |\  \  /  /|          / __  \   |\  ___  \        '
echo '    .....  ..       \|___/  /| \ \  \/  / /________ |\/_|\  \  \ \____   \       '
echo '   , ,, ,.              /  / /  \ \    / /\_________\|/ \ \  \  \|____|\  \      '
echo '  .,..,,,,             /  / /__  /     \/\|_________|    \ \  \ ___ __\_\  \     '
echo '  ,,,...,,.           /__/ /\__\/  /\   \                 \ \__\\__\\_______\    '
echo ' ,,,,,,,,,            |__|/\|__/__/ /\ __\                 \|__\|__\|_______|    '
echo ' .,,,,,,,.,                    |__|/ \|__|                                       '
echo ',,,.,,,,,,,.       '
echo '  ,,.,,,.,,        '
echo '   ,,,,,..,        '
echo '     ,,,,,,,,.     '
echo '        .,,,.,,.   '
echo '        .,,,,,,    '
echo '        ,,...  '
EOT

