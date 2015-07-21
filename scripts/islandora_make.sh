#!/bin/bash

echo "Installing Islandora Foundation modules and dependencies via makefile"

SHARED_DIR=$1

if [ -f "$SHARED_DIR"/configs/variables ]; then
  . "$SHARED_DIR"/configs/variables
fi

cd "$DRUPAL_HOME"/sites/all

if [ ! -d libraries ]; then
  mkdir libraries
fi


# install drupal.org modules
echo "APPLYING drupal.make"
drush make --yes --no-core --contrib-destination=. "$SHARED_DIR"/configs/drupal.make

# install islandora foundation modules and library dependencies
echo "APPLYING islandora-HEAD.make"
drush make --yes --no-core --contrib-destination=. "$SHARED_DIR"/configs/islandora-HEAD.make

# Permissions and ownership
chown -hR www-data:www-data "$DRUPAL_HOME"/sites/all/libraries
chown -hR www-data:www-data "$DRUPAL_HOME"/sites/all/modules
chmod -R 775 "$DRUPAL_HOME"/sites/all/libraries
chmod -R 775 "$DRUPAL_HOME"/sites/all/modules
