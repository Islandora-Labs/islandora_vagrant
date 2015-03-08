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
