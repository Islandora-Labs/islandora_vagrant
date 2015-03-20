echo "Installing Solr"

if [ -f "/vagrant/config" ]; then
  . /vagrant/config
fi

# Download Solr
if [ ! -f "$DOWNLOAD_DIR/solr-$SOLR_VERSION.tgz" ]; then
  echo "Downloading Solr"
  wget -q -O "$DOWNLOAD_DIR/solr-$SOLR_VERSION.tgz" "http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz"
fi
cd /tmp
cp "$DOWNLOAD_DIR/solr-$SOLR_VERSION.tgz" /tmp
tar -xzvf solr-$SOLR_VERSION.tgz

# Prepare SOLR_HOME
mkdir $SOLR_HOME
cd /tmp/solr-$SOLR_VERSION/example/solr
mv -v * $SOLR_HOME
chown -hR tomcat7:tomcat7 $SOLR_HOME

# Deploy Solr
cp -v /tmp/solr-$SOLR_VERSION/dist/solr-$SOLR_VERSION.war /var/lib/tomcat7/webapps/solr.war
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/solr.war
ln -s $SOLR_HOME /var/lib/tomcat7/solr

# Restart Tomcat
service tomcat7 restart
