#!/bin/bash

if [ "" == "$NGINX_APP_ENV" ]; then
    NGINX_APP_ENV="dev"
fi

# modify the pattern
rm -rf /etc/nginx/conf.d/default.conf
cp /etc/nginx/conf.d/default.$NGINX_APP_ENV.conf.tpl /etc/nginx/conf.d/default.conf
/bin/sed -i "s/PHP5_PORT_9000_TCP_ADDR/${PHP5_PORT_9000_TCP_ADDR}/" /etc/nginx/conf.d/default.conf

# start nginx
/usr/sbin/nginx
