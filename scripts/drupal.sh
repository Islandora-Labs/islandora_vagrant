echo "Installing Drupal."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/config" ]; then
  . $SHARED_DIR/config
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

# Enable proxy module
ln -s /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/proxy.load

# Set document root
sed -i 's|DocumentRoot /var/www/html$|DocumentRoot /var/www/html/drupal|' /etc/apache2/sites-enabled/000-default.conf

# Set override for drupal directory
# Now inserting into VirtualHost container - whikloj (2015-04-30)
if [ $(grep -c "ProxyPass" /etc/apache2/sites-enabled/000-default.conf) -eq 0 ]; then
  sed -i '/<\/VirtualHost>/i \
\t<Directory /var/www/html/drupal>\
\t\tOptions Indexes FollowSymLinks\
\t\tAllowOverride All\
\t\tRequire all granted\
\t</Directory>\
\tProxyPass /fedora/get http://localhost:8080/fedora/get\
\tProxyPassReverse /fedora/get http://localhost:8080/fedora/get\
\tProxyPass /fedora/services http://localhost:8080/fedora/services\
\tProxyPassReverse /fedora/services http://localhost:8080/fedora/services\
\tProxyPass /fedora/describe http://localhost:8080/fedora/describe\
\tProxyPassReverse /fedora/describe http://localhost:8080/fedora/describe\
\tProxyPass /fedora/risearch http://localhost:8080/fedora/risearch\
\tProxyPassReverse /fedora/risearch http://localhost:8080/fedora/risearch\
\tProxyPass /adore-djatoka http://localhost:8080/adore-djatoka\
\tProxyPassReverse /adore-djatoka http://localhost:8080/adore-djatoka' /etc/apache2/sites-enabled/000-default.conf
fi


# Torch the default index.html
rm /var/www/html/index.html

# Cycle apache
service apache2 restart

# Make the modules directory
if [ ! -d sites/all/modules ]; then
  mkdir -p sites/all/modules
fi
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
