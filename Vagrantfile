# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$cpus   = ENV.fetch("ISLANDORA_VAGRANT_CPUS", "2")
$memory = ENV.fetch("ISLANDORA_VAGRANT_MEMORY", "3000")
$hostname = ENV.fetch("ISLANDORA_VAGRANT_HOSTNAME", "islandora")
$forward = ENV.fetch("ISLANDORA_VAGRANT_FORWARD", "TRUE")
$multiple_vms  = ENV.fetch("ISLANDORA_VAGRANT_MULTIPLE_ISLANDORAS", "FALSE")

Vagrant.require_version ">= 2.0.3"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  config.vm.provider "virtualbox" do |v|
    v.name = "Islandora 7.x-1.x Development VM"
  end

  config.vm.hostname = $hostname

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "islandora/islandora-base"

  # This is a RC VM, So make sure people are running the latest base box by April 2018
  # Which will include cantaloupe IIIF Image Server
   config.vm.box_version = "1.0.9"
   config.vm.box_check_update = true

  # This checks and updates VirtualBox Guest Additions.
   if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
    config.vbguest.no_remote = false
   end

  unless  $forward.eql? "FALSE"
    config.vm.network :forwarded_port, guest: 8080, host: 8080, id: 'Tomcat', auto_correct: true
    config.vm.network :forwarded_port, guest: 3306, host: 3306, id: 'MySQL', auto_correct: true
    config.vm.network :forwarded_port, guest: 8000, host: 8000, id: 'Apache', auto_correct: true
    config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct: true
  end

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", $memory]
    vb.customize ["modifyvm", :id, "--cpus", $cpus]
  end

  shared_dir = "/vagrant"
  # Moves Islandora 7.x to ipaddress instead of localhost.
  unless  $multiple_vms.eql? "FALSE"
     unless Vagrant.has_plugin?("vagrant-hostsupdater")
       raise 'vagrant-hostsupdater is not installed!'
     end
     config.vm.network :private_network, ip: "33.33.33.10"

   end

  config.vm.provision :shell, path: "./scripts/islandora_modules.sh", :args => shared_dir, :privileged => false
  config.vm.provision :shell, path: "./scripts/islandora_libraries.sh", :args => shared_dir, :privileged => false
  if File.exist?("./scripts/custom.sh") then
    config.vm.provision :shell, path: "./scripts/custom.sh", :args => shared_dir
  end
  config.vm.provision :shell, path: "./scripts/post.sh"

  unless  $multiple_vms.eql? "FALSE"
    # Fires last to modify one last change.
    config.vm.provision "this",
    type: "shell",
    preserve_order: true,
    inline: "cd /var/www/drupal && /usr/bin/drush vset islandora_paged_content_djatoka_url 'http://33.33.33.10:8080/adore-djatoka'"
  end
end
