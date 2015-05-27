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

  if ENV['VM_FORWARDPORTS'] != 'FALSE'
    config.vm.network :forwarded_port, guest: 8080, host: 8080 # Tomcat
    config.vm.network :forwarded_port, guest: 3306, host: 3306 # MySQL
    config.vm.network :forwarded_port, guest: 8000, host: 8000 # Apache
  end

  
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

  shared_dir = "/vagrant"

  config.vm.provision :shell, inline: "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile", :privileged =>false
  config.vm.provision :shell, path: "./scripts/bootstrap.sh", :args => shared_dir
  config.vm.provision :shell, path: "./scripts/devtools.sh", :args => shared_dir
  config.vm.provision :shell, path: "./scripts/fits.sh", :args => shared_dir
  config.vm.provision :shell, path: "./scripts/fcrepo.sh", :args => shared_dir
  config.vm.provision :shell, path: "./scripts/djatoka.sh", :args => shared_dir
  config.vm.provision :shell, path: "./scripts/solr.sh", :args => shared_dir
  config.vm.provision :shell, path: "./scripts/gsearch.sh", :args => shared_dir
  config.vm.provision :shell, path: "./scripts/drupal.sh", :args => shared_dir


  if ENV['VM_USEMAKE'] == 'TRUE'
    # install islandora modules and dependencies from makefile
    config.vm.provision :shell, path: "./scripts/islandora_make.sh", :args => shared_dir 
  else
    ## install islandora modules and dependencies 
    config.vm.provision :shell, path: "./scripts/islandora_modules.sh", :args => shared_dir, :privileged => false
    config.vm.provision :shell, path: "./scripts/islandora_libraries.sh", :args => shared_dir, :privileged => false
  end

  config.vm.provision :shell, path: "./scripts/islandora_enable.sh", :args => shared_dir

  config.vm.provision :shell, path: "./scripts/tesseract.sh", :args => shared_dir
  config.vm.provision :shell, path: "./scripts/ffmpeg.sh", :args => shared_dir
  config.vm.provision :shell, path: "./scripts/warctools.sh", :args => shared_dir
  config.vm.provision :shell, path: "./scripts/sleuthkit.sh", :args => shared_dir

  if File.exist?("./scripts/custom.sh") then
    config.vm.provision :shell, path: "./scripts/custom.sh", :args => shared_dir
  end
end
