echo "Installing all Islandora Foundation modules"

cd ~
wget https://raw.githubusercontent.com/ruebot/islandora-release-manager-helper-scripts/7.x-1.5/islandora-module-list-sans-tuque.txt

cd /var/www/html/drupal/sites/all/modules

cat ~/islandora-module-list.txt | while read line; do
  git clone https://github.com/Islandora/$line
done

cd /var/www/html/drupal/sites/all/libraries
git clone https://github.com/Islandora/tuque
