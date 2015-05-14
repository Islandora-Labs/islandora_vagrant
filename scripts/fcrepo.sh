echo "Preparing to install Fedora."

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

echo "Downloading Fedora"
wget -q -O "/tmp/fcrepo-installer-$FEDORA_VERSION.jar" "http://downloads.sourceforge.net/project/fedora-commons/fedora/$FEDORA_VERSION/fcrepo-installer-$FEDORA_VERSION.jar"

echo "Downloading Fedora's install.properties file"
wget -q -O "/tmp/install.properties" "https://gist.githubusercontent.com/ruebot/d7c2298f47798adb1111/raw/e7a179dca6cd12a3c60dfa6a32ba4f522c45f52b/install.properties"

echo "Installing Fedora"
java -jar /tmp/fcrepo-installer-$FEDORA_VERSION.jar /tmp/install.properties

# Check the exit code from the installation process
if [ $? -ne 0 ]; then
  # Had a corrupt jarfile in cache, if can't install then redownload it
  echo "Problem with jar file, redownloading"
  wget -q -O "/tmp/fcrepo-installer-$FEDORA_VERSION.jar" "http://downloads.sourceforge.net/project/fedora-commons/fedora/$FEDORA_VERSION/fcrepo-installer-$FEDORA_VERSION.jar"
  java -jar /tmp/fcrepo-installer-$FEDORA_VERSION.jar /tmp/install.properties

  if [ $? -ne 0 ]; then
    echo "Failed a second time to install from the Fedora jar... Can't proceed!"
    exit 1
  fi
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

# Work around for issue #32 : Authentication error with Fedora API-M
# This probably isn't ideal, and I'm not sure if this is just an issue of working from a local desktop to vagrant vm, or something else sinister.
sed -i 's|<AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">0:0:0:0:0:0:0:1%.+</AttributeValue>|<AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}</AttributeValue>|'  /usr/local/fedora/data/fedora-xacml-policies/repository-policies/default/deny-apim-if-not-localhost.xml

# Setup Drupal filter
wget -q -O "/tmp/fcrepo-drupalauthfilter-$FEDORA_VERSION.jar" https://github.com/Islandora/islandora_drupal_filter/releases/download/v7.1.3/fcrepo-drupalauthfilter-$FEDORA_VERSION.jar
cp -v "/tmp/fcrepo-drupalauthfilter-$FEDORA_VERSION.jar" /var/lib/tomcat7/webapps/fedora/WEB-INF/lib
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/fedora/WEB-INF/lib/fcrepo-drupalauthfilter-$FEDORA_VERSION.jar
cd $FEDORA_HOME/server/config
curl -O https://gist.githubusercontent.com/ruebot/8ef1fd7e5dfcbf6fa1ac/raw/c57b68767fb35d936271ba211c3d563c9b23e5e2/jaas.conf
curl -O https://gist.githubusercontent.com/ruebot/21b991d02357da3e22c4/raw/05e39539dfba05869c14f74821a0f3305ab0e410/filter-drupal.xml

# Restart Tomcat
service tomcat7 restart
