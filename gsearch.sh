echo "Installing GSearch"

# Dependencies
cd /home/vagrant/git
git clone https://github.com/discoverygarden/basic-solr-config.git
cd basic-solr-config
git checkout 4.x

# Build GSearch
cd /tmp
git clone https://github.com/fcrepo3/gsearch.git
cd gsearch/FedoraGenericSearch
ant buildfromsource

# Deploy GSearch
cp -v /tmp/gsearch/FgsBuild/fromsource/fedoragsearch.war /var/lib/tomcat7/webapps
sudo chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/fedoragsearch.war

# GSearch configurations
cd /var/lib/tomcat7/webapps/fedoragsearch/WEB-INF/classes
wget http://alpha.library.yorku.ca/fgsconfigFinal.zip
unzip fgsconfigFinal.zip
chown -hR tomcat7:tomcat7 /var/lib/tomcat7/webapps/fedoragsearch

# Solr & GSearch configurations
cp -v /home/vagrant/git/basic-solr-config/conf/* /usr/local/solr/collection1/conf
chown -hR tomcat7:tomcat7 /usr/local/solr

# Restart Tomcat
service tomcat7 restart
