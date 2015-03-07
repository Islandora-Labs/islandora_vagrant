###
# BASICS
###

HOME_DIR=$1

cd $HOME_DIR

# Update
apt-get -y update && apt-get -y upgrade

# SSH
apt-get -y install openssh-server

# Build tools
apt-get -y install build-essential

# Git vim
apt-get -y install git vim

# Java (Oracle)
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-java7-installer
sudo update-java-alternatives -s java-7-oracle
sudo apt-get install -y oracle-java7-set-default

# Maven
apt-get -y install maven

# Tomcat
apt-get -y install tomcat7 tomcat7-admin
usermod -a -G tomcat7 vagrant
sed -i '$i<user username="islandora" password="islandora" roles="manager-gui"/>' /etc/tomcat7/tomcat-users.xml

# Wget and curl
apt-get -y install wget curl

# More helpful packages
apt-get -y install htop tree zsh fish

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
