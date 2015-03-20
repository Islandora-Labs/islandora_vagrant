echo "Installing Fedora."

if [ -f "/vagrant/config" ]; then
  . /vagrant/config
fi

# Get install properties
cd $HOME_DIR
wget https://gist.githubusercontent.com/ruebot/d7c2298f47798adb1111/raw/e7a179dca6cd12a3c60dfa6a32ba4f522c45f52b/install.properties

# Prepare $FEDORA_HOME
mkdir /usr/local/fedora
chown tomcat7:tomcat7 /usr/local/fedora
chmod g-w /usr/local/fedora

cd $DOWNLOAD_DIR
if [ ! -f "$DOWNLOAD_DIR/fcrepo-installer-$FEDORA_VERSION.jar" ]; then
  echo "Downloading Fedora"
  # Download fcrepo
  wget -q http://downloads.sourceforge.net/project/fedora-commons/fedora/$FEDORA_VERSION/fcrepo-installer-$FEDORA_VERSION.jar
fi

java -jar fcrepo-installer-$FEDORA_VERSION.jar install.properties

# Deploy fcrepo
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/fedora.war
chown -hR tomcat7:tomcat7 $FEDORA_HOME
service tomcat7 restart
echo "Sleeping while Fedora starts for the first time."
sleep 45

# Setup XACML Policies
rm -v $FEDORA_HOME/data/fedora-xacml-policies/repository-policies/default/deny-purge-*
cd $FEDORA_HOME/data/fedora-xacml-policies/repository-policies/
git clone https://github.com/Islandora/islandora-xacml-policies.git islandora

# Setup Drupal filter
cd /tmp
if [ ! -f "$DOWNLOAD_DIR/fcrepo-drupalauthfilter-3.7.0.jar" ]; then
  wget -q -O "$DOWNLOAD_DIR/fcrepo-drupalauthfilter-3.7.0.jar" https://github.com/Islandora/islandora_drupal_filter/releases/download/v7.1.3/fcrepo-drupalauthfilter-3.7.0.jar
fi
cp -v fcrepo-drupalauthfilter-3.7.0.jar /var/lib/tomcat7/webapps/fedora/WEB-INF/lib
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/fedora/WEB-INF/lib/fcrepo-drupalauthfilter-3.7.0.jar
cd $FEDORA_HOME/server/config
curl -O https://gist.githubusercontent.com/ruebot/8ef1fd7e5dfcbf6fa1ac/raw/c57b68767fb35d936271ba211c3d563c9b23e5e2/jaas.conf
curl -O https://gist.githubusercontent.com/ruebot/21b991d02357da3e22c4/raw/05e39539dfba05869c14f74821a0f3305ab0e410/filter-drupal.xml

# Restart Tomcat
service tomcat7 restart
