FROM ubuntu:14.04
MAINTAINER Simon Schröer

#
# install dependencies
#
RUN apt-get update && apt-get install -y curl nano \
    php5-cli php5-apcu php5-curl php5-json php5-fpm php5-intl php5-mysqlnd && \
    mkdir -p /var/www && \
    rm -rf /etc/php5/fpm/pool.d/*

#
# install xDebug and Java
#
RUN apt-get install -y php5-xdebug openjdk-7-jre

#
# create data volume volume
#
RUN mkdir -p /var/storage && chown -R www-data:www-data /var/storage
VOLUME ["/var/storage"]

#
# copy scripts
#
COPY entrypoint.sh /entrypoint.sh
COPY xdebug_switch.sh /xdebug_switch.sh
COPY assets.sh /assets.sh

#
# copy config files
#
COPY xdebug_fpm.ini /etc/php5/mods-available/xdebug.fpm.ini
COPY xdebug_cli.ini /etc/php5/mods-available/xdebug.cli.ini
COPY www.conf /etc/php5/fpm/pool.d/www.conf
COPY php.ini /etc/php5/fpm/php.ini
COPY php.ini /etc/php5/cli/php.ini

#
# make scripts executable
#
RUN chmod +x /entrypoint.sh
RUN chmod +x /xdebug_switch.sh
RUN chmod +x /assets.sh

#
# port-configuration
#
EXPOSE 9000

#
# default entrypoint
#
CMD ["/entrypoint.sh"]
