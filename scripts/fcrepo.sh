echo "Installing Fedora."

# Get shared directory from VagrantFile
SHARED_DIR=$1

if [ -f "$SHARED_DIR/config" ]; then
  . $SHARED_DIR/config
fi

# Prepare $FEDORA_HOME
if [ ! -d $FEDORA_HOME ]; then
  mkdir $FEDORA_HOME
fi
chown tomcat7:tomcat7 $FEDORA_HOME
chmod g-w $FEDORA_HOME

if [ ! -f "$DOWNLOAD_DIR/fcrepo-installer-$FEDORA_VERSION.jar" ]; then
  echo "Downloading Fedora"
  # Download fcrepo
  wget -q -O "$DOWNLOAD_DIR/fcrepo-installer-$FEDORA_VERSION.jar" "http://downloads.sourceforge.net/project/fedora-commons/fedora/$FEDORA_VERSION/fcrepo-installer-$FEDORA_VERSION.jar"
fi

# Get install properties
cd $HOME_DIR
cp "$DOWNLOAD_DIR/fcrepo-installer-$FEDORA_VERSION.jar" $HOME_DIR

if [ ! -f "$DOWNLOAD_DIR/install.properties" ]; then
  wget -O "$DOWNLOAD_DIR/install.properties" https://gist.githubusercontent.com/ruebot/d7c2298f47798adb1111/raw/e7a179dca6cd12a3c60dfa6a32ba4f522c45f52b/install.properties
fi

cp "$DOWNLOAD_DIR/install.properties" $HOME_DIR
java -jar fcrepo-installer-$FEDORA_VERSION.jar install.properties

if [ $? -ne 0 ]; then
  # Had a corrupt jarfile in cache, if can't install then redownload it
  echo "Problem with jar file, redownloading"
  rm -f "$DOWNLOAD_DIR/fcrepo-installer-$FEDORA_VERSION.jar" 
  wget -q -O "$DOWNLOAD_DIR/fcrepo-installer-$FEDORA_VERSION.jar" "http://downloads.sourceforge.net/project/fedora-commons/fedora/$FEDORA_VERSION/fcrepo-installer-$FEDORA_VERSION.jar"
  cp "$DOWNLOAD_DIR/fcrepo-installer-$FEDORA_VERSION.jar" $HOME_DIR
  java -jar fcrepo-installer-$FEDORA_VERSION.jar install.properties
fi

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
cp -v "$DOWNLOAD_DIR/fcrepo-drupalauthfilter-3.7.0.jar" /var/lib/tomcat7/webapps/fedora/WEB-INF/lib
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/fedora/WEB-INF/lib/fcrepo-drupalauthfilter-3.7.0.jar
cd $FEDORA_HOME/server/config
curl -O https://gist.githubusercontent.com/ruebot/8ef1fd7e5dfcbf6fa1ac/raw/c57b68767fb35d936271ba211c3d563c9b23e5e2/jaas.conf
curl -O https://gist.githubusercontent.com/ruebot/21b991d02357da3e22c4/raw/05e39539dfba05869c14f74821a0f3305ab0e410/filter-drupal.xml

# Restart Tomcat
service tomcat7 restart
