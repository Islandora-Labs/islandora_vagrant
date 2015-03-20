echo "Installing Drupal."

if [ -f "/vagrant/config" ]; then
  . /vagrant/config
fi

# Drush and drupal deps
apt-get -y install php5-gd php5-dev php5-xsl php-soap php5-curl php5-imagick imagemagick lame libimage-exiftool-perl bibutils poppler-utils
pecl install uploadprogress
sed -i '/; extension_dir = "ext"/ a\ extension=uploadprogress.so' /etc/php5/apache2/php.ini
apt-get -y install drush
a2enmod rewrite
service apache2 reload
cd /var/www/html

# Download Drupal
drush dl drupal --drupal-project-rename=drupal

# Permissions
chown -R www-data:www-data drupal
chmod -R g+w drupal

# Do the install
cd drupal
drush si -y --db-url=mysql://root:islandora@localhost/drupal7 --site-name=islandora-development.org
drush user-password admin --password=islandora

# Set document root
sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/drupal|' /etc/apache2/sites-enabled/000-default.conf

# Set override for drupal directory
# TODO Don't do this in main apache conf
sed -i '$i<Directory /var/www/html/drupal>' /etc/apache2/apache2.conf
sed -i '$i\\tOptions Indexes FollowSymLinks' /etc/apache2/apache2.conf
sed -i '$i\\tAllowOverride All' /etc/apache2/apache2.conf
sed -i '$i\\tRequire all granted' /etc/apache2/apache2.conf
sed -i '$i</Directory>' /etc/apache2/apache2.conf

# Torch the default index.html
rm /var/www/html/index.html

# Cycle apache
service apache2 restart

# Make the modules directory
mkdir -p sites/all/modules
cd sites/all/modules

# Modules
drush dl devel imagemagick ctools jquery_update pathauto xmlsitemap views variable token libraries
drush -y en devel imagemagick ctools jquery_update pathauto xmlsitemap views variable token libraries

# php.ini templating
upload_max_filesize==500M
post_max_size==500M
max_execution_time==100
max_input_time==100

for key in upload_max_filesize post_max_size max_execution_time max_input_time
do
  sed -i "s/^\($key\).*/\1 $(eval echo \${$key})/" /etc/php5/apache2/php.ini
done

service apache2 restart

# sites/default/files ownership
chown -hR www-data:www-data /var/www/html/drupal/sites/default/files

# Run cron
cd /var/www/html/drupal/sites/all/modules
drush cron
