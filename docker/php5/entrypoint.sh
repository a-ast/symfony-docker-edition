#!/bin/bash

# disable xdebug by default
/xdebug_switch.sh off

# prepare the storage dir
rm -rf /var/www/storage \
       /var/www/web/js \
       /var/www/web/css \
       /var/www/web/bundles

# create storage dirs
mkdir -p /var/storage/cache \
         /var/storage/shared \
         /var/storage/shared/uploads \
         /var/storage/assetic/js \
         /var/storage/assetic/css \
         /var/storage/bundles

# link storage dirs into the symfony project
ln -s /var/storage/shared /var/www/storage
ln -s /var/storage/shared/uploads /var/www/web/uploads
ln -s /var/storage/assetic/js /var/www/web/js
ln -s /var/storage/assetic/css /var/www/web/css
ln -s /var/storage/bundles /var/www/web/bundles

# set re proper owner rights
chown -R www-data /var/storage && \
    chgrp -R www-data /var/storage && \
    chmod -R 0775 /var/storage

# start FPM in an endless loop
#
# this loop is important as the xdebug switch will kill all fpm processes after reconfiguring the php modules
# if the process gets killed, this loop will create a new one with the modified module setup so the docker container
# won't get stopped by the docker deamon
while :; do
    /usr/sbin/php5-fpm --nodaemonize
done
