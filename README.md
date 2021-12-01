[<img width="956" alt="Screen Shot 2021-08-11 at 1 20 55 PM" src="https://user-images.githubusercontent.com/2738244/129074556-76f3c3ca-e1b1-4e45-8da0-b07fc8ffdb35.png">](https://islandora.github.io/documentation/)
<hr>This documentation covers the latest release of Islandora 7.x. For the very latest in Islandora, we recommend [Islandora 8 (also known as 2.x.x)](https://islandora.github.io/documentation/). Community switch to semantic versioning instead of tying to Drupal Version.
- [Docker Version of Islandora 2.0](https://github.com/Islandora-Devops/isle-dc)
- [Ansible Version of Islandora 2.0](https://github.com/Islandora-Devops/islandora-playbook)

# Islandora Vagrant [![Build Status](https://travis-ci.org/Islandora-Labs/islandora_vagrant.svg?branch=master)](https://travis-ci.org/Islandora-Labs/islandora_vagrant)

## Introduction

The is a development environment virtual machine for Islandora 7.x-1.x. It should work on any operating system that supports VirtualBox and Vagrant.

N.B. This virtual machine **should not** be used in production.


## Requirements

1. [VirtualBox](https://www.virtualbox.org/)
  * Be sure to install a version of VirtualBox that [is compatible with Vagrant](https://www.vagrantup.com/docs/virtualbox/)
2. [Vagrant](https://www.vagrantup.com/)
  * Important: be sure to install Vagrant version 2.0.3 or higher
  * If upgrading from a previous version run ```vagrant plugin update``` to avoid plugin issues
3. [git](https://git-scm.com/)

Note that virtualization must be enabled in the host machine's BIOS settings.

## Variables

### System Resources

By default the virtual machine that is built uses 3GB of RAM. Your host machine will need to be able to support that. You can override the CPU and RAM allocation by creating `ISLANDORA_VAGRANT_CPUS` and `ISLANDORA_VAGRANT_MEMORY` environment variables and setting the values. For example, on an Ubuntu host you could add to `~/.bashrc`:

```bash
export ISLANDORA_VAGRANT_CPUS=4
export ISLANDORA_VAGRANT_MEMORY=4096
```
The files involved will also exceed 10GB. Your host machine will need at least that much free storage.

### Hostname and Port Forwarding

If you use a DNS or host file management plugin with Vagrant, you may want to set a specific hostname for the virtual machine and disable port forwarding. You can do that with the `ISLANDORA_VAGRANT_HOSTNAME` and `ISLANDORA_VAGRANT_FORWARD` variables. For example:

```bash
export ISLANDORA_VAGRANT_HOSTNAME="islandora.vagrant.test"
export ISLANDORA_VAGRANT_FORWARD="FALSE"
```

## Use

1. `git clone https://github.com/islandora-labs/islandora_vagrant`
2. `cd islandora_vagrant`
3. `vagrant up`

## Connect

Note: The supplied links apply only to this local vagrant system. They could vary in other installations.

You can connect to the machine via the browser at [http://localhost:8000](http://localhost:8000).

The default Drupal login details are:
  - username: admin
  - password: islandora

MySQL:
  - username: root
  - password: islandora

[Tomcat Manager:](http://localhost:8080/manager)
  - username: islandora
  - password: islandora

[Fedora:](http://localhost:8080/fedora/) ([Fedora Admin](http://localhost:8080/fedora/admin) | [Fedora Risearch](http://localhost:8080/fedora/risearch) | [Fedora Services](http://localhost:8080/fedora/services/))
  - username: fedoraAdmin
  - password: fedoraAdmin

[GSearch:](http://localhost:8080/fedoragsearch/rest)
  - username: fedoraAdmin
  - password: fedoraAdmin

[cantaloupe admin:](http://localhost:8080/cantaloupe/admin)
  - username: admin
  - password: admin

ssh, scp, rsync:
  - username: vagrant
  - password: vagrant
  - Examples
    - `ssh -p 2222 vagrant@localhost` or `vagrant ssh`
    - `scp -P 2222 somefile.txt vagrant@localhost:/destination/path`
    - `rsync --rsh='ssh -p2222' -av somedir vagrant@localhost:/tmp`


## Environment

- Ubuntu 14.04
- Drupal 7.44
- MySQL 5.5.49
- Apache 2.4.7
- Tomcat 7.0.55.0
- Solr 4.2.0
- Fedora 3.8.1
- GSearch HEAD
- PHP 5.5.9-1ubuntu4.17
- Java 8 (Oracle)
- FITS 1.1.1
- drush 6.3.0
- jQuery 1.10.2

## Run in a multiple VM configuration
To run this vm side by side with Islandora 8 or another VM with conflicting ports do the following.

To use this configuration, you must install two Vagrant plugins.
```shell
  # For more info https://github.com/dotless-de/vagrant-vbguest
$ vagrant plugin install vagrant-vbguest

  # For more info https://github.com/cogitatio/vagrant-hostsupdater
$ vagrant plugin install vagrant-hostsupdater
```
To start this as a second VM either:
* set a enviroment variable `ISLANDORA_VAGRANT_MULTIPLE_ISLANDORAS` or
* run the following command: `ISLANDORA_VAGRANT_MULTIPLE_ISLANDORAS='TRUE' vagrant up`

You will be asked to enter your local user password. When Vagrant stops running, Islandora 7.x will be available at http://33.33.33.10:8000.
```shell
$ ISLANDORA_VAGRANT_MULTIPLE_ISLANDORAS='TRUE' vagrant up
```

#### NOTE:
`vagrant-hostsupdater` will temporarily update the host machine's `/etc/hosts` file and remove it when vagrant is destroyed.
```txt
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1       localhost
255.255.255.255 broadcasthost
::1             localhost
33.33.33.10  islandora  # VAGRANT: 67ed63b757392fOOc6a4e5Od8a6b6428 (default) / 7d727ed8-557g-4be8-9e13-589444a57754
```
Also note that each vm must be halted separately, from within the directories on the host where they were started with vagrant up.

## Maintainers

* [Don Richards](https://github.com/donrichards)
* [Ben Rosner](https://github.com/br2490)

## Authors

* [Nick Ruest](https://github.com/ruebot)
* [Jared Whiklo](https://github.com/whikloj)
* [Logan Cox](https://github.com/lo5an)
* [Kevin Clarke](https://github.com/ksclarke)
* [Mark Jordan](https://github.com/mjordan)
* [Mark Cooper](https://github.com/mark-cooper)

## Acknowledgements

This project was inspired by Ryerson University Library's [Islandora Chef](https://github.com/ryersonlibrary/islandora_chef), which was inspired by University of Toronto Libraries' [LibraryChef](https://github.com/utlib/chef-islandora). So, many thanks to [Graham Stewart](https://github.com/whitepine23), and [MJ Suhonos](http://github.com/mjsuhonos/).
