echo "Installing Fedora."

HOME_DIR=$1
FEDORA_VERSION=3.8.0

# Get install properties
cd $HOME_DIR
wget https://gist.githubusercontent.com/ruebot/d7c2298f47798adb1111/raw/e7a179dca6cd12a3c60dfa6a32ba4f522c45f52b/install.properties

# Prepare $FEDORA_HOME
mkdir /usr/local/fedora
chown tomcat7:tomcat7 /usr/local/fedora
chmod g-w /usr/local/fedora

# Download fcrepo
wget http://downloads.sourceforge.net/project/fedora-commons/fedora/$FEDORA_VERSION/fcrepo-installer-$FEDORA_VERSION.jar
java -jar fcrepo-installer-$FEDORA_VERSION.jar install.properties

# Deploy fcrepo
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/fedora.war
chown -hR tomcat7:tomcat7 /usr/local/fedora
service tomcat7 restart
echo "Sleeping while Fedora starts for the first time."
sleep 45

# Setup XACML Policies
rm -v /usr/local/fedora/data/fedora-xacml-policies/repository-policies/default/deny-purge-*
cd /usr/local/fedora/data/fedora-xacml-policies/repository-policies/
git clone https://github.com/Islandora/islandora-xacml-policies.git islandora

# Setup Drupal filter
cd /tmp
wget https://github.com/Islandora/islandora_drupal_filter/releases/download/v7.1.3/fcrepo-drupalauthfilter-3.7.0.jar
mv -v fcrepo-drupalauthfilter-3.7.0.jar /var/lib/tomcat7/webapps/fedora/WEB-INF/lib
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/fedora/WEB-INF/lib/fcrepo-drupalauthfilter-3.7.0.jar
cd /usr/local/fedora/server/config
curl -O https://gist.githubusercontent.com/ruebot/8ef1fd7e5dfcbf6fa1ac/raw/c57b68767fb35d936271ba211c3d563c9b23e5e2/jaas.conf
curl -O https://gist.githubusercontent.com/ruebot/21b991d02357da3e22c4/raw/05e39539dfba05869c14f74821a0f3305ab0e410/filter-drupal.xml

# Restart Tomcat
service tomcat7 restart
