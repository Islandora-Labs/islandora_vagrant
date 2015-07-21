# Islandora Vagrant [![Build Status](https://travis-ci.org/Islandora-Labs/islandora_vagrant.svg?branch=master)](https://travis-ci.org/Islandora-Labs/islandora_vagrant)

## Introduction

The is a development environment virtual machine for Islandora. It should work on any operating system that supports VirtualBox and Vagrant.

The virtual machine that is built uses 3GB of RAM. Your host machine will need to be able to support that.

N.B. This virtual machine **should not** be used in production.

## Requirements

1. [VirtualBox](https://www.virtualbox.org/)
2. [Vagrant](http://www.vagrantup.com/)

## Use

1. `git clone https://github.com/islandora-labs/islandora_vagrant`
2. `cd islandora_vagrant`
3. `vagrant up`

## Connect

You can connect to the machine via the browser at [http://localhost:8000](http://localhost:8000).

The default Drupal login details are:
  - username: admin
  - password: islandora

MySQL:
  - username: root
  - password: islandora

Tomcat Manager:
  - username: islandora
  - password: islandora

Fedora:
  - username: fedoraAdmin
  - password: fedoraAdmin

GSearch:
  - username: fgsAdmin
  - password: fgsAdmin

ssh, scp, rsync:
  - username: vagrant
  - password: vagrant
  - Examples
    - `ssh -p 2222 vagrant@localhost`
    - `scp -P 2222 somefile.txt vagrant@localhost:/destination/path`
    - `rsync --rsh='ssh -p2222' -av somedir vagrant@localhost:/tmp`

## Environment

- Ubuntu 14.04
- Drupal 7.37
- MySQL 5.5.41
- Apache 2.26
- Tomcat 7.0.52
- Solr 4.2.0
- Fedora 3.8.0
- GSearch HEAD
- Islandora 7.x
- PHP 5.5.9 
- Java 8 (Oracle)

## Customization

If you'd like to add your own customization script (to install additional modules, call other scripts, etc.), you can create a `custom.sh` file in the project's `scripts` directory. When that file is present, Vagrant will run it after all the other provisioning scripts have been run.

### Islandora VM Settings

Additionally, the VM build process can be customized by setting any of the following variables:

- `IVM_FORWARDPORTS` - set to `FALSE` to disable port forwarding of web services from the guest vm to the host.
- `IVM_USEMAKE` - set to `TRUE` to use `islandora_make.sh` script instead of `islandora_modules.sh` and `islandora_libraries.sh` to install Islandora.

They can be used as environment variables, or set when starting vagrant. For example:

```bash
IVM_USEMAKE="TRUE" IVM_FORWARDPORTS="FALSE" vagrant up`. 
```

### Drush Make

When using the `IVM_USEMAKE` seting, the makefiles that are applied are determined by  `ISLANDORA_MAKEFILE` and `DRUPAL_MAKEFILE` in the `configs/variables` file.




## Authors

* [Nick Ruest](https://github.com/ruebot)
* [Jared Whiklo](https://github.com/whikloj)
* [Logan Cox](https://github.com/lo5an)
* [Kevin Clarke](https://github.com/ksclarke)
* [Mark Jordan](https://github.com/mjordan)

## Acknowledgements

This project was inspired by Ryerson University Library's [Islandora Chef](https://github.com/ryersonlibrary/islandora_chef), which was inspired by University of Toronto Libraries' [LibraryChef](https://github.com/utlib/chef-islandora). So, many thanks to [Graham Stewart](https://github.com/whitepine23), and [MJ Suhonos](http://github.com/mjsuhonos/).
