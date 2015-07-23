# Change Log

## [Unreleased](https://github.com/Islandora-Labs/islandora_vagrant/tree/HEAD)

[Full Changelog](https://github.com/Islandora-Labs/islandora_vagrant/compare/1.4...HEAD)

**Closed issues:**

- default/files is not writable by the www-data [\#82](https://github.com/Islandora-Labs/islandora_vagrant/issues/82)

## [1.4](https://github.com/Islandora-Labs/islandora_vagrant/tree/1.4) (2015-07-23)

[Full Changelog](https://github.com/Islandora-Labs/islandora_vagrant/compare/1.3...1.4)

**Implemented enhancements:**

- drush dcs doesn't work [\#72](https://github.com/Islandora-Labs/islandora_vagrant/issues/72)

- Clean up /var/www/drupal file/dir permissions [\#67](https://github.com/Islandora-Labs/islandora_vagrant/issues/67)

- Add shebangs to each shell script [\#55](https://github.com/Islandora-Labs/islandora_vagrant/issues/55)

- Make the Apache Document Root configurable [\#26](https://github.com/Islandora-Labs/islandora_vagrant/issues/26)

**Fixed bugs:**

- Tomcat users settings reset at the end of install/configure process [\#81](https://github.com/Islandora-Labs/islandora_vagrant/issues/81)

- chmod modifies git working directories in Islandora modules [\#78](https://github.com/Islandora-Labs/islandora_vagrant/issues/78)

- Editing through Fedora's Flash admin client is broken [\#66](https://github.com/Islandora-Labs/islandora_vagrant/issues/66)

**Merged pull requests:**

- Set JAVA\_HOME for system and prior to Tomcat install [\#64](https://github.com/Islandora-Labs/islandora_vagrant/pull/64) ([ksclarke](https://github.com/ksclarke))

- Fix \#26 - Make Apache document root configurable [\#61](https://github.com/Islandora-Labs/islandora_vagrant/pull/61) ([ksclarke](https://github.com/ksclarke))

- Address \#74 [\#75](https://github.com/Islandora-Labs/islandora_vagrant/pull/75) ([mjordan](https://github.com/mjordan))

- Address \#72. [\#73](https://github.com/Islandora-Labs/islandora_vagrant/pull/73) ([mjordan](https://github.com/mjordan))

- added options for using drush make and disabling portforwarding [\#71](https://github.com/Islandora-Labs/islandora_vagrant/pull/71) ([lo5an](https://github.com/lo5an))

- added close paren to  tesseract  [\#68](https://github.com/Islandora-Labs/islandora_vagrant/pull/68) ([lo5an](https://github.com/lo5an))

- Revert "Set JAVA\_HOME for system and prior to Tomcat install" [\#63](https://github.com/Islandora-Labs/islandora_vagrant/pull/63) ([ruebot](https://github.com/ruebot))

- Set JAVA\_HOME for system and prior to Tomcat install [\#62](https://github.com/Islandora-Labs/islandora_vagrant/pull/62) ([ksclarke](https://github.com/ksclarke))

## [1.3](https://github.com/Islandora-Labs/islandora_vagrant/tree/1.3) (2015-05-22)

[Full Changelog](https://github.com/Islandora-Labs/islandora_vagrant/compare/1.2...1.3)

**Implemented enhancements:**

- Move wget/curl calls to gists to config directory [\#57](https://github.com/Islandora-Labs/islandora_vagrant/issues/57)

- vagrant up dies when installing FITS [\#54](https://github.com/Islandora-Labs/islandora_vagrant/issues/54)

- Add Drupal sniffer files for phpcs [\#43](https://github.com/Islandora-Labs/islandora_vagrant/issues/43)

- Update to Java 8 [\#39](https://github.com/Islandora-Labs/islandora_vagrant/issues/39)

**Fixed bugs:**

- Seeing an error in drupal module enabling due to islandora\_openseadragon [\#59](https://github.com/Islandora-Labs/islandora_vagrant/issues/59)

- vagrant up dies when installing FITS [\#54](https://github.com/Islandora-Labs/islandora_vagrant/issues/54)

- UI for purging objects is missing [\#52](https://github.com/Islandora-Labs/islandora_vagrant/issues/52)

- vagrant provision fails because symlink already exists [\#50](https://github.com/Islandora-Labs/islandora_vagrant/issues/50)

- Enabling islandora\_ingest\_test wreaks havoc with ingest forms [\#47](https://github.com/Islandora-Labs/islandora_vagrant/issues/47)

**Merged pull requests:**

- Add option to run a custom script from vagrantfile [\#60](https://github.com/Islandora-Labs/islandora_vagrant/pull/60) ([ksclarke](https://github.com/ksclarke))

- Fixed default value for path to FITS. [\#46](https://github.com/Islandora-Labs/islandora_vagrant/pull/46) ([mjordan](https://github.com/mjordan))

- Added code to scripts/islandora\_modules.sh to parse the islandora.dru… [\#45](https://github.com/Islandora-Labs/islandora_vagrant/pull/45) ([mjordan](https://github.com/mjordan))

- Update to using Drush Make [\#44](https://github.com/Islandora-Labs/islandora_vagrant/pull/44) ([ksclarke](https://github.com/ksclarke))

- Fix various small housekeeping issues [\#42](https://github.com/Islandora-Labs/islandora_vagrant/pull/42) ([ksclarke](https://github.com/ksclarke))

- Address Issue 54. [\#56](https://github.com/Islandora-Labs/islandora_vagrant/pull/56) ([mjordan](https://github.com/mjordan))

- Address \#50. [\#51](https://github.com/Islandora-Labs/islandora_vagrant/pull/51) ([mjordan](https://github.com/mjordan))

- Fix error associated with zsh man pages and silence curl and maven [\#49](https://github.com/Islandora-Labs/islandora_vagrant/pull/49) ([ksclarke](https://github.com/ksclarke))

- Address \#47. [\#48](https://github.com/Islandora-Labs/islandora_vagrant/pull/48) ([mjordan](https://github.com/mjordan))

- Add devtools used by ant [\#41](https://github.com/Islandora-Labs/islandora_vagrant/pull/41) ([ksclarke](https://github.com/ksclarke))

- Fix stdin errors [\#40](https://github.com/Islandora-Labs/islandora_vagrant/pull/40) ([ksclarke](https://github.com/ksclarke))

## [1.2](https://github.com/Islandora-Labs/islandora_vagrant/tree/1.2) (2015-05-11)

[Full Changelog](https://github.com/Islandora-Labs/islandora_vagrant/compare/v1.1...1.2)

**Implemented enhancements:**

- Upgrade Tesseract to 3.03 [\#37](https://github.com/Islandora-Labs/islandora_vagrant/issues/37)

- Update FITS [\#36](https://github.com/Islandora-Labs/islandora_vagrant/issues/36)

- Tesseract doesn't have any languages installed [\#31](https://github.com/Islandora-Labs/islandora_vagrant/issues/31)

- Move drush library installers to .drush [\#24](https://github.com/Islandora-Labs/islandora_vagrant/issues/24)

- Caching bigger downloads on the host machine would speed up rebuild times for the vm [\#21](https://github.com/Islandora-Labs/islandora_vagrant/issues/21)

- Add a config.sh for shared variables between provisioner scripts [\#20](https://github.com/Islandora-Labs/islandora_vagrant/issues/20)

**Fixed bugs:**

- Openseadragon doesn't work [\#33](https://github.com/Islandora-Labs/islandora_vagrant/issues/33)

- Authentication error with Fedora API-M [\#32](https://github.com/Islandora-Labs/islandora_vagrant/issues/32)

**Merged pull requests:**

- Missing some modules and some proxy configuration [\#35](https://github.com/Islandora-Labs/islandora_vagrant/pull/35) ([whikloj](https://github.com/whikloj))

- Add in proxy module and ProxyPass lines, ... [\#34](https://github.com/Islandora-Labs/islandora_vagrant/pull/34) ([whikloj](https://github.com/whikloj))

- Small fixes [\#30](https://github.com/Islandora-Labs/islandora_vagrant/pull/30) ([whikloj](https://github.com/whikloj))

- Update .gitignore [\#28](https://github.com/Islandora-Labs/islandora_vagrant/pull/28) ([whikloj](https://github.com/whikloj))

- This might be overkill... [\#25](https://github.com/Islandora-Labs/islandora_vagrant/pull/25) ([whikloj](https://github.com/whikloj))

- updates for  vmware fusion [\#19](https://github.com/Islandora-Labs/islandora_vagrant/pull/19) ([lo5an](https://github.com/lo5an))

## [v1.1](https://github.com/Islandora-Labs/islandora_vagrant/tree/v1.1) (2015-03-17)

[Full Changelog](https://github.com/Islandora-Labs/islandora_vagrant/compare/1.0...v1.1)

**Implemented enhancements:**

- Islandora module configurations -- post install [\#15](https://github.com/Islandora-Labs/islandora_vagrant/issues/15)

- php.ini templating [\#13](https://github.com/Islandora-Labs/islandora_vagrant/issues/13)

**Fixed bugs:**

- Sleuthkit [\#18](https://github.com/Islandora-Labs/islandora_vagrant/issues/18)

- BagItPHP missing [\#17](https://github.com/Islandora-Labs/islandora_vagrant/issues/17)

- Post install -- Drupal status [\#16](https://github.com/Islandora-Labs/islandora_vagrant/issues/16)

- Unable to locate executable at /usr/bin/kdu\_compress [\#14](https://github.com/Islandora-Labs/islandora_vagrant/issues/14)

## [1.0](https://github.com/Islandora-Labs/islandora_vagrant/tree/1.0) (2015-03-11)

**Implemented enhancements:**

- Build and deploy DGI GSearch extensions [\#12](https://github.com/Islandora-Labs/islandora_vagrant/issues/12)

**Fixed bugs:**

- GSearch - DGI extensions, and update xslts [\#11](https://github.com/Islandora-Labs/islandora_vagrant/issues/11)

**Closed issues:**

- Install disk image solution pack dependancies [\#10](https://github.com/Islandora-Labs/islandora_vagrant/issues/10)

- Drupal and Islandora PHP dependencies [\#9](https://github.com/Islandora-Labs/islandora_vagrant/issues/9)

- Install FFmpeg [\#8](https://github.com/Islandora-Labs/islandora_vagrant/issues/8)

- Install Tesseract [\#7](https://github.com/Islandora-Labs/islandora_vagrant/issues/7)

- Install FITS [\#6](https://github.com/Islandora-Labs/islandora_vagrant/issues/6)

- Install warctools [\#5](https://github.com/Islandora-Labs/islandora_vagrant/issues/5)

- Install Islandora modules [\#4](https://github.com/Islandora-Labs/islandora_vagrant/issues/4)

- Add Djatoka install script [\#3](https://github.com/Islandora-Labs/islandora_vagrant/issues/3)

- Add GSearch install script [\#2](https://github.com/Islandora-Labs/islandora_vagrant/issues/2)

- Add Solr install script \(4.2.0\) [\#1](https://github.com/Islandora-Labs/islandora_vagrant/issues/1)



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*