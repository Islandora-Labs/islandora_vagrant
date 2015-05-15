###
# BASICS
###

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  . $SHARED_DIR/configs/variables
fi

if [ ! -d "$DOWNLOAD_DIR" ]; then
  mkdir -p $DOWNLOAD_DIR
fi

# Set apt-get for non-interactive mode
export DEBIAN_FRONTEND=noninteractive

# Update
apt-get -y update && apt-get -y upgrade

# SSH
apt-get -y install openssh-server

# Build tools
apt-get -y install build-essential automake libtool

# Git vim
apt-get -y install git vim

# Java (Oracle)
apt-get install -y software-properties-common
apt-get install -y python-software-properties
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
apt-get install -y oracle-java8-installer
update-java-alternatives -s java-8-oracle
apt-get install -y oracle-java8-set-default

# Maven
apt-get -y install maven

# Tomcat
apt-get -y install tomcat7 tomcat7-admin
usermod -a -G tomcat7 vagrant
sed -i '$i<user username="islandora" password="islandora" roles="manager-gui"/>' /etc/tomcat7/tomcat-users.xml

# Set JAVA_HOME -- Java8 set-default does not seem to do this.
sed -i 's|#JAVA_HOME=/usr/lib/jvm/openjdk-6-jdk|JAVA_HOME=/usr/lib/jvm/java-8-oracle|g' /etc/default/tomcat7

# Wget and curl
apt-get -y install wget curl

# More helpful packages
apt-get -y install htop tree zsh #fish

# Set some params so it's non-interactive for the lamp-server install
debconf-set-selections <<< 'mysql-server mysql-server/root_password password islandora'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password islandora'
debconf-set-selections <<< "postfix postfix/mailname string islandora-vagrant.org"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"

# Lamp server
tasksel install lamp-server
usermod -a -G www-data vagrant

echo "CREATE DATABASE fedora3" | mysql -uroot -pislandora
echo "CREATE USER 'fedoraAdmin'@'localhost' IDENTIFIED BY 'fedoraAdmin'" | mysql -uroot -pislandora
echo "GRANT ALL ON fedora3.* TO 'fedoraAdmin'@'localhost'" | mysql -uroot -pislandora
echo "flush privileges" | mysql -uroot -pislandora

# Add vagrant user to Apache user's group
usermod -a -G www-data vagrant
