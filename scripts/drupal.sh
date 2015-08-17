#!/bin/bash

echo "Installing Drupal."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  . "$SHARED_DIR"/configs/variables
fi

# Set apt-get for non-interactive mode
export DEBIAN_FRONTEND=noninteractive

# Apache configuration file
export APACHE_CONFIG_FILE=/etc/apache2/sites-enabled/000-default.conf

# Drush and drupal deps
apt-get -y install php5-gd php5-dev php5-xsl php-soap php5-curl php5-imagick imagemagick lame libimage-exiftool-perl bibutils poppler-utils
pecl install uploadprogress
sed -i '/; extension_dir = "ext"/ a\ extension=uploadprogress.so' /etc/php5/apache2/php.ini
apt-get -y install drush
a2enmod rewrite
service apache2 reload
cd /var/www

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
ln -s /etc/apache2/mods-available/proxy_http.load /etc/apache2/mods-enabled/proxy_http.load
ln -s /etc/apache2/mods-available/proxy_html.load /etc/apache2/mods-enabled/proxy_html.load
ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/headers.load

# Set document root
sed -i "s|DocumentRoot /var/www/html$|DocumentRoot $DRUPAL_HOME|" $APACHE_CONFIG_FILE

# Set override for drupal directory
# Now inserting into VirtualHost container - whikloj (2015-04-30)
if [ "$(grep -c "ProxyPass" $APACHE_CONFIG_FILE)" -eq 0 ]; then

sed -i 's#<VirtualHost \*:80>#<VirtualHost \*:8000>#' $APACHE_CONFIG_FILE

sed -i 's/Listen 80/Listen \*:8000/' /etc/apache2/ports.conf

sed -i "/Listen \*:8000/a \
NameVirtualHost \*:8000" /etc/apache2/ports.conf 

read -d '' APACHE_CONFIG << APACHE_CONFIG_TEXT
	ServerAlias islandora-vagrant

	<Directory ${DRUPAL_HOME}>
		Options Indexes FollowSymLinks
		AllowOverride All
		Require all granted
	</Directory>

	ProxyRequests Off
	ProxyPreserveHost On

	<Proxy *>
		Order deny,allow
		Allow from all
	</Proxy>

	ProxyPass /fedora/get http://localhost:8080/fedora/get
	ProxyPassReverse /fedora/get http://localhost:8080/fedora/get
	ProxyPass /fedora/services http://localhost:8080/fedora/services
	ProxyPassReverse /fedora/services http://localhost:8080/fedora/services
	ProxyPass /fedora/describe http://localhost:8080/fedora/describe
	ProxyPassReverse /fedora/describe http://localhost:8080/fedora/describe
	ProxyPass /fedora/risearch http://localhost:8080/fedora/risearch
	ProxyPassReverse /fedora/risearch http://localhost:8080/fedora/risearch
	ProxyPass /adore-djatoka http://localhost:8080/adore-djatoka
	ProxyPassReverse /adore-djatoka http://localhost:8080/adore-djatoka
APACHE_CONFIG_TEXT

sed -i "/<\/VirtualHost>/i $(echo "|	$APACHE_CONFIG" | tr '\n' '|')" $APACHE_CONFIG_FILE
tr '|' '\n' < $APACHE_CONFIG_FILE > $APACHE_CONFIG_FILE.t 2> /dev/null; mv $APACHE_CONFIG_FILE{.t,}

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
drush dl devel imagemagick ctools jquery_update pathauto xmlsitemap views variable token libraries datepicker date
drush -y en devel imagemagick ctools jquery_update pathauto xmlsitemap views variable token libraries datepicker_views

drush dl coder-7.x-2.5
drush -y en coder

# php.ini templating
cp -v "$SHARED_DIR"/configs/php.ini /etc/php5/apache2/php.ini

service apache2 restart

# sites/default/files ownership
chown -hR www-data:www-data "$DRUPAL_HOME"/sites/default/files

# Run cron
cd "$DRUPAL_HOME"/sites/all/modules
drush cron
