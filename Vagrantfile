# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  
  config.vm.hostname = "islandora"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  config.vm.network :forwarded_port, guest: 8080, host: 8080 # Tomcat
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # MySQL
  config.vm.network :forwarded_port, guest: 80, host: 8000 # Apache

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", '3000']
    vb.customize ["modifyvm", :id, "--cpus", "2"]   
  end

  config.vm.provider "vmware_fusion" do |v, override|
    override.vm.box = "phusion/ubuntu-14.04-amd64"
    override.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vmwarefusion.box"

    v.vmx["memsize"] = "3000"
    v.vmx["numvcpus"] = "2"
  end

  home_dir = "/home/vagrant"

  config.vm.provision :shell, :path => "bootstrap.sh", :args => home_dir
  config.vm.provision :shell, :path => "fits.sh"
  config.vm.provision :shell, :path => "fcrepo.sh", :args => home_dir
  config.vm.provision :shell, :path => "djatoka.sh"
  config.vm.provision :shell, :path => "solr.sh"
  config.vm.provision :shell, :path => "gsearch.sh"
  config.vm.provision :shell, :path => "drupal.sh", :args => home_dir
  config.vm.provision :shell, :path => "islandora_modules.sh"
  config.vm.provision :shell, :path => "tesseract.sh"
  config.vm.provision :shell, :path => "ffmpeg.sh"
  config.vm.provision :shell, :path => "warctools.sh"
  config.vm.provision :shell, :path => "sleuthkit.sh"
end
