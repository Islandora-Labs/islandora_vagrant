#!/bin/bash

echo "Installing GSearch"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  . "$SHARED_DIR"/configs/variables
fi

# Dependencies
cd /tmp
git clone https://github.com/discoverygarden/basic-solr-config.git
cd basic-solr-config
git checkout 4.x
cd islandora_transforms
sed -i 's#/usr/local/fedora/tomcat#/var/lib/tomcat7#g' ./*xslt

# dgi_gsearch_extensions
cd /tmp
git clone https://github.com/discoverygarden/dgi_gsearch_extensions.git
cd dgi_gsearch_extensions
mvn -q package

# Build GSearch
cd /tmp
git clone https://github.com/fcrepo3/gsearch.git
cd gsearch/FedoraGenericSearch
ant buildfromsource

# Deploy GSearch
cp -v /tmp/gsearch/FgsBuild/fromsource/fedoragsearch.war /var/lib/tomcat7/webapps

# Sleep for 75 while Tomcat restart
echo "Sleeping for 75 while Tomcat stack restarts"
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/fedoragsearch.war
sed -i 's#JAVA_OPTS="-Djava.awt.headless=true -Xmx128m -XX:+UseConcMarkSweepGC"#JAVA_OPTS="-Djava.awt.headless=true -Xmx1024m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC -Dkakadu.home=/usr/local/djatoka/bin/Linux-x86-64 -Djava.library.path=/usr/local/djatoka/lib/Linux-x86-64 -DLD_LIBRARY_PATH=/usr/local/djatoka/lib/Linux-x86-64"#g' /etc/default/tomcat7
service tomcat7 restart
sleep 75

# GSearch configurations
cd /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes
wget -q http://alpha.library.yorku.ca/fgsconfigFinal.zip
unzip fgsconfigFinal.zip

# Deploy dgi_gsearch_extensions
cp -v /tmp/dgi_gsearch_extensions/target/gsearch_extensions-0.1.1-jar-with-dependencies.jar /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/lib

# Solr & GSearch configurations
cp -v /tmp/basic-solr-config/conf/* /usr/local/solr/collection1/conf
cp -Rv /tmp/basic-solr-config/islandora_transforms/* /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/islandora_transforms
chown -hR tomcat7:tomcat7 /usr/local/solr
chown -hR tomcat7:tomcat7 /var/lib/tomcat7/webapps/fedoragsearch

# Restart Tomcat
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/fedoragsearch.war
service tomcat7 restart
