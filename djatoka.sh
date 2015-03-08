echo "Installing Djatoka"

mkdir /usr/local/djatoka
cd /tmp
wget http://downloads.sourceforge.net/project/djatoka/djatoka/1.1/adore-djatoka-1.1.tar.gz
tar -xzvf adore-djatoka-1.1.tar.gz
cd adore-djatoka-1.1
mv -v * /usr/local/djatoka
ln -s /usr/local/djatoka/bin/Linux-x86-64/kdu_compress /usr/local/bin/kdu_compress
cp -v /usr/local/djatoka/dist/adore-djatoka.war /var/lib/tomcat7/webapps
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/adore-djatoka.war

service tomcat7 restart

echo "Sleeping for 30 while Tomcat stack restarts"
sleep 30

cd /tmp
wget https://gist.githubusercontent.com/ruebot/6a58a0f3e946244d4fbc/raw/1c068e3fbb67179b90ee67c934b00d9dbdb4d973/kdu_libs.conf
mv -v /tmp/kdu_libs.conf /etc/ld.so.conf.d/kdu_libs.conf

cd /var/lib/tomcat7/webapps/djatoka/WEB-INF/classes
curl -O https://gist.githubusercontent.com/ruebot/06abc0b8373aa2f53e4a/raw/1fd9a69d5a42bb0f10ff5fc1a57dfdd5ee28da3c/log4j.properties
