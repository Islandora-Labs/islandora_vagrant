echo "Installing Solr"

SOLR_HOME=/usr/local/solr
SOLR_VERSION=4.2.0

# Download Solr
cd /tmp
wget http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz
tar -xzvf solr-$SOLR_VERSION.tgz

# Prepare SOLR_HOME
mkdir $SOLR_HOME
cd /tmp/solr-$SOLR_VERSION/example/solr
mv -v * $SOLR_HOME
chown -hR tomcat7:tomcat7 $SOLR_HOME

# Deploy Solr
cp -v /tmp/solr-$SOLR_VERSION/dist/solr-4.2.0.war /var/lib/tomcat7/webapps/solr.war
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/solr.war
ln -s $SOLR_HOME /var/lib/tomcat7/solr

# Restart Tomcat
service tomcat7 restart
