#!/bin/bash

# switch into the working dir
cd /var/www

# remove exiting assets
rm -rf /var/storage/bundles/*

# create assets
php app/console assets:install web --symlink
php app/console assetic:dump --env=dev
php app/console assetic:dump --env=prod

# fix permissions
chmod -R 0775 \
        /var/storage/assetic \
        /var/storage/bundles \
        /var/www/web/bundles \
        /var/www/web/css \
        /var/www/web/js

# done
echo; echo "Assets fixed."; echo;